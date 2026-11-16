WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Karma Chameleon', 1983, 'Colour by Numbers', 'UK Singles Chart #1 (6 Weeks) & US Billboard Hot 100 #1 (3 Weeks)', 2),
        ('Do You Really Want to Hurt Me', 1982, 'Kissing to Be Clever', 'UK Singles Chart #1, US Billboard Hot 100 #2 & International Breakthrough', 1),
        ('Church of the Poison Mind', 1983, 'Colour by Numbers', 'UK Singles Chart #2 & US Billboard Hot 100 #10', 1),
        ('Miss Me Blind', 1984, 'Colour by Numbers', 'US Billboard Hot 100 #5 & US Dance Club Songs #3', 3),
        ('It''s a Miracle', 1983, 'Colour by Numbers', 'UK Singles Chart #4 & US Billboard Hot 100 #13', 4),
        ('I''ll Tumble 4 Ya', 1983, 'Kissing to Be Clever', 'US Billboard Hot 100 #9 (Made Culture Club first since The Beatles to have 3 top 10 hits from a debut album)', 3),
        ('The War Song', 1984, 'Waking Up with the House on Fire', 'UK Singles Chart #2 & US Billboard Hot 100 #17', 1),
        ('Victims', 1983, 'Colour by Numbers', 'UK Singles Chart #3 & Acclaimed Lyrical Ballad', 5),
        ('Move Away', 1986, 'From Luxury to Heartache', 'UK Singles Chart #7 & US Billboard Hot 100 #12', 2)
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
        ('Karma Chameleon', 1983, 'UK Singles Chart #1 (6 Weeks) & US Billboard Hot 100 #1 (3 Weeks)'),
        ('Do You Really Want to Hurt Me', 1982, 'UK Singles Chart #1, US Billboard Hot 100 #2 & International Breakthrough'),
        ('Church of the Poison Mind', 1983, 'UK Singles Chart #2 & US Billboard Hot 100 #10'),
        ('Miss Me Blind', 1984, 'US Billboard Hot 100 #5 & US Dance Club Songs #3'),
        ('It''s a Miracle', 1983, 'UK Singles Chart #4 & US Billboard Hot 100 #13'),
        ('I''ll Tumble 4 Ya', 1983, 'US Billboard Hot 100 #9 (Made Culture Club first since The Beatles to have 3 top 10 hits from a debut album)'),
        ('The War Song', 1984, 'UK Singles Chart #2 & US Billboard Hot 100 #17'),
        ('Victims', 1983, 'UK Singles Chart #3 & Acclaimed Lyrical Ballad'),
        ('Move Away', 1986, 'UK Singles Chart #7 & US Billboard Hot 100 #12')
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
        ('Karma Chameleon', 1983, 'Colour by Numbers', 2),
        ('Do You Really Want to Hurt Me', 1982, 'Kissing to Be Clever', 1),
        ('Church of the Poison Mind', 1983, 'Colour by Numbers', 1),
        ('Miss Me Blind', 1984, 'Colour by Numbers', 3),
        ('It''s a Miracle', 1983, 'Colour by Numbers', 4),
        ('I''ll Tumble 4 Ya', 1983, 'Kissing to Be Clever', 3),
        ('The War Song', 1984, 'Waking Up with the House on Fire', 1),
        ('Victims', 1983, 'Colour by Numbers', 5),
        ('Move Away', 1986, 'From Luxury to Heartache', 2)
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
   AND band."es_id" = 'band-culture-club'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
