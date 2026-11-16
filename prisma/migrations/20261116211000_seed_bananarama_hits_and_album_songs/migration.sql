WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Venus', 1986, 'True Confessions', 'US Billboard Hot 100 #1 & Australia #1', 1),
        ('Cruel Summer', 1983, 'Bananarama', 'UK Singles Chart #8 & US Billboard Hot 100 #9', 3),
        ('I Heard a Rumour', 1987, 'Wow!', 'US Billboard Hot 100 #4 & UK Singles Chart #14', 1),
        ('Love in the First Degree', 1987, 'Wow!', 'UK Singles Chart #3 & Brit Award Nominee', 5),
        ('Robert De Niro''s Waiting...', 1984, 'Bananarama', 'UK Singles Chart #3', 2),
        ('Help!', 1989, 'The Greatest Hits Collection (Reissue)', 'UK Singles Chart #3 & Sweden #1 (Comic Relief Charity Single)', 1),
        ('Shy Boy (Don''t It Make You Feel Good)', 1982, 'Deep Sea Skiving', 'UK Singles Chart #4', 2),
        ('Really Saying Something', 1982, 'Deep Sea Skiving', 'UK Singles Chart #5 (with Fun Boy Three)', 1),
        ('Na Na Hey Hey (Kiss Him Goodbye)', 1983, 'Deep Sea Skiving', 'UK Singles Chart #5', 8),
        ('I Want You Back', 1988, 'Wow!', 'UK Singles Chart #5 & Australia #3', 10)
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
        ('Venus', 1986, 'US Billboard Hot 100 #1 & Australia #1'),
        ('Cruel Summer', 1983, 'UK Singles Chart #8 & US Billboard Hot 100 #9'),
        ('I Heard a Rumour', 1987, 'US Billboard Hot 100 #4 & UK Singles Chart #14'),
        ('Love in the First Degree', 1987, 'UK Singles Chart #3 & Brit Award Nominee'),
        ('Robert De Niro''s Waiting...', 1984, 'UK Singles Chart #3'),
        ('Help!', 1989, 'UK Singles Chart #3 & Sweden #1 (Comic Relief Charity Single)'),
        ('Shy Boy (Don''t It Make You Feel Good)', 1982, 'UK Singles Chart #4'),
        ('Really Saying Something', 1982, 'UK Singles Chart #5 (with Fun Boy Three)'),
        ('Na Na Hey Hey (Kiss Him Goodbye)', 1983, 'UK Singles Chart #5'),
        ('I Want You Back', 1988, 'UK Singles Chart #5 & Australia #3')
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
        ('Venus', 1986, 'True Confessions', 1),
        ('Cruel Summer', 1983, 'Bananarama', 3),
        ('I Heard a Rumour', 1987, 'Wow!', 1),
        ('Love in the First Degree', 1987, 'Wow!', 5),
        ('Robert De Niro''s Waiting...', 1984, 'Bananarama', 2),
        ('Help!', 1989, 'The Greatest Hits Collection (Reissue)', 1),
        ('Shy Boy (Don''t It Make You Feel Good)', 1982, 'Deep Sea Skiving', 2),
        ('Really Saying Something', 1982, 'Deep Sea Skiving', 1),
        ('Na Na Hey Hey (Kiss Him Goodbye)', 1983, 'Deep Sea Skiving', 8),
        ('I Want You Back', 1988, 'Wow!', 10)
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
   AND band."es_id" = 'band-bananarama'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
