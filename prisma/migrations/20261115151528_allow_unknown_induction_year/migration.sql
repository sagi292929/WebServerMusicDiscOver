-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Band" (
    "Id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "es_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "origin" TEXT NOT NULL,
    "officialWebsite" TEXT NOT NULL,
    "rockAndRollHallOfFameInduction" INTEGER
);
INSERT INTO "new_Band" ("Id", "es_id", "name", "officialWebsite", "origin", "rockAndRollHallOfFameInduction") SELECT "Id", "es_id", "name", "officialWebsite", "origin", "rockAndRollHallOfFameInduction" FROM "Band";
DROP TABLE "Band";
ALTER TABLE "new_Band" RENAME TO "Band";
CREATE TABLE "new_Instrument" (
    "Id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "Type" TEXT NOT NULL
);
INSERT INTO "new_Instrument" ("Id", "Type", "name") SELECT "Id", "Type", "name" FROM "Instrument";
DROP TABLE "Instrument";
ALTER TABLE "new_Instrument" RENAME TO "Instrument";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
