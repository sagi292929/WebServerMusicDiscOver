WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Lady Fantasy', 1974, 'Mirage', 'Signature Progressive Rock Suite (12 min)', 5),
        ('Never Let Go', 1973, 'Camel', 'Debut Single & Career-Long Live Staple', 4),
        ('Rhayader Goes to Town', 1975, 'The Snow Goose', 'Highlight from UK Silver-Certified Concept Album', 6),
        ('Ice', 1979, 'I Can See Your House from Here', 'Acclaimed Instrumental Guitar Showcase', 8),
        ('Lunar Sea', 1976, 'Moonmadness', 'Signature Instrumental from UK #15 Album', 4),
        ('Song Within a Song', 1976, 'Moonmadness', 'Classic Progressive Radio & Anthology Staple', 2),
        ('Nimrodel / The Procession / The White Rider', 1974, 'Mirage', 'Benchmark Symphonic Prog Suite', 2),
        ('Another Night', 1976, 'Moonmadness', 'Official Single & Live Concert Classic', 3),
        ('Stationary Traveller', 1984, 'Stationary Traveller', 'Signature 1980s Concept Album Title Track', 1),
        ('Freefall', 1974, 'Mirage', 'Classic Rock & Prog FM Radio Staple', 1)
)
INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT hits.title, hits.year, hits.achievement, TRUE
FROM hits
WHERE NOT EXISTS (
    SELECT 1
    FROM "Song" AS existing
    WHERE existing."title" = hits.title
      AND existing."year" = hits.year
);

WITH hits(title, year, achievement) AS (
    VALUES
        ('Lady Fantasy', 1974, 'Signature Progressive Rock Suite (12 min)'),
        ('Never Let Go', 1973, 'Debut Single & Career-Long Live Staple'),
        ('Rhayader Goes to Town', 1975, 'Highlight from UK Silver-Certified Concept Album'),
        ('Ice', 1979, 'Acclaimed Instrumental Guitar Showcase'),
        ('Lunar Sea', 1976, 'Signature Instrumental from UK #15 Album'),
        ('Song Within a Song', 1976, 'Classic Progressive Radio & Anthology Staple'),
        ('Nimrodel / The Procession / The White Rider', 1974, 'Benchmark Symphonic Prog Suite'),
        ('Another Night', 1976, 'Official Single & Live Concert Classic'),
        ('Stationary Traveller', 1984, 'Signature 1980s Concept Album Title Track'),
        ('Freefall', 1974, 'Classic Rock & Prog FM Radio Staple')
)
UPDATE "Song"
SET "hit" = TRUE,
    "achievement" = (
        SELECT hits.achievement
        FROM hits
        WHERE hits.title = "Song"."title"
          AND hits.year = "Song"."year"
    )
WHERE EXISTS (
    SELECT 1
    FROM hits
    WHERE hits.title = "Song"."title"
      AND hits.year = "Song"."year"
);

WITH hits(title, year, albumTitle, trackNumber) AS (
    VALUES
        ('Lady Fantasy', 1974, 'Mirage', 5),
        ('Never Let Go', 1973, 'Camel', 4),
        ('Rhayader Goes to Town', 1975, 'The Snow Goose', 6),
        ('Ice', 1979, 'I Can See Your House from Here', 8),
        ('Lunar Sea', 1976, 'Moonmadness', 4),
        ('Song Within a Song', 1976, 'Moonmadness', 2),
        ('Nimrodel / The Procession / The White Rider', 1974, 'Mirage', 2),
        ('Another Night', 1976, 'Moonmadness', 3),
        ('Stationary Traveller', 1984, 'Stationary Traveller', 1),
        ('Freefall', 1974, 'Mirage', 1)
)
INSERT INTO "album_songs" ("album_id", "song_id", "track_number")
SELECT album."Id", song."Id", hits.trackNumber
FROM hits
JOIN "Song" AS song
    ON song."title" = hits.title
   AND song."year" = hits.year
JOIN "Album" AS album
    ON album."title" = hits.albumTitle
JOIN "Band" AS band
    ON band."Id" = album."BandId"
   AND band."es_id" = 'band-camel'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
