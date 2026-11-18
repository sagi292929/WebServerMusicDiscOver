import { elasticsearch } from "../elastic";
import { prisma } from "../database";
import { ES_ARTIST_INDEX } from "./const";

type ArtistSource = {
  es_id: string;
  name: string;
  born_in?: string;
  former_bands?: string[];
};

async function findArtists(name: string, limit: number): Promise<ArtistSource[]> {
  const escapedName = name.replace(/[\\*?]/g, "\\$&");
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
      return (await findArtists(name, limit)).map((source) => ({
        es_id: source.es_id,
        name: source.name,
        born_in: source.born_in,
        former_bands: source.former_bands ?? [],
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
              albumArtists: {
                include: {
                  album: {
                    include: {
                      albumSongs: { include: { song: true } },
                    },
                  },
                },
              },
            },
          });

          return {
            ...source,
            former_bands: source.former_bands ?? [],
            elasticsearch: {
              ...source,
              former_bands: source.former_bands ?? [],
            },
            database: databaseArtist
              ? {
                  ...databaseArtist,
                  instruments: databaseArtist.artistInstruments.map(
                    ({ instrument }) => instrument
                  ),
                  albums: databaseArtist.albumArtists.map((appearance) => ({
                    albumId: appearance.albumId,
                    album: {
                      ...appearance.album,
                      songs: appearance.album.albumSongs.map(
                        ({ song }) => song
                      ),
                    },
                  })),
                }
              : null,
          };
        })
      );
    },
  },
  ArtistDatabaseDetails: {
    birthdate: (artist: { birthdate: Date }) => artist.birthdate.toISOString(),
  },
};
