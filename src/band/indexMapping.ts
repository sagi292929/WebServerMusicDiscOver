export const bandIndexMapping = {
  mappings: {
    properties: {
      id: { type: "keyword" },
      name: { type: "text" },
      genres: { type: "keyword" },
      active_years: { type: "integer" },
      inserted_at: { type: "date" },
    },
  },
} as const;
