import { elasticsearch } from "../elastic";
import { prisma } from "../database";
import { GraphQLScalarType, valueFromASTUntyped } from "graphql";
import {
  escapeWildcardSearchInput,
  normalizeSearchText,
  trimSearchInput,
} from "../shared/formatting";
import { ES_SONG_INDEX } from "./const";

const jsonScalar = new GraphQLScalarType({
  name: "JSON",
  serialize: (value: unknown) => value,
  parseValue: (value: unknown) => value,
  parseLiteral: (ast) => valueFromASTUntyped(ast),
});

type SongSource = {
  es_id: string;
  name: string;
  band_name: string;
};

function isSongSource(source: unknown): source is SongSource {
  if (typeof source !== "object" || source === null || Array.isArray(source)) {
    return false;
  }

  const record = source as Record<string, unknown>;
  return (
    typeof record.es_id === "string" &&
    typeof record.name === "string" &&
    typeof record.band_name === "string"
  );
}

export const songResolvers = {
  JSON: jsonScalar,
  Query: {
    getSong: async (_: unknown, { name }: { name: string }) => {
      const trimmedName = trimSearchInput(name);
      if (!trimmedName) {
        return [];
      }
      const searchTerm = normalizeSearchText(trimmedName);

      const escapedName = escapeWildcardSearchInput(trimmedName);
      const query = {
        bool: {
          should: [
            { match_phrase: { name: trimmedName } },
            {
              wildcard: {
                name: {
                  value: `*${escapedName}*`,
                  case_insensitive: true,
                },
              },
            },
          ],
          minimum_should_match: 1,
        },
      };
      console.info("[Elasticsearch] Searching index:", ES_SONG_INDEX, {
        query,
      });

      const result = await elasticsearch.search({
        index: ES_SONG_INDEX,
        size: 100,
        query,
      });

      const matches = result.hits.hits.flatMap((hit) => {
        if (!isSongSource(hit._source)) {
          console.warn("[Elasticsearch] Skipping malformed song document", {
            index: ES_SONG_INDEX,
            documentId: hit._id,
          });
          return [];
        }

        return [{
          es_id: hit._source.es_id,
          name: hit._source.name,
          band_name: hit._source.band_name,
        }];
      });
      const databaseSongs = await prisma.song.findMany({
        where: { es_id: { in: matches.map(({ es_id }) => es_id) } },
        select: { Id: true, es_id: true },
      });
      const databaseIds = new Map(
        databaseSongs.map(({ Id, es_id }) => [es_id, Id])
      );

      return matches
        .map((match) => ({
          ...match,
          database_id: databaseIds.get(match.es_id) ?? null,
        }))
        .sort((left, right) => {
          const leftPosition = normalizeSearchText(left.name).indexOf(
            searchTerm
          );
          const rightPosition = normalizeSearchText(right.name).indexOf(
            searchTerm
          );

          return (
            leftPosition - rightPosition ||
            left.name.localeCompare(right.name) ||
            left.band_name.localeCompare(right.band_name) ||
            left.es_id.localeCompare(right.es_id)
          );
        });
    },
    getAllAboutSong: async (_: unknown, { id }: { id: number }) => {
      const databaseSong = await prisma.song.findUnique({
        where: { Id: id },
      });

      if (!databaseSong) {
        return null;
      }

      let elasticSong: unknown = null;
      if (databaseSong.es_id) {
        const query = { match_phrase: { es_id: databaseSong.es_id } };
        console.info("[Elasticsearch] Searching index:", ES_SONG_INDEX, {
          query,
        });
        const result = await elasticsearch.search({
          index: ES_SONG_INDEX,
          size: 1,
          query,
        });
        elasticSong = result.hits.hits[0]?._source ?? null;
      }

      return {
        id,
        elasticsearch: elasticSong,
        database: databaseSong,
      };
    },
  },
};
