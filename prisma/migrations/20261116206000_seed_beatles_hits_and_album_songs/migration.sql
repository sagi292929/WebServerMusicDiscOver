WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Hey Jude', 1968, 'Hey Jude (Non-Album Single)', 'US Billboard Hot 100 #1 (9 Weeks) & UK #1', 1),
        ('I Want to Hold Your Hand', 1963, 'Meet the Beatles! (Non-Album UK Single)', 'First US Billboard Hot 100 #1 (7 Weeks) & UK #1', 1),
        ('She Loves You', 1963, 'The Beatles'' Second Album (Non-Album UK Single)', 'Best-Selling UK Single of the 1960s (#1 UK & US)', 1),
        ('Yesterday', 1965, 'Help!', 'US Billboard Hot 100 #1 (4 Weeks) & Most Covered Song', 13),
        ('Let It Be', 1970, 'Let It Be', 'US Billboard Hot 100 #1 & UK Singles Chart #2', 6),
        ('Can''t Buy Me Love', 1964, 'A Hard Day''s Night', 'US Billboard Hot 100 #1 (Led All-Beatles Top 5) & UK #1', 7),
        ('A Hard Day''s Night', 1964, 'A Hard Day''s Night', 'US Billboard Hot 100 #1 & UK Singles Chart #1', 1),
        ('Help!', 1965, 'Help!', 'US Billboard Hot 100 #1 & UK Singles Chart #1', 1),
        ('Get Back', 1969, 'Let It Be', 'UK Singles Chart #1 (6 Weeks) & US #1 (5 Weeks)', 12),
        ('All You Need Is Love', 1967, 'Magical Mystery Tour (US)', 'US Billboard Hot 100 #1 & UK Singles Chart #1', 11)
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
        ('Hey Jude', 1968, 'US Billboard Hot 100 #1 (9 Weeks) & UK #1'),
        ('I Want to Hold Your Hand', 1963, 'First US Billboard Hot 100 #1 (7 Weeks) & UK #1'),
        ('She Loves You', 1963, 'Best-Selling UK Single of the 1960s (#1 UK & US)'),
        ('Yesterday', 1965, 'US Billboard Hot 100 #1 (4 Weeks) & Most Covered Song'),
        ('Let It Be', 1970, 'US Billboard Hot 100 #1 & UK Singles Chart #2'),
        ('Can''t Buy Me Love', 1964, 'US Billboard Hot 100 #1 (Led All-Beatles Top 5) & UK #1'),
        ('A Hard Day''s Night', 1964, 'US Billboard Hot 100 #1 & UK Singles Chart #1'),
        ('Help!', 1965, 'US Billboard Hot 100 #1 & UK Singles Chart #1'),
        ('Get Back', 1969, 'UK Singles Chart #1 (6 Weeks) & US #1 (5 Weeks)'),
        ('All You Need Is Love', 1967, 'US Billboard Hot 100 #1 & UK Singles Chart #1')
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
        ('Hey Jude', 1968, 'Hey Jude (Non-Album Single)', 1),
        ('I Want to Hold Your Hand', 1963, 'Meet the Beatles! (Non-Album UK Single)', 1),
        ('She Loves You', 1963, 'The Beatles'' Second Album (Non-Album UK Single)', 1),
        ('Yesterday', 1965, 'Help!', 13),
        ('Let It Be', 1970, 'Let It Be', 6),
        ('Can''t Buy Me Love', 1964, 'A Hard Day''s Night', 7),
        ('A Hard Day''s Night', 1964, 'A Hard Day''s Night', 1),
        ('Help!', 1965, 'Help!', 1),
        ('Get Back', 1969, 'Let It Be', 12),
        ('All You Need Is Love', 1967, 'Magical Mystery Tour (US)', 11)
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
   AND band."es_id" = 'band-the-beatles'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
