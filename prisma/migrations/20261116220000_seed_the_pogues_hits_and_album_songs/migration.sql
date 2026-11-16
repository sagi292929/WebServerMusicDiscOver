WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Fairytale of New York', 1987, 'If I Should Fall from Grace with God', 'UK Singles Chart #2 & Widely Voted Greatest Christmas Song of All Time', 2),
        ('Fiesta', 1988, 'If I Should Fall from Grace with God', 'UK Singles Chart #24 & Live Orchestral-Punk Staple', 6),
        ('Dirty Old Town', 1985, 'Rum Sodomy & the Lash', 'UK Singles Chart #62 & Definitive Folk-Punk Anthemic Cover', 4),
        ('Sally MacLennane', 1985, 'Rum Sodomy & the Lash', 'UK Singles Chart #51 & Pub-Rock Live Favorite', 3),
        ('A Pair of Brown Eyes', 1985, 'Rum Sodomy & the Lash', 'UK Singles Chart #72 & Poignant Shane MacGowan Ballad', 5),
        ('If I Should Fall from Grace with God', 1988, 'If I Should Fall from Grace with God', 'UK Singles Chart #58 & Benchmark Opening Track', 1),
        ('Tuesday Morning', 1993, 'Waiting for Herb', 'UK Singles Chart #18 & Post-MacGowan Era Hit', 1),
        ('Thousands Are Sailing', 1988, 'If I Should Fall from Grace with God', 'Acclaimed Philip Chevron-Penned Irish Immigration Anthem', 9)
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
        ('Fairytale of New York', 1987, 'UK Singles Chart #2 & Widely Voted Greatest Christmas Song of All Time'),
        ('Fiesta', 1988, 'UK Singles Chart #24 & Live Orchestral-Punk Staple'),
        ('Dirty Old Town', 1985, 'UK Singles Chart #62 & Definitive Folk-Punk Anthemic Cover'),
        ('Sally MacLennane', 1985, 'UK Singles Chart #51 & Pub-Rock Live Favorite'),
        ('A Pair of Brown Eyes', 1985, 'UK Singles Chart #72 & Poignant Shane MacGowan Ballad'),
        ('If I Should Fall from Grace with God', 1988, 'UK Singles Chart #58 & Benchmark Opening Track'),
        ('Tuesday Morning', 1993, 'UK Singles Chart #18 & Post-MacGowan Era Hit'),
        ('Thousands Are Sailing', 1988, 'Acclaimed Philip Chevron-Penned Irish Immigration Anthem')
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
        ('Fairytale of New York', 1987, 'If I Should Fall from Grace with God', 2),
        ('Fiesta', 1988, 'If I Should Fall from Grace with God', 6),
        ('Dirty Old Town', 1985, 'Rum Sodomy & the Lash', 4),
        ('Sally MacLennane', 1985, 'Rum Sodomy & the Lash', 3),
        ('A Pair of Brown Eyes', 1985, 'Rum Sodomy & the Lash', 5),
        ('If I Should Fall from Grace with God', 1988, 'If I Should Fall from Grace with God', 1),
        ('Tuesday Morning', 1993, 'Waiting for Herb', 1),
        ('Thousands Are Sailing', 1988, 'If I Should Fall from Grace with God', 9)
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
   AND band."es_id" = 'band-the-pogues'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
