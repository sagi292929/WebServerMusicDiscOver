export const bandIndexMapping = {
  settings: {
    number_of_shards: 1,
    number_of_replicas: 0,
  },
  mappings: {
    properties: {
      id: { type: "keyword" },
      inserted_at: { type: "date" },
      name: {
        type: "text",
        fields: { keyword: { type: "keyword" } },
      },
      name_suggest: { type: "completion" },
      albums: {
        type: "nested",
        properties: {
          id: { type: "keyword" },
          name: {
            type: "text",
            fields: { keyword: { type: "keyword" } },
          },
          year: { type: "integer" },
          length_minutes: { type: "keyword" },
        },
      },
      genres: {
        type: "text",
        fields: { keyword: { type: "keyword" } },
      },
      active_years: { type: "integer" },
      songs_hits: {
        type: "nested",
        properties: {
          title: {
            type: "text",
            fields: { keyword: { type: "keyword" } },
          },
          year: { type: "integer" },
          discography: {
            properties: {
              studio_albums: {
                type: "nested",
                properties: {
                  id: { type: "keyword" },
                  name: {
                    type: "text",
                    fields: { keyword: { type: "keyword" } },
                  },
                  year: { type: "integer" },
                  length_minutes: { type: "keyword" },
                },
              },
            },
          },
          achievement: {
            type: "text",
            fields: { keyword: { type: "keyword" } },
          },
        },
      },
      members: {
        type: "nested",
        properties: {
          id: { type: "keyword" },
          name: {
            type: "text",
            fields: { keyword: { type: "keyword" } },
          },
        },
      },
    },
  },
} as const;
