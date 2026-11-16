WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Harvest of Souls', 2004, 'Dark Matter', 'Widely Regarded as Crowning Neo-Prog Epic & Masterpiece', 7),
        ('Widow''s Peak', 1985, 'The Wake', 'Definitive Neo-Prog Fan-Favorite Centerpiece', 3),
        ('The Narrow Margin', 1997, 'Subterranea', 'Acclaimed Epic Centerpiece of Ambitious Concept Album', 13),
        ('The Last Human Gateway', 1983, 'Tales from the Lush Attic', '20-Minute Debut Epic & Neo-Prog Landmark', 4),
        ('The Wake', 1985, 'The Wake', 'Dramatic Title Track & Early Prog Radio Staple', 5),
        ('Subterranea', 1997, 'Subterranea', 'Theatrical Highlight of UK Double Concept Album', 1),
        ('Sacred Sound', 2004, 'Dark Matter', 'Gargantuan Opener & Modern Prog Live Staple', 1),
        ('Born Brilliant', 2000, 'The Seventh House', 'Critically Acclaimed Turn-of-the-Century Prog Epic', 2),
        ('Fading Senses', 1993, 'Ever', 'Triumphant Return-to-Form Album Opener', 1),
        ('The Road of Bones', 2014, 'The Road of Bones', 'Dark, Atmospheric Late-Career Masterpiece Title Track', 1)
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
        ('Harvest of Souls', 2004, 'Widely Regarded as Crowning Neo-Prog Epic & Masterpiece'),
        ('Widow''s Peak', 1985, 'Definitive Neo-Prog Fan-Favorite Centerpiece'),
        ('The Narrow Margin', 1997, 'Acclaimed Epic Centerpiece of Ambitious Concept Album'),
        ('The Last Human Gateway', 1983, '20-Minute Debut Epic & Neo-Prog Landmark'),
        ('The Wake', 1985, 'Dramatic Title Track & Early Prog Radio Staple'),
        ('Subterranea', 1997, 'Theatrical Highlight of UK Double Concept Album'),
        ('Sacred Sound', 2004, 'Gargantuan Opener & Modern Prog Live Staple'),
        ('Born Brilliant', 2000, 'Critically Acclaimed Turn-of-the-Century Prog Epic'),
        ('Fading Senses', 1993, 'Triumphant Return-to-Form Album Opener'),
        ('The Road of Bones', 2014, 'Dark, Atmospheric Late-Career Masterpiece Title Track')
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
        ('Harvest of Souls', 2004, 'Dark Matter', 7),
        ('Widow''s Peak', 1985, 'The Wake', 3),
        ('The Narrow Margin', 1997, 'Subterranea', 13),
        ('The Last Human Gateway', 1983, 'Tales from the Lush Attic', 4),
        ('The Wake', 1985, 'The Wake', 5),
        ('Subterranea', 1997, 'Subterranea', 1),
        ('Sacred Sound', 2004, 'Dark Matter', 1),
        ('Born Brilliant', 2000, 'The Seventh House', 2),
        ('Fading Senses', 1993, 'Ever', 1),
        ('The Road of Bones', 2014, 'The Road of Bones', 1)
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
   AND band."es_id" = 'band-iq'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
