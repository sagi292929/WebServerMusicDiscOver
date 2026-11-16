WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Enter Sandman', 1991, 'Metallica', 'US Billboard Hot 100 #16', 1),
        ('Nothing Else Matters', 1992, 'Metallica', 'US Billboard Hot 100 #34', 8),
        ('One', 1989, '...And Justice for All', 'US Billboard Hot 100 #35', 4),
        ('Master of Puppets', 1986, 'Master of Puppets', 'US Billboard Hot 100 #35 (2022)', 2),
        ('The Unforgiven', 1991, 'Metallica', 'US Billboard Hot 100 #35', 4),
        ('Until It Sleeps', 1996, 'Load', 'US Billboard Hot 100 #10', 4),
        ('For Whom the Bell Tolls', 1984, 'Ride the Lightning', 'Live & Rock Radio Staple', 3),
        ('Fade to Black', 1984, 'Ride the Lightning', 'Signature Thrash Power Ballad', 4),
        ('Sad but True', 1993, 'Metallica', 'US Mainstream Rock #15', 2),
        ('The Day That Never Comes', 2008, 'Death Magnetic', 'US Mainstream Rock #1', 4)
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
        ('Enter Sandman', 1991, 'US Billboard Hot 100 #16'),
        ('Nothing Else Matters', 1992, 'US Billboard Hot 100 #34'),
        ('One', 1989, 'US Billboard Hot 100 #35'),
        ('Master of Puppets', 1986, 'US Billboard Hot 100 #35 (2022)'),
        ('The Unforgiven', 1991, 'US Billboard Hot 100 #35'),
        ('Until It Sleeps', 1996, 'US Billboard Hot 100 #10'),
        ('For Whom the Bell Tolls', 1984, 'Live & Rock Radio Staple'),
        ('Fade to Black', 1984, 'Signature Thrash Power Ballad'),
        ('Sad but True', 1993, 'US Mainstream Rock #15'),
        ('The Day That Never Comes', 2008, 'US Mainstream Rock #1')
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
        ('Enter Sandman', 1991, 'Metallica', 1),
        ('Nothing Else Matters', 1992, 'Metallica', 8),
        ('One', 1989, '...And Justice for All', 4),
        ('Master of Puppets', 1986, 'Master of Puppets', 2),
        ('The Unforgiven', 1991, 'Metallica', 4),
        ('Until It Sleeps', 1996, 'Load', 4),
        ('For Whom the Bell Tolls', 1984, 'Ride the Lightning', 3),
        ('Fade to Black', 1984, 'Ride the Lightning', 4),
        ('Sad but True', 1993, 'Metallica', 2),
        ('The Day That Never Comes', 2008, 'Death Magnetic', 4)
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
   AND band."es_id" = 'band-metallica'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
