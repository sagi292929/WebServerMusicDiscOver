WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Next One Is Real', 1984, 'Deadly Weapons', 'US Dance-Oriented Rock (D.O.R.) Club Hit', 1),
        ('When I Go', 1985, 'Raging Souls', 'Featured in Wim Wenders'' Film "Wings of Desire"', 1),
        ('Inner Station', 1987, 'The Figure One Cuts', 'Signature Darkwave / Post-Punk Classic', 1),
        ('My Will', 1985, 'Raging Souls', 'European College Radio & Live Staple', 2),
        ('Dedicated', 1982, 'One by One', 'Belgian & European Indie Club Favorite', 1),
        ('Babylonian Tower', 1982, 'One by One', 'Cult Post-Punk & Coldwave Essential', 2),
        ('New Clear Twist', 1987, 'The Figure One Cuts', 'Alternative Radio & Live Reunion Staple', 2),
        ('Not Knowing', 1984, 'Deadly Weapons', 'Israeli & European Alternative Rock Classic', 2)
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
        ('Next One Is Real', 1984, 'US Dance-Oriented Rock (D.O.R.) Club Hit'),
        ('When I Go', 1985, 'Featured in Wim Wenders'' Film "Wings of Desire"'),
        ('Inner Station', 1987, 'Signature Darkwave / Post-Punk Classic'),
        ('My Will', 1985, 'European College Radio & Live Staple'),
        ('Dedicated', 1982, 'Belgian & European Indie Club Favorite'),
        ('Babylonian Tower', 1982, 'Cult Post-Punk & Coldwave Essential'),
        ('New Clear Twist', 1987, 'Alternative Radio & Live Reunion Staple'),
        ('Not Knowing', 1984, 'Israeli & European Alternative Rock Classic')
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
        ('Next One Is Real', 1984, 'Deadly Weapons', 1),
        ('When I Go', 1985, 'Raging Souls', 1),
        ('Inner Station', 1987, 'The Figure One Cuts', 1),
        ('My Will', 1985, 'Raging Souls', 2),
        ('Dedicated', 1982, 'One by One', 1),
        ('Babylonian Tower', 1982, 'One by One', 2),
        ('New Clear Twist', 1987, 'The Figure One Cuts', 2),
        ('Not Knowing', 1984, 'Deadly Weapons', 2)
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
   AND band."es_id" = 'band-minimal-compact'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
