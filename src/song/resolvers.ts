import { elasticsearch } from "../elastic";
import { ES_SONG_INDEX } from "./const";

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
  Query: {
    getSong: async (_: unknown, { name }: { name: string }) => {
      const trimmedName = name.trim();
      if (!trimmedName) {
        return [];
      }
      const searchTerm = trimmedName.toLowerCase();

      const escapedName = trimmedName.replace(/[\\*?]/g, "\\$&");
      const query = {
        wildcard: {
          name: {
            value: `*${escapedName}*`,
            case_insensitive: true,
          },
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

      return result.hits.hits
        .flatMap((hit) => {
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
        })
        .sort((left, right) => {
          const leftPosition = left.name.toLowerCase().indexOf(searchTerm);
          const rightPosition = right.name.toLowerCase().indexOf(searchTerm);

          return (
            leftPosition - rightPosition ||
            left.name.localeCompare(right.name) ||
            left.band_name.localeCompare(right.band_name) ||
            left.es_id.localeCompare(right.es_id)
          );
        });
    },
  },
};
