import { prisma } from "../database";
import { elasticsearch } from "../elastic";
import {
  escapeWildcardSearchInput,
  normalizeSearchText,
  trimSearchInput,
} from "../shared/formatting";
import { ES_ALBUM_INDEX } from "./const";

type AlbumSource = {
  es_id: string;
  name: string;
  band: string;
};

function isAlbumSource(source: unknown): source is AlbumSource &
  Record<string, unknown> {
  if (typeof source !== "object" || source === null || Array.isArray(source)) {
    return false;
  }

  const record = source as Record<string, unknown>;
  return (
    typeof record.es_id === "string" &&
    typeof record.name === "string" &&
    typeof record.band === "string"
  );
}

async function fetchAllAboutAlbum(id: string) {
  const query = { ids: { values: [id] } };
  console.info("[Elasticsearch] Searching index:", ES_ALBUM_INDEX, {
    query,
  });

  const result = await elasticsearch.search({
    index: ES_ALBUM_INDEX,
    size: 1,
    query,
  });
  const hit = result.hits.hits[0];
  const source = hit?._source;

  if (!hit) {
    return null;
  }
  if (!isAlbumSource(source)) {
    console.warn("[Elasticsearch] Skipping malformed album document", {
      index: ES_ALBUM_INDEX,
      documentId: hit._id,
    });
    return null;
  }

  const {
    length_seconds: _lengthSeconds,
    lengthSeconds: _lengthSecondsCamel,
    ...albumDetails
  } = source as AlbumSource & Record<string, unknown>;

  const databaseAlbum = await prisma.album.findFirst({
    where: {
      title: source.name,
      band: { is: { name: source.band } },
    },
    select: {
      Id: true,
      BandId: true,
      albumSongs: {
        include: { song: true },
        orderBy: { trackNumber: "asc" },
      },
    },
  });

  return {
    id,
    elasticsearch: albumDetails,
    database: databaseAlbum,
  };
}

export const albumResolvers = {
  Query: {
    getAlbum: async (_: unknown, { name }: { name: string }) => {
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
      console.info("[Elasticsearch] Searching index:", ES_ALBUM_INDEX, {
        query,
      });

      const result = await elasticsearch.search({
        index: ES_ALBUM_INDEX,
        size: 100,
        query,
      });

      return result.hits.hits
        .flatMap((hit) => {
          if (!isAlbumSource(hit._source)) {
            console.warn("[Elasticsearch] Skipping malformed album document", {
              index: ES_ALBUM_INDEX,
              documentId: hit._id,
            });
            return [];
          }

          return [
            {
              es_id: hit._source.es_id,
              name: hit._source.name,
              band_name: hit._source.band,
            },
          ];
        })
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
    getAllAboutAlbum: async (_: unknown, { id }: { id: string }) =>
      fetchAllAboutAlbum(id),
  },
};
