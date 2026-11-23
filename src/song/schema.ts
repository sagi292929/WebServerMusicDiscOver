export const songTypeDefs = `#graphql
  scalar JSON

  type SongMatch {
    es_id: String!
    name: String!
    band_name: String!
    database_id: Int
  }

  type AllAboutSong {
    id: Int!
    elasticsearch: JSON
    database: SQLSong
  }

  extend type Query {
    getSong(name: String!): [SongMatch!]!
    getAllAboutSong(id: Int!): AllAboutSong
  }
`;
