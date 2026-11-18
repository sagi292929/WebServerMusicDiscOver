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

  type ArtistInstrument {
    name: String!
    Type: String!
  }

  type ArtistAlbumAppearance {
    albumId: Int!
    album: ArtistAlbum!
  }

  type ArtistAlbum {
    Id: Int!
    title: String!
    year: Int!
    lengthMinutes: String!
    songs: [ArtistSong!]!
  }

  type ArtistSong {
    title: String!
    year: Int!
    achievement: String!
    hit: Boolean!
  }

  type ArtistBand {
    Id: Int!
    es_id: String!
    name: String!
    origin: String!
    officialWebsite: String!
    rockAndRollHallOfFameInduction: Int
  }

  type ArtistDatabaseDetails {
    Id: Int!
    es_id: String!
    name: String!
    birthdate: String!
    band: ArtistBand!
    instruments: [ArtistInstrument!]!
    albums: [ArtistAlbumAppearance!]!
  }

  type AllAboutArtist {
    es_id: String!
    name: String!
    born_in: String
    former_bands: [String!]!
    elasticsearch: Artist!
    database: ArtistDatabaseDetails
  }

  extend type Query {
    getArtist(name: String!, limit: Int): [ArtistMatch!]!
    getAllAboutArtist(name: String!, limit: Int): [AllAboutArtist!]!
  }
`;
