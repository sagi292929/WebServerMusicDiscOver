import { elasticsearch } from "../elastic";
import { ES_ARTIST_INDEX } from "./const";

type ArtistSource = {
  es_id: string;
  name: string;
  born_in?: string;
  former_bands?: string[];
};

export const artistResolvers = {
  Query: {
    getArtist: async (
      _: unknown,
      { name, limit = 100 }: { name: string; limit?: number }
    ) => {
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

      return result.hits.hits.map((hit) => {
        const source = hit._source as ArtistSource;
        return {
          es_id: source.es_id,
          name: source.name,
          born_in: source.born_in,
          former_bands: source.former_bands ?? [],
        };
      });
    },
  },
};
