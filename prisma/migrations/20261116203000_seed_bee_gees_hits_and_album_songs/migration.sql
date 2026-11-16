WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Stayin'' Alive', 1977, 'Saturday Night Fever', 'US Billboard Hot 100 #1 (4 Weeks)', 6),
        ('How Deep Is Your Love', 1977, 'Saturday Night Fever', 'US Billboard Hot 100 #1 (17 Weeks in Top 10)', 3),
        ('Night Fever', 1978, 'Saturday Night Fever', 'US Billboard Hot 100 #1 (8 Weeks)', 1),
        ('How Can You Mend a Broken Heart', 1971, 'Trafalgar', 'First US Billboard Hot 100 #1', 4),
        ('Jive Talkin''', 1975, 'Main Course', 'US Billboard Hot 100 #1', 1),
        ('You Should Be Dancing', 1976, 'Children of the World', 'US Billboard Hot 100 #1', 3),
        ('Too Much Heaven', 1978, 'Spirits Having Flown', 'US Billboard Hot 100 #1', 3),
        ('Tragedy', 1979, 'Spirits Having Flown', 'US Billboard Hot 100 #1 & UK #1', 5),
        ('Love You Inside Out', 1979, 'Spirits Having Flown', 'US Billboard Hot 100 #1 (6th Consecutive #1)', 6),
        ('Massachusetts', 1967, 'Horizontal', 'First UK Singles Chart #1', 5)
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
        ('Stayin'' Alive', 1977, 'US Billboard Hot 100 #1 (4 Weeks)'),
        ('How Deep Is Your Love', 1977, 'US Billboard Hot 100 #1 (17 Weeks in Top 10)'),
        ('Night Fever', 1978, 'US Billboard Hot 100 #1 (8 Weeks)'),
        ('How Can You Mend a Broken Heart', 1971, 'First US Billboard Hot 100 #1'),
        ('Jive Talkin''', 1975, 'US Billboard Hot 100 #1'),
        ('You Should Be Dancing', 1976, 'US Billboard Hot 100 #1'),
        ('Too Much Heaven', 1978, 'US Billboard Hot 100 #1'),
        ('Tragedy', 1979, 'US Billboard Hot 100 #1 & UK #1'),
        ('Love You Inside Out', 1979, 'US Billboard Hot 100 #1 (6th Consecutive #1)'),
        ('Massachusetts', 1967, 'First UK Singles Chart #1')
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
        ('Stayin'' Alive', 1977, 'Saturday Night Fever', 6),
        ('How Deep Is Your Love', 1977, 'Saturday Night Fever', 3),
        ('Night Fever', 1978, 'Saturday Night Fever', 1),
        ('How Can You Mend a Broken Heart', 1971, 'Trafalgar', 4),
        ('Jive Talkin''', 1975, 'Main Course', 1),
        ('You Should Be Dancing', 1976, 'Children of the World', 3),
        ('Too Much Heaven', 1978, 'Spirits Having Flown', 3),
        ('Tragedy', 1979, 'Spirits Having Flown', 5),
        ('Love You Inside Out', 1979, 'Spirits Having Flown', 6),
        ('Massachusetts', 1967, 'Horizontal', 5)
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
   AND band."es_id" = 'band-bee-gees'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
