PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;

CREATE TABLE "artist_instruments" (
    "artist_id" INTEGER NOT NULL,
    "instrument_id" INTEGER NOT NULL,
    PRIMARY KEY ("artist_id", "instrument_id"),
    CONSTRAINT "artist_instruments_artist_id_fkey" FOREIGN KEY ("artist_id") REFERENCES "Artist" ("Id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "artist_instruments_instrument_id_fkey" FOREIGN KEY ("instrument_id") REFERENCES "Instrument" ("Id") ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT "Id", "mainInstrumentId"
FROM "Artist";

CREATE TABLE "new_Artist" (
    "Id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "birthdate" DATETIME NOT NULL,
    "BandId" INTEGER NOT NULL,
    CONSTRAINT "Artist_BandId_fkey" FOREIGN KEY ("BandId") REFERENCES "Band" ("Id") ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO "new_Artist" ("Id", "name", "birthdate", "BandId")
SELECT "Id", "name", "birthdate", "BandId"
FROM "Artist";

DROP TABLE "Artist";
ALTER TABLE "new_Artist" RENAME TO "Artist";

PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
