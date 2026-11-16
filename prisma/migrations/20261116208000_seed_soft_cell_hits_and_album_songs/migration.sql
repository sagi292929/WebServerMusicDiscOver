WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Tainted Love', 1981, 'Non-Stop Erotic Cabaret', 'UK Singles Chart #1 & US Billboard Hot 100 #8', 4),
        ('Torch', 1982, 'Torch (Non-Album Single)', 'UK Singles Chart #2', 1),
        ('Say Hello, Wave Goodbye', 1982, 'Non-Stop Erotic Cabaret', 'UK Singles Chart #3', 10),
        ('What!', 1982, 'Non-Stop Ecstatic Dancing', 'UK Singles Chart #3', 1),
        ('Bedsitter', 1981, 'Non-Stop Erotic Cabaret', 'UK Singles Chart #4', 2),
        ('Soul Inside', 1983, 'This Last Night in Sodom', 'UK Singles Chart #16', 3),
        ('Where the Heart Is', 1982, 'The Art of Falling Apart', 'UK Singles Chart #21', 1),
        ('Down in the Subway', 1984, 'This Last Night in Sodom', 'UK Singles Chart #24', 1),
        ('Numbers / Barriers', 1983, 'The Art of Falling Apart', 'UK Singles Chart #25', 2),
        ('Memorabilia', 1981, 'Memorabilia (Non-Album Single)', 'US Dance Club Songs #35 & Pioneering Acid/Techno Club Classic', 1)
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
        ('Tainted Love', 1981, 'UK Singles Chart #1 & US Billboard Hot 100 #8'),
        ('Torch', 1982, 'UK Singles Chart #2'),
        ('Say Hello, Wave Goodbye', 1982, 'UK Singles Chart #3'),
        ('What!', 1982, 'UK Singles Chart #3'),
        ('Bedsitter', 1981, 'UK Singles Chart #4'),
        ('Soul Inside', 1983, 'UK Singles Chart #16'),
        ('Where the Heart Is', 1982, 'UK Singles Chart #21'),
        ('Down in the Subway', 1984, 'UK Singles Chart #24'),
        ('Numbers / Barriers', 1983, 'UK Singles Chart #25'),
        ('Memorabilia', 1981, 'US Dance Club Songs #35 & Pioneering Acid/Techno Club Classic')
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
        ('Tainted Love', 1981, 'Non-Stop Erotic Cabaret', 4),
        ('Torch', 1982, 'Torch (Non-Album Single)', 1),
        ('Say Hello, Wave Goodbye', 1982, 'Non-Stop Erotic Cabaret', 10),
        ('What!', 1982, 'Non-Stop Ecstatic Dancing', 1),
        ('Bedsitter', 1981, 'Non-Stop Erotic Cabaret', 2),
        ('Soul Inside', 1983, 'This Last Night in Sodom', 3),
        ('Where the Heart Is', 1982, 'The Art of Falling Apart', 1),
        ('Down in the Subway', 1984, 'This Last Night in Sodom', 1),
        ('Numbers / Barriers', 1983, 'The Art of Falling Apart', 2),
        ('Memorabilia', 1981, 'Memorabilia (Non-Album Single)', 1)
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
   AND band."es_id" = 'band-soft-cell'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
