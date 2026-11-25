export const artistTypeDefs = `
  type ArtistMatch {
    es_id: String!
    name: String!
    band_name: String!
    born_in: String
  }

  type ArtistInstrument {
    name: String!
    Type: String!
  }

  type ArtistBand {
    name: String!
  }

  type ArtistDatabaseDetails {
    birthdate: String
    band: ArtistBand!
    instruments: [ArtistInstrument!]!
  }

  type AllAboutArtist {
    es_id: String!
    name: String!
    born_in: String
    former_bands: [String!]!
    database: ArtistDatabaseDetails
  }

  extend type Query {
    getArtist(name: String!, limit: Int): [ArtistMatch!]!
    getAllAboutArtist(name: String!, limit: Int): [AllAboutArtist!]!
  }
`;
