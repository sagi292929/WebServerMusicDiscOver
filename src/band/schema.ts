export const typeDefs = `#graphql
  type BandAlbum {
    id: String!
    name: String!
    year: Int
    length_minutes: String
  }

  type StudioAlbum {
    id: String!
    name: String!
    year: Int
    length_minutes: String
  }

  type SongDiscography {
    studio_albums: [StudioAlbum!]!
  }

  type BandSongHit {
    title: String!
    year: Int
    discography: SongDiscography
    achievement: String
  }

  type BandMember {
    id: String!
    name: String!
  }

  type Band {
    id: String!
    name: String!
    genres: [String!]!
    active_years: [Int!]!
    albums: [BandAlbum!]!
    songs_hits: [BandSongHit!]!
    members: [BandMember!]!
    inserted_at: String
  }

  type Query {
    getBand(id: String!): Band
    searchBands(name: String!, limit: Int): [Band!]!
  }
`;
