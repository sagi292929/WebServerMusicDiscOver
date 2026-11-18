export const artistIndexMappling = {
  mappings: {
    properties: {
      es_id: { type: "keyword" },
      name: { type: "text" },
      born_in: { type: "text" },
      former_bands: { type: "text" },
    },
  },
} as const;
