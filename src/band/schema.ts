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

  type BandMatch {
    id: String!
    name: String!
    active_years: [Int!]!
  }

  type SQLSong {
    Id: Int!
    title: String!
    year: Int!
    achievement: String!
    hit: Boolean!
  }

  type SQLInstrument {
    Id: Int!
    name: String!
    Type: String!
  }

  type SQLArtistInstrument {
    artistId: Int!
    instrumentId: Int!
    instrument: SQLInstrument!
  }

  type SQLArtist {
    Id: Int!
    name: String!
    birthdate: String!
    BandId: Int!
    artistInstruments: [SQLArtistInstrument!]!
  }

  type SQLAlbumSong {
    albumId: Int!
    songId: Int!
    trackNumber: Int!
    song: SQLSong!
  }

  type SQLAlbumArtist {
    albumId: Int!
    artistId: Int!
    artist: SQLArtist!
  }

  type SQLAlbum {
    Id: Int!
    BandId: Int!
    title: String!
    year: Int!
    lengthMinutes: String!
    albumSongs: [SQLAlbumSong!]!
    albumArtists: [SQLAlbumArtist!]!
  }

  type SQLBand {
    Id: Int!
    es_id: String!
    name: String!
    origin: String!
    officialWebsite: String!
    rockAndRollHallOfFameInduction: Int
    albums: [SQLAlbum!]!
    artists: [SQLArtist!]!
  }

  type AllAboutBand {
    id: String!
    name: String!
    genres: [String!]!
    active_years: [Int!]!
    albums: [BandAlbum!]!
    songs_hits: [BandSongHit!]!
    members: [BandMember!]!
    inserted_at: String
    elasticsearch: Band
    database: SQLBand
  }

  type SQLInstrumentSummary {
    name: String!
    Type: String!
  }

  type SQLArtistInstrumentSummary {
    instrument: SQLInstrumentSummary!
  }

  type SQLArtistSummary {
    name: String!
    birthdate: String!
    artistInstruments: [SQLArtistInstrumentSummary!]!
  }

  type SQLAlbumSummary {
    title: String!
    year: Int!
    lengthMinutes: String!
    albumSongs: [SQLAlbumSong!]!
    albumArtists: [SQLAlbumArtistSummary!]!
  }

  type SQLAlbumArtistSummary {
    artist: SQLArtistSummary!
  }

  type SQLBandSummary {
    Id: Int!
    es_id: String!
    name: String!
    origin: String!
    officialWebsite: String!
    rockAndRollHallOfFameInduction: Int
    albums: [SQLAlbumSummary!]!
    artists: [SQLArtistSummary!]!
  }

  type AllAboutBandSummary {
    id: String!
    name: String!
    genres: [String!]!
    active_years: [Int!]!
    albums: [BandAlbum!]!
    songs_hits: [BandSongHit!]!
    members: [BandMember!]!
    inserted_at: String
    elasticsearch: Band
    database: SQLBandSummary
  }

  type Query {
    getBand(name: String!): [BandMatch!]!
    getAllAboutBandDebug(id: String!): AllAboutBand
    getAllAboutBand(id: String!): AllAboutBandSummary
    searchBands(name: String!, limit: Int): [Band!]!
  }
`;
