export const artistTypeDefs = `
  type ArtistMatch {
    es_id: String!
    name: String!
    born_in: String
    former_bands: [String!]!
  }

  type Artist {
    es_id: String!
    name: String!
    born_in: String
    former_bands: [String!]!
  }

  extend type Query {
    getArtist(name: String!, limit: Int): [ArtistMatch!]!
  }
`;
