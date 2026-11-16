WITH hits(title, year, achievement) AS (
    VALUES
        ('With or Without You', 1987, 'US Billboard Hot 100 #1 (3 Weeks)'),
        ('I Still Haven''t Found What I''m Looking For', 1987, 'US Billboard Hot 100 #1 (2 Weeks)'),
        ('One', 1992, 'US Billboard Alternative Airplay #1'),
        ('Beautiful Day', 2000, 'Grammy Award for Record of the Year & UK #1'),
        ('Pride (In the Name of Love)', 1984, 'UK Singles Chart #3'),
        ('Where the Streets Have No Name', 1987, 'US Billboard Hot 100 #13 & UK #4'),
        ('Desire', 1988, 'First UK Singles Chart #1 & US Hot 100 #3'),
        ('Vertigo', 2004, 'UK Singles Chart #1 & Grammy Winner'),
        ('Sunday Bloody Sunday', 1983, 'Signature Political Anthem & Rock Radio Staple'),
        ('Mysterious Ways', 1991, 'US Billboard Modern Rock Tracks #1')
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
        ('With or Without You', 1987, 'US Billboard Hot 100 #1 (3 Weeks)'),
        ('I Still Haven''t Found What I''m Looking For', 1987, 'US Billboard Hot 100 #1 (2 Weeks)'),
        ('One', 1992, 'US Billboard Alternative Airplay #1'),
        ('Beautiful Day', 2000, 'Grammy Award for Record of the Year & UK #1'),
        ('Pride (In the Name of Love)', 1984, 'UK Singles Chart #3'),
        ('Where the Streets Have No Name', 1987, 'US Billboard Hot 100 #13 & UK #4'),
        ('Desire', 1988, 'First UK Singles Chart #1 & US Hot 100 #3'),
        ('Vertigo', 2004, 'UK Singles Chart #1 & Grammy Winner'),
        ('Sunday Bloody Sunday', 1983, 'Signature Political Anthem & Rock Radio Staple'),
        ('Mysterious Ways', 1991, 'US Billboard Modern Rock Tracks #1')
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
        ('With or Without You', 1987, 'The Joshua Tree', 3),
        ('I Still Haven''t Found What I''m Looking For', 1987, 'The Joshua Tree', 2),
        ('One', 1992, 'Achtung Baby', 3),
        ('Beautiful Day', 2000, 'All That You Can''t Leave Behind', 1),
        ('Pride (In the Name of Love)', 1984, 'The Unforgettable Fire', 3),
        ('Where the Streets Have No Name', 1987, 'The Joshua Tree', 4),
        ('Desire', 1988, 'Rattle and Hum', 1),
        ('Vertigo', 2004, 'How to Dismantle an Atomic Bomb', 1),
        ('Sunday Bloody Sunday', 1983, 'War', 2),
        ('Mysterious Ways', 1991, 'Achtung Baby', 4)
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
   AND band."es_id" = 'band-u2'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
