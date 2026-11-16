PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;

CREATE TABLE "album_songs" (
    "album_id" INTEGER NOT NULL,
    "song_id" INTEGER NOT NULL,
    "track_number" INTEGER NOT NULL,
    PRIMARY KEY ("album_id", "song_id"),
    CONSTRAINT "album_songs_album_id_fkey" FOREIGN KEY ("album_id") REFERENCES "Album" ("Id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "album_songs_song_id_fkey" FOREIGN KEY ("song_id") REFERENCES "Song" ("Id") ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO "album_songs" ("album_id", "song_id", "track_number")
SELECT "albumId", "Id",
       ROW_NUMBER() OVER (PARTITION BY "albumId" ORDER BY "Id")
FROM "Song";

CREATE TABLE "new_Song" (
    "Id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "achievement" TEXT NOT NULL,
    "hit" BOOLEAN NOT NULL,
    "BandId" INTEGER NOT NULL,
    CONSTRAINT "Song_BandId_fkey" FOREIGN KEY ("BandId") REFERENCES "Band" ("Id") ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO "new_Song" ("Id", "title", "year", "achievement", "hit", "BandId")
SELECT "Id", "title", "year", "achievement", "hit", "BandId"
FROM "Song";

DROP TABLE "Song";
ALTER TABLE "new_Song" RENAME TO "Song";

PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
