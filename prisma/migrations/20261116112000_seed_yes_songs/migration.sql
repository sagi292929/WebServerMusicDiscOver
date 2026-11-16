INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'Owner of a Lonely Heart', 1983, 'US Billboard Hot 100 #1', FALSE
WHERE NOT EXISTS (
    SELECT 1 FROM "Song" WHERE "title" = 'Owner of a Lonely Heart'
);

INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'Roundabout', 1971, 'US Billboard Hot 100 #13', TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM "Song" WHERE "title" = 'Roundabout'
);

INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'I''ve Seen All Good People', 1971, 'Classic Rock Radio Staple', TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM "Song" WHERE "title" = 'I''ve Seen All Good People'
);

INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'Leave It', 1984, 'US Billboard Hot 100 #24', TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM "Song" WHERE "title" = 'Leave It'
);

INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'Love Will Find a Way', 1987, 'US Mainstream Rock #1', TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM "Song" WHERE "title" = 'Love Will Find a Way'
);

INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'Rhythm of Love', 1987, 'US Billboard Hot 100 #40', TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM "Song" WHERE "title" = 'Rhythm of Love'
);

INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'Wonderous Stories', 1977, 'UK Singles Chart #7', TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM "Song" WHERE "title" = 'Wonderous Stories'
);

INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'Starship Trooper', 1971, 'Signature Progressive Epic', TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM "Song" WHERE "title" = 'Starship Trooper'
);

INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'Close to the Edge', 1972, 'Benchmark Prog Epic (18 min)', TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM "Song" WHERE "title" = 'Close to the Edge'
);

INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'And You and I', 1972, 'US Billboard Hot 100 #42', TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM "Song" WHERE "title" = 'And You and I'
);
