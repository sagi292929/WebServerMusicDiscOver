WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Bohemian Rhapsody', 1975, 'A Night at the Opera', 'UK Singles Chart #1 (9 Weeks)', 11),
        ('Another One Bites the Dust', 1980, 'The Game', 'US Billboard Hot 100 #1', 7),
        ('Crazy Little Thing Called Love', 1979, 'The Game', 'US Billboard Hot 100 #1', 1),
        ('We Will Rock You', 1977, 'News of the World', 'Global Stadium Anthem', 1),
        ('We Are the Champions', 1977, 'News of the World', 'US Billboard Hot 100 #4', 6),
        ('Under Pressure', 1981, 'Hot Space', 'UK Singles Chart #1 (with David Bowie)', 11),
        ('Don''t Stop Me Now', 1979, 'Jazz', 'UK Singles Chart #9', 12),
        ('Somebody to Love', 1976, 'A Day at the Races', 'UK Singles Chart #2', 2),
        ('Radio Ga Ga', 1984, 'The Works', 'UK Singles Chart #2', 2),
        ('Killer Queen', 1974, 'Sheer Heart Attack', 'UK Singles Chart #2', 2)
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
        ('Bohemian Rhapsody', 1975, 'UK Singles Chart #1 (9 Weeks)'),
        ('Another One Bites the Dust', 1980, 'US Billboard Hot 100 #1'),
        ('Crazy Little Thing Called Love', 1979, 'US Billboard Hot 100 #1'),
        ('We Will Rock You', 1977, 'Global Stadium Anthem'),
        ('We Are the Champions', 1977, 'US Billboard Hot 100 #4'),
        ('Under Pressure', 1981, 'UK Singles Chart #1 (with David Bowie)'),
        ('Don''t Stop Me Now', 1979, 'UK Singles Chart #9'),
        ('Somebody to Love', 1976, 'UK Singles Chart #2'),
        ('Radio Ga Ga', 1984, 'UK Singles Chart #2'),
        ('Killer Queen', 1974, 'UK Singles Chart #2')
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
        ('Bohemian Rhapsody', 1975, 'A Night at the Opera', 11),
        ('Another One Bites the Dust', 1980, 'The Game', 7),
        ('Crazy Little Thing Called Love', 1979, 'The Game', 1),
        ('We Will Rock You', 1977, 'News of the World', 1),
        ('We Are the Champions', 1977, 'News of the World', 6),
        ('Under Pressure', 1981, 'Hot Space', 11),
        ('Don''t Stop Me Now', 1979, 'Jazz', 12),
        ('Somebody to Love', 1976, 'A Day at the Races', 2),
        ('Radio Ga Ga', 1984, 'The Works', 2),
        ('Killer Queen', 1974, 'Sheer Heart Attack', 2)
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
   AND band."es_id" = 'band-queen'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
