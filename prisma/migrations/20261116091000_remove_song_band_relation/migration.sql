PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;

CREATE TABLE "new_Song" (
    "Id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "achievement" TEXT NOT NULL,
    "hit" BOOLEAN NOT NULL
);

INSERT INTO "new_Song" ("Id", "title", "year", "achievement", "hit")
SELECT "Id", "title", "year", "achievement", "hit"
FROM "Song";

DROP TABLE "Song";
ALTER TABLE "new_Song" RENAME TO "Song";

PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
