import { elasticsearch } from "../elastic";
import { prisma } from "../database";
import { ES_BAND_INDEX } from "./const";

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

function isBandSource(source: unknown): source is BandSource {
  if (typeof source !== "object" || source === null || Array.isArray(source)) {
    return false;
  }

  const record = source as Record<string, unknown>;
  return (
    typeof record.id === "string" &&
    typeof record.name === "string" &&
    (record.genres === undefined ||
      (Array.isArray(record.genres) &&
        record.genres.every((genre) => typeof genre === "string"))) &&
    (record.active_years === undefined ||
      (Array.isArray(record.active_years) &&
        record.active_years.every(
          (year) => typeof year === "number" && Number.isFinite(year)
        ))) &&
    (record.albums === undefined || Array.isArray(record.albums)) &&
    (record.songs_hits === undefined || Array.isArray(record.songs_hits)) &&
    (record.members === undefined || Array.isArray(record.members)) &&
    (record.inserted_at === undefined ||
      typeof record.inserted_at === "string")
  );
}

function warnMalformedBand(hit: { _id?: string }) {
  console.warn("[Elasticsearch] Skipping malformed band document", {
    index: ES_BAND_INDEX,
    documentId: hit._id,
  });
}

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

function formatBirthdate(artist: { birthdate?: Date | string | null }) {
  return artist.birthdate instanceof Date
    ? artist.birthdate.toISOString()
    : artist.birthdate ?? null;
}

async function fetchAllAboutBand(id: string) {
  const query = { term: { id } };
  console.info("[Elasticsearch] Searching index:", ES_BAND_INDEX, {
    query,
  });

  const [result, databaseBand] = await Promise.all([
    elasticsearch.search({
      index: ES_BAND_INDEX,
      size: 1,
      query,
    }),
    prisma.band.findFirst({
      where: { es_id: id },
      include: {
        bandGenres: {
          include: {
            genre: {
              select: { name: true },
            },
          },
        },
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

  const hit = result.hits.hits[0];
  const source = hit?._source;
  const validSource = isBandSource(source) ? source : undefined;
  if (hit && !validSource) {
    warnMalformedBand(hit);
  }

  if (!validSource && !databaseBand) {
    return null;
  }

  const elasticBand = validSource ? toBand(validSource) : null;
  const genres = Array.from(
    new Set(databaseBand?.bandGenres.map(({ genre }) => genre.name) ?? [])
  ).sort((a, b) => a.localeCompare(b));
  if (elasticBand) {
    elasticBand.genres = genres;
  }
  const databaseFallback = databaseBand
    ? {
        id: databaseBand.es_id,
        name: databaseBand.name,
        genres,
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
    genres,
    elasticsearch: elasticBand,
    database: databaseBand,
  };
}

export const bandResolvers = {
  Query: {
    getGenre: async () => {
      const genres = await prisma.genre.findMany({
        select: {
          Id: true,
          name: true,
          mainGenre: true,
        },
        orderBy: [{ mainGenre: "asc" }, { name: "asc" }],
      });

      const groups = new Map<
        string | null,
        { Id: number; name: string; main_genre: string | null }[]
      >();
      for (const genre of genres) {
        const group = groups.get(genre.mainGenre) ?? [];
        group.push({
          Id: genre.Id,
          name: genre.name,
          main_genre: genre.mainGenre,
        });
        groups.set(genre.mainGenre, group);
      }

      return Array.from(groups, ([main_genre, genres]) => ({
        main_genre,
        genres,
      }));
    },
    getBand: async (_: unknown, { name }: { name: string }) => {
      const trimmedName = name.trim();
      if (!trimmedName) {
        return [];
      }

      const query = {
        match_phrase_prefix: {
          name: {
            query: trimmedName,
          },
        },
      };
      console.info("[Elasticsearch] Searching index:", ES_BAND_INDEX, {
        query,
      });

      const result = await elasticsearch.search({
        index: ES_BAND_INDEX,
        size: 100,
        query,
      });

      return result.hits.hits.flatMap((hit) => {
        if (!isBandSource(hit._source)) {
          warnMalformedBand(hit);
          return [];
        }

        return [
          {
            id: hit._source.id,
            name: hit._source.name,
            active_years: hit._source.active_years ?? [],
          },
        ];
      });
    },
    getAllAboutBand: async (_: unknown, { id }: { id: string }) => {
      return fetchAllAboutBand(id);
    },
    searchBands: async (
      _: unknown,
      { name, limit = 10 }: { name: string; limit?: number }
    ) => {
      const query = { match_phrase: { name } };
      console.info("[Elasticsearch] Searching index:", ES_BAND_INDEX, {
        query,
      });

      const result = await elasticsearch.search({
        index: ES_BAND_INDEX,
        size: limit,
        query,
      });

      return result.hits.hits.flatMap((hit) => {
        if (!isBandSource(hit._source)) {
          warnMalformedBand(hit);
          return [];
        }

        return [toBand(hit._source)];
      });
    },
  },
  SQLArtist: {
    birthdate: formatBirthdate,
  },
  SQLArtistSummary: {
    birthdate: formatBirthdate,
  },
};
