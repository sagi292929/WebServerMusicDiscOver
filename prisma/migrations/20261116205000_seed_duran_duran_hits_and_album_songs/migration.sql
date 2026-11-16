WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('The Reflex', 1984, 'Seven and the Ragged Tiger', 'US Billboard Hot 100 #1 & UK Singles Chart #1', 1),
        ('A View to a Kill', 1985, 'A View to a Kill (Soundtrack)', 'US Billboard Hot 100 #1 (Only James Bond Theme #1 in US)', 1),
        ('Hungry Like the Wolf', 1982, 'Rio', 'US Billboard Hot 100 #3 & UK Singles Chart #5', 2),
        ('Ordinary World', 1993, 'Duran Duran (The Wedding Album)', 'US Billboard Hot 100 #3 & Ivor Novello Award Winner', 3),
        ('Is There Something I Should Know?', 1983, 'Duran Duran (1983 US Reissue)', 'UK Singles Chart #1 & US Billboard Hot 100 #4', 1),
        ('Notorious', 1986, 'Notorious', 'US Billboard Hot 100 #2 & UK Singles Chart #7', 1),
        ('The Wild Boys', 1984, 'Arena', 'US Billboard Hot 100 #2 & UK Singles Chart #2', 1),
        ('Union of the Snake', 1983, 'Seven and the Ragged Tiger', 'US Billboard Hot 100 #3 & UK Singles Chart #3', 2),
        ('Come Undone', 1993, 'Duran Duran (The Wedding Album)', 'US Billboard Hot 100 #7 & UK Singles Chart #13', 4),
        ('Rio', 1982, 'Rio', 'UK Singles Chart #9 & Signature New Romantic Anthem', 10)
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
        ('The Reflex', 1984, 'US Billboard Hot 100 #1 & UK Singles Chart #1'),
        ('A View to a Kill', 1985, 'US Billboard Hot 100 #1 (Only James Bond Theme #1 in US)'),
        ('Hungry Like the Wolf', 1982, 'US Billboard Hot 100 #3 & UK Singles Chart #5'),
        ('Ordinary World', 1993, 'US Billboard Hot 100 #3 & Ivor Novello Award Winner'),
        ('Is There Something I Should Know?', 1983, 'UK Singles Chart #1 & US Billboard Hot 100 #4'),
        ('Notorious', 1986, 'US Billboard Hot 100 #2 & UK Singles Chart #7'),
        ('The Wild Boys', 1984, 'US Billboard Hot 100 #2 & UK Singles Chart #2'),
        ('Union of the Snake', 1983, 'US Billboard Hot 100 #3 & UK Singles Chart #3'),
        ('Come Undone', 1993, 'US Billboard Hot 100 #7 & UK Singles Chart #13'),
        ('Rio', 1982, 'UK Singles Chart #9 & Signature New Romantic Anthem')
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
        ('The Reflex', 1984, 'Seven and the Ragged Tiger', 1),
        ('A View to a Kill', 1985, 'A View to a Kill (Soundtrack)', 1),
        ('Hungry Like the Wolf', 1982, 'Rio', 2),
        ('Ordinary World', 1993, 'Duran Duran (The Wedding Album)', 3),
        ('Is There Something I Should Know?', 1983, 'Duran Duran (1983 US Reissue)', 1),
        ('Notorious', 1986, 'Notorious', 1),
        ('The Wild Boys', 1984, 'Arena', 1),
        ('Union of the Snake', 1983, 'Seven and the Ragged Tiger', 2),
        ('Come Undone', 1993, 'Duran Duran (The Wedding Album)', 4),
        ('Rio', 1982, 'Rio', 10)
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
   AND band."es_id" = 'band-duran-duran'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
