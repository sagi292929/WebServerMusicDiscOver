WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Zombie', 1994, 'No Need to Argue', 'US Modern Rock Tracks #1 (6 Weeks) & France/Germany #1', 5),
        ('Linger', 1993, 'Everybody Else Is Doing It, So Why Can''t We?', 'US Billboard Hot 100 #8 & UK Singles Chart #14', 5),
        ('Dreams', 1992, 'Everybody Else Is Doing It, So Why Can''t We?', 'US Billboard Hot 100 #42 & UK Singles Chart #27', 3),
        ('Salvation', 1996, 'To the Faithful Departed', 'US Modern Rock Tracks #1 (4 Weeks) & UK Singles Chart #13', 2),
        ('Ode to My Family', 1994, 'No Need to Argue', 'US Modern Rock Tracks #11 & UK Singles Chart #26', 2),
        ('When You''re Gone', 1996, 'To the Faithful Departed', 'US Billboard Hot 100 #22 (Double A-Side) & UK #33', 3),
        ('Free to Decide', 1996, 'To the Faithful Departed', 'US Billboard Hot 100 #22 (Double A-Side) & UK #33', 4),
        ('Promises', 1999, 'Bury the Hatchet', 'US Modern Rock Tracks #12 & UK Singles Chart #13', 3),
        ('Ridiculous Thoughts', 1995, 'No Need to Argue', 'US Modern Rock Tracks #14 & UK Singles Chart #20', 10),
        ('I Can''t Be with You', 1995, 'No Need to Argue', 'UK Singles Chart #23 & Ireland #21', 3)
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
        ('Zombie', 1994, 'US Modern Rock Tracks #1 (6 Weeks) & France/Germany #1'),
        ('Linger', 1993, 'US Billboard Hot 100 #8 & UK Singles Chart #14'),
        ('Dreams', 1992, 'US Billboard Hot 100 #42 & UK Singles Chart #27'),
        ('Salvation', 1996, 'US Modern Rock Tracks #1 (4 Weeks) & UK Singles Chart #13'),
        ('Ode to My Family', 1994, 'US Modern Rock Tracks #11 & UK Singles Chart #26'),
        ('When You''re Gone', 1996, 'US Billboard Hot 100 #22 (Double A-Side) & UK #33'),
        ('Free to Decide', 1996, 'US Billboard Hot 100 #22 (Double A-Side) & UK #33'),
        ('Promises', 1999, 'US Modern Rock Tracks #12 & UK Singles Chart #13'),
        ('Ridiculous Thoughts', 1995, 'US Modern Rock Tracks #14 & UK Singles Chart #20'),
        ('I Can''t Be with You', 1995, 'UK Singles Chart #23 & Ireland #21')
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
        ('Zombie', 1994, 'No Need to Argue', 5),
        ('Linger', 1993, 'Everybody Else Is Doing It, So Why Can''t We?', 5),
        ('Dreams', 1992, 'Everybody Else Is Doing It, So Why Can''t We?', 3),
        ('Salvation', 1996, 'To the Faithful Departed', 2),
        ('Ode to My Family', 1994, 'No Need to Argue', 2),
        ('When You''re Gone', 1996, 'To the Faithful Departed', 3),
        ('Free to Decide', 1996, 'To the Faithful Departed', 4),
        ('Promises', 1999, 'Bury the Hatchet', 3),
        ('Ridiculous Thoughts', 1995, 'No Need to Argue', 10),
        ('I Can''t Be with You', 1995, 'No Need to Argue', 3)
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
   AND band."es_id" = 'band-the-cranberries'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
