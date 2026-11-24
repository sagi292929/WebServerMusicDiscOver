export const albumTypeDefs = `#graphql
  type AlbumMatch {
    es_id: String!
    name: String!
    band_name: String!
  }

  type AllAboutAlbum {
    id: String!
    elasticsearch: JSON
    database: SQLAlbumDetails
  }

  type SQLAlbumDetails {
    Id: Int!
    BandId: Int!
    albumSongs: [SQLAlbumSong!]!
  }

  extend type Query {
    getAlbum(name: String!): [AlbumMatch!]!
    getAllAboutAlbum(id: String!): AllAboutAlbum
  }
`;
