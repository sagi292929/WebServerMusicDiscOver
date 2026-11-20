export const albumTypeDefs = `#graphql
  type AlbumMatch {
    Id: Int!
    title: String!
    year: Int!
    lengthMinutes: String!
    bandName: String!
  }

  extend type Query {
    getAlbum(name: String!): [AlbumMatch!]!
  }
`;
