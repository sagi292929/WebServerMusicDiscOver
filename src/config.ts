export const config = {
  port: Number(process.env.PORT) || 4000,
  elasticsearch: {
    node: process.env.ELASTICSEARCH_NODE ?? "http://localhost:9200",
    username: process.env.ELASTICSEARCH_USERNAME || undefined,
    password: process.env.ELASTICSEARCH_PASSWORD || undefined,
    index: process.env.ELASTICSEARCH_INDEX ?? "discs",
    searchableFields: ["name"],
  },
  googleApiKey: process.env.GOOGLE_API_KEY,
} as const;
