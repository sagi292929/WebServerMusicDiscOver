CREATE TABLE "album_artists" (
    "album_id" INTEGER NOT NULL,
    "artist_id" INTEGER NOT NULL,
    PRIMARY KEY ("album_id", "artist_id"),
    CONSTRAINT "album_artists_album_id_fkey" FOREIGN KEY ("album_id") REFERENCES "Album" ("Id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "album_artists_artist_id_fkey" FOREIGN KEY ("artist_id") REFERENCES "Artist" ("Id") ON DELETE CASCADE ON UPDATE CASCADE
);
