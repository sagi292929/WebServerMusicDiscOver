import { elasticsearch } from "../elastic";
import { prisma } from "../database";
import {
  escapeWildcardSearchInput,
  formatBirthday,
} from "../shared/formatting";
import { ES_ARTIST_INDEX } from "./const";

type ArtistSource = {
  es_id: string;
  name: string;
  born_in?: string;
  former_bands?: string[];
};

async function findArtists(name: string, limit: number): Promise<ArtistSource[]> {
  const escapedName = escapeWildcardSearchInput(name);
  const query = {
    wildcard: {
      name: {
        value: `*${escapedName}*`,
        case_insensitive: true,
      },
    },
  };
  console.info("[Elasticsearch] Searching index:", ES_ARTIST_INDEX, {
    query,
  });

  const result = await elasticsearch.search({
    index: ES_ARTIST_INDEX,
    size: limit,
    query,
  });

  return result.hits.hits.map((hit) => hit._source as ArtistSource);
}

export const artistResolvers = {
  Query: {
    getArtist: async (
      _: unknown,
      { name, limit = 100 }: { name: string; limit?: number }
    ) => {
      const artists = await findArtists(name, limit);
      const databaseArtists = await prisma.artist.findMany({
        where: {
          es_id: {
            in: artists.map(({ es_id }) => es_id),
          },
        },
        include: { band: { select: { name: true } } },
      });
      const bandNames = new Map(
        databaseArtists.map((artist) => [artist.es_id, artist.band.name])
      );

      return artists.map((source) => ({
        es_id: source.es_id,
        name: source.name,
        band_name: bandNames.get(source.es_id) ?? "",
        born_in: source.born_in,
      }));
    },
    getAllAboutArtist: async (
      _: unknown,
      { name, limit = 100 }: { name: string; limit?: number }
    ) => {
      const artists = await findArtists(name, limit);

      return Promise.all(
        artists.map(async (source) => {
          const databaseArtist = await prisma.artist.findFirst({
            where: { es_id: source.es_id },
            include: {
              band: true,
              artistInstruments: { include: { instrument: true } },
            },
          });

          return {
            es_id: source.es_id,
            name: source.name,
            born_in: source.born_in,
            former_bands: source.former_bands ?? [],
            database: databaseArtist
              ? {
                  birthdate: databaseArtist.birthdate,
                  band: databaseArtist.band,
                  instruments: databaseArtist.artistInstruments.map(
                    ({ instrument }) => instrument
                  ),
                }
              : null,
          };
        })
      );
    },
  },
  ArtistDatabaseDetails: {
    birthdate: (artist: { birthdate: Date | null }) =>
      formatBirthday(artist.birthdate),
  },
};
