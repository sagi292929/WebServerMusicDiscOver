WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Sweet Child o'' Mine', 1988, 'Appetite for Destruction', 'US Billboard Hot 100 #1', 9),
        ('November Rain', 1992, 'Use Your Illusion I', 'US Billboard Hot 100 #3', 10),
        ('Patience', 1989, 'G N'' R Lies', 'US Billboard Hot 100 #4', 1),
        ('Paradise City', 1989, 'Appetite for Destruction', 'US Billboard Hot 100 #5 & Ireland #1', 12),
        ('Welcome to the Jungle', 1988, 'Appetite for Destruction', 'US Billboard Hot 100 #7', 1),
        ('Don''t Cry', 1991, 'Use Your Illusion I', 'US Billboard Hot 100 #10 & Ireland #1', 4),
        ('Knockin'' on Heaven''s Door', 1992, 'Use Your Illusion II', 'UK Singles Chart #2 & Ireland #1', 11),
        ('You Could Be Mine', 1991, 'Use Your Illusion II', 'UK Singles Chart #3 & US Hot 100 #29', 3),
        ('Live and Let Die', 1991, 'Use Your Illusion I', 'UK Singles Chart #5 & US Hot 100 #33', 13),
        ('Civil War', 1993, 'Use Your Illusion II', 'US Mainstream Rock #4', 1)
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
        ('Sweet Child o'' Mine', 1988, 'US Billboard Hot 100 #1'),
        ('November Rain', 1992, 'US Billboard Hot 100 #3'),
        ('Patience', 1989, 'US Billboard Hot 100 #4'),
        ('Paradise City', 1989, 'US Billboard Hot 100 #5 & Ireland #1'),
        ('Welcome to the Jungle', 1988, 'US Billboard Hot 100 #7'),
        ('Don''t Cry', 1991, 'US Billboard Hot 100 #10 & Ireland #1'),
        ('Knockin'' on Heaven''s Door', 1992, 'UK Singles Chart #2 & Ireland #1'),
        ('You Could Be Mine', 1991, 'UK Singles Chart #3 & US Hot 100 #29'),
        ('Live and Let Die', 1991, 'UK Singles Chart #5 & US Hot 100 #33'),
        ('Civil War', 1993, 'US Mainstream Rock #4')
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
        ('Sweet Child o'' Mine', 1988, 'Appetite for Destruction', 9),
        ('November Rain', 1992, 'Use Your Illusion I', 10),
        ('Patience', 1989, 'G N'' R Lies', 1),
        ('Paradise City', 1989, 'Appetite for Destruction', 12),
        ('Welcome to the Jungle', 1988, 'Appetite for Destruction', 1),
        ('Don''t Cry', 1991, 'Use Your Illusion I', 4),
        ('Knockin'' on Heaven''s Door', 1992, 'Use Your Illusion II', 11),
        ('You Could Be Mine', 1991, 'Use Your Illusion II', 3),
        ('Live and Let Die', 1991, 'Use Your Illusion I', 13),
        ('Civil War', 1993, 'Use Your Illusion II', 1)
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
   AND band."es_id" = 'band-guns-n-roses'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
