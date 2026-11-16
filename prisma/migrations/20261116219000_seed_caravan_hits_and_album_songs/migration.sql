WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Golf Girl', 1971, 'In the Land of Grey and Pink', 'Definitive Canterbury Scene & Whimsical Prog Anthem', 2),
        ('Nine Feet Underground', 1971, 'In the Land of Grey and Pink', '22-Minute Masterpiece & Progressive Rock Radio Staple', 5),
        ('For Richard', 1970, 'If I Could Do It All Over Again, I''d Do It All Over You', 'Acclaimed 14-Minute Jazz-Tinged Epic', 5),
        ('Winter Wine', 1971, 'In the Land of Grey and Pink', 'Dreamy, Mystical Fan-Favorite Highlight', 3),
        ('Memory Lain, Hugh / Headloss', 1973, 'For Girls Who Grow Plump in the Night', 'Punchy Progressive Suite & Live Concert Opener', 1),
        ('If I Could Do It All Over Again, I''d Do It All Over You', 1970, 'If I Could Do It All Over Again, I''d Do It All Over You', 'Jaunty Title Track & Early UK Radio Single', 1),
        ('Place of My Own', 1968, 'Caravan', 'Debut Single & Haunting Psych-Prog Classic', 4),
        ('The Love in Your Eye', 1972, 'Waterloo Lily', 'Sprawling Jazz-Rock Fusion Suite', 1),
        ('The Dog, The Dog, He''s at It Again', 1973, 'For Girls Who Grow Plump in the Night', 'Quintessential Canterbury Whimsical Pop-Prog', 2),
        ('In the Land of Grey and Pink', 1971, 'In the Land of Grey and Pink', 'Charming Fairy-Tale Title Track & Prog Anthology Staple', 6)
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
        ('Golf Girl', 1971, 'Definitive Canterbury Scene & Whimsical Prog Anthem'),
        ('Nine Feet Underground', 1971, '22-Minute Masterpiece & Progressive Rock Radio Staple'),
        ('For Richard', 1970, 'Acclaimed 14-Minute Jazz-Tinged Epic'),
        ('Winter Wine', 1971, 'Dreamy, Mystical Fan-Favorite Highlight'),
        ('Memory Lain, Hugh / Headloss', 1973, 'Punchy Progressive Suite & Live Concert Opener'),
        ('If I Could Do It All Over Again, I''d Do It All Over You', 1970, 'Jaunty Title Track & Early UK Radio Single'),
        ('Place of My Own', 1968, 'Debut Single & Haunting Psych-Prog Classic'),
        ('The Love in Your Eye', 1972, 'Sprawling Jazz-Rock Fusion Suite'),
        ('The Dog, The Dog, He''s at It Again', 1973, 'Quintessential Canterbury Whimsical Pop-Prog'),
        ('In the Land of Grey and Pink', 1971, 'Charming Fairy-Tale Title Track & Prog Anthology Staple')
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
        ('Golf Girl', 1971, 'In the Land of Grey and Pink', 2),
        ('Nine Feet Underground', 1971, 'In the Land of Grey and Pink', 5),
        ('For Richard', 1970, 'If I Could Do It All Over Again, I''d Do It All Over You', 5),
        ('Winter Wine', 1971, 'In the Land of Grey and Pink', 3),
        ('Memory Lain, Hugh / Headloss', 1973, 'For Girls Who Grow Plump in the Night', 1),
        ('If I Could Do It All Over Again, I''d Do It All Over You', 1970, 'If I Could Do It All Over Again, I''d Do It All Over You', 1),
        ('Place of My Own', 1968, 'Caravan', 4),
        ('The Love in Your Eye', 1972, 'Waterloo Lily', 1),
        ('The Dog, The Dog, He''s at It Again', 1973, 'For Girls Who Grow Plump in the Night', 2),
        ('In the Land of Grey and Pink', 1971, 'In the Land of Grey and Pink', 6)
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
   AND band."es_id" = 'band-caravan'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
