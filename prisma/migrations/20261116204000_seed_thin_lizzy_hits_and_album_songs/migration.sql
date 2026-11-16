WITH hits(title, year, achievement) AS (
    VALUES
        ('The Boys Are Back in Town', 1976, 'Ireland #1, UK #8, US Billboard Hot 100 #12'),
        ('Whiskey in the Jar', 1972, 'Ireland #1 (17 Weeks), UK Singles Chart #6'),
        ('Waiting for an Alibi', 1979, 'Ireland #6, UK Singles Chart #9'),
        ('Killer on the Loose', 1980, 'Ireland #5, UK Singles Chart #10'),
        ('Don''t Believe a Word', 1976, 'Ireland #2, UK Singles Chart #12'),
        ('Dancing in the Moonlight (It''s Caught Me in Its Spotlight)', 1977, 'Ireland #4, UK Singles Chart #14'),
        ('Do Anything You Want To', 1979, 'UK Singles Chart #14'),
        ('Rosalie / Cowgirl''s Song (Medley)', 1978, 'Ireland #14, UK Singles Chart #20'),
        ('Jailbreak', 1976, 'UK Singles Chart #31 & Classic Rock Staple'),
        ('Cowboy Song', 1976, 'US Billboard Hot 100 #77 & Signature Twin-Lead Classic')
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
        ('The Boys Are Back in Town', 1976, 'Ireland #1, UK #8, US Billboard Hot 100 #12'),
        ('Whiskey in the Jar', 1972, 'Ireland #1 (17 Weeks), UK Singles Chart #6'),
        ('Waiting for an Alibi', 1979, 'Ireland #6, UK Singles Chart #9'),
        ('Killer on the Loose', 1980, 'Ireland #5, UK Singles Chart #10'),
        ('Don''t Believe a Word', 1976, 'Ireland #2, UK Singles Chart #12'),
        ('Dancing in the Moonlight (It''s Caught Me in Its Spotlight)', 1977, 'Ireland #4, UK Singles Chart #14'),
        ('Do Anything You Want To', 1979, 'UK Singles Chart #14'),
        ('Rosalie / Cowgirl''s Song (Medley)', 1978, 'Ireland #14, UK Singles Chart #20'),
        ('Jailbreak', 1976, 'UK Singles Chart #31 & Classic Rock Staple'),
        ('Cowboy Song', 1976, 'US Billboard Hot 100 #77 & Signature Twin-Lead Classic')
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
        ('The Boys Are Back in Town', 1976, 'Jailbreak', 4),
        ('Waiting for an Alibi', 1979, 'Black Rose: A Rock Legend', 2),
        ('Killer on the Loose', 1980, 'Chinatown', 2),
        ('Don''t Believe a Word', 1976, 'Johnny the Fox', 3),
        ('Dancing in the Moonlight (It''s Caught Me in Its Spotlight)', 1977, 'Bad Reputation', 3),
        ('Do Anything You Want To', 1979, 'Black Rose: A Rock Legend', 1),
        ('Jailbreak', 1976, 'Jailbreak', 1),
        ('Cowboy Song', 1976, 'Jailbreak', 6)
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
   AND band."es_id" = 'band-thin-lizzy'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
