WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Roots Bloody Roots', 1996, 'Roots', 'UK Singles Chart #19 & Signature Groove Metal Anthem', 1),
        ('Ratamahatta', 1996, 'Roots', 'UK Singles Chart #23 & MTV VMA Winner (Best Rock Video)', 5),
        ('Attitude', 1996, 'Roots', 'UK Singles Chart #46', 4),
        ('Slave New World', 1994, 'Chaos A.D.', 'UK Singles Chart #46', 3),
        ('Refuse/Resist', 1993, 'Chaos A.D.', 'UK Singles Chart #51 & Live Concert Opener Staple', 1),
        ('Territory', 1993, 'Chaos A.D.', 'UK Singles Chart #66 & International MTV Breakthrough', 2),
        ('Arise', 1991, 'Arise', 'Benchmark 1990s Thrash Metal Classic', 1),
        ('Dead Embryonic Cells', 1991, 'Arise', 'Headbangers Ball & Metal Radio Staple', 2),
        ('Inner Self', 1989, 'Beneath the Remains', 'First Official Music Video & Breakthrough Thrash Track', 5),
        ('Choke', 1998, 'Against', 'UK Singles Chart #91 & Derrick Green Era Debut Single', 1)
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
        ('Roots Bloody Roots', 1996, 'UK Singles Chart #19 & Signature Groove Metal Anthem'),
        ('Ratamahatta', 1996, 'UK Singles Chart #23 & MTV VMA Winner (Best Rock Video)'),
        ('Attitude', 1996, 'UK Singles Chart #46'),
        ('Slave New World', 1994, 'UK Singles Chart #46'),
        ('Refuse/Resist', 1993, 'UK Singles Chart #51 & Live Concert Opener Staple'),
        ('Territory', 1993, 'UK Singles Chart #66 & International MTV Breakthrough'),
        ('Arise', 1991, 'Benchmark 1990s Thrash Metal Classic'),
        ('Dead Embryonic Cells', 1991, 'Headbangers Ball & Metal Radio Staple'),
        ('Inner Self', 1989, 'First Official Music Video & Breakthrough Thrash Track'),
        ('Choke', 1998, 'UK Singles Chart #91 & Derrick Green Era Debut Single')
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
        ('Roots Bloody Roots', 1996, 'Roots', 1),
        ('Ratamahatta', 1996, 'Roots', 5),
        ('Attitude', 1996, 'Roots', 4),
        ('Slave New World', 1994, 'Chaos A.D.', 3),
        ('Refuse/Resist', 1993, 'Chaos A.D.', 1),
        ('Territory', 1993, 'Chaos A.D.', 2),
        ('Arise', 1991, 'Arise', 1),
        ('Dead Embryonic Cells', 1991, 'Arise', 2),
        ('Inner Self', 1989, 'Beneath the Remains', 5),
        ('Choke', 1998, 'Against', 1)
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
   AND band."es_id" = 'band-sepultura'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
