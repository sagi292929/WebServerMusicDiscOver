import { elasticsearch } from "../elastic";
import { config } from "../config";

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

export const bandResolvers = {
  Query: {
    getBand: async (_: unknown, { id }: { id: string }) => {
      const result = await elasticsearch.search({
        index: config.elasticsearch.index,
        size: 1,
        query: { term: { id } },
      });

      const source = result.hits.hits[0]?._source as BandSource | undefined;
      return source ? toBand(source) : null;
    },
    searchBands: async (
      _: unknown,
      { name, limit = 10 }: { name: string; limit?: number }
    ) => {
      const result = await elasticsearch.search({
        index: config.elasticsearch.index,
        size: limit,
        query: { term: { "name.keyword": name } },
      });

      return result.hits.hits.map((hit) =>
        toBand(hit._source as BandSource)
      );
    },
  },
};
