import { elasticsearch } from "../elastic";
import { config } from "../config";
import { prisma } from "../database";

type BandSource = {
  id: string;
  name: string;
  genres?: string[];
  active_years?: number[];
  albums?: unknown[];
  songs_hits?: unknown[];
  members?: unknown[];
  inserted_at?: string;
};

function toBand(source: BandSource) {
  return {
    id: source.id,
    name: source.name,
    genres: source.genres ?? [],
    active_years: source.active_years ?? [],
    albums: source.albums ?? [],
    songs_hits: source.songs_hits ?? [],
    members: source.members ?? [],
    inserted_at: source.inserted_at,
  };
}

async function fetchAllAboutBand(id: string) {
  const query = { term: { id } };
  console.info("[Elasticsearch] Searching index:", config.elasticsearch.index, {
    query,
  });

  const [result, databaseBand] = await Promise.all([
    elasticsearch.search({
      index: config.elasticsearch.index,
      size: 1,
      query,
    }),
    prisma.band.findFirst({
      where: { es_id: id },
      include: {
        albums: {
          include: {
            albumSongs: { include: { song: true } },
            albumArtists: {
              include: {
                artist: {
                  include: {
                    artistInstruments: { include: { instrument: true } },
                  },
                },
              },
            },
          },
        },
        artists: {
          include: {
            artistInstruments: { include: { instrument: true } },
          },
        },
      },
    }),
  ]);

  const source = result.hits.hits[0]?._source as BandSource | undefined;
  if (!source && !databaseBand) {
    return null;
  }

  const elasticBand = source ? toBand(source) : null;
  const databaseFallback = databaseBand
    ? {
        id: databaseBand.es_id,
        name: databaseBand.name,
        genres: [],
        active_years: [],
        albums: [],
        songs_hits: [],
        members: [],
        inserted_at: undefined,
      }
    : null;
  const band = elasticBand ?? databaseFallback;
  if (!band) {
    return null;
  }

  return {
    ...band,
    elasticsearch: elasticBand,
    database: databaseBand,
  };
}

export const bandResolvers = {
  Query: {
    getBand: async (_: unknown, { id }: { id: string }) => {
      const query = { term: { id } };
      console.info("[Elasticsearch] Searching index:", config.elasticsearch.index, {
        query,
      });

      const result = await elasticsearch.search({
        index: config.elasticsearch.index,
        size: 1,
        query,
      });

      const source = result.hits.hits[0]?._source as BandSource | undefined;
      return source ? toBand(source) : null;
    },
    getAllAboutBandDebug: async (_: unknown, { id }: { id: string }) => {
      return fetchAllAboutBand(id);
    },
    getAllAboutBand: async (_: unknown, { id }: { id: string }) => {
      return fetchAllAboutBand(id);
    },
    searchBands: async (
      _: unknown,
      { name, limit = 10 }: { name: string; limit?: number }
    ) => {
      const query = { match_phrase: { name } };
      console.info("[Elasticsearch] Searching index:", config.elasticsearch.index, {
        query,
      });

      const result = await elasticsearch.search({
        index: config.elasticsearch.index,
        size: limit,
        query,
      });

      return result.hits.hits.map((hit) =>
        toBand(hit._source as BandSource)
      );
    },
  },
  SQLArtist: {
    birthdate: (artist: { birthdate: Date }) => artist.birthdate.toISOString(),
  },
  SQLArtistSummary: {
    birthdate: (artist: { birthdate: Date }) => artist.birthdate.toISOString(),
  },
};
