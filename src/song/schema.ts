export const songTypeDefs = `#graphql
  type SongMatch {
    es_id: String!
    name: String!
    band_name: String!
  }

  extend type Query {
    getSong(name: String!): [SongMatch!]!
  }
`;
