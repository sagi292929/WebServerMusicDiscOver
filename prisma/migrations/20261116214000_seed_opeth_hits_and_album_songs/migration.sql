WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Ghost of Perdition', 2005, 'Ghost Reveries', 'Fan-Favorite & Progressive Death Metal Masterpiece', 5),
        ('Bleak', 2001, 'Blackwater Park', 'Benchmark Track Featuring Steven Wilson', 2),
        ('The Drapery Falls', 2001, 'Blackwater Park', 'Critical Acclaim & Prog-Metal Radio Staple', 5),
        ('Demon of the Fall', 1998, 'My Arms, Your Hearse', 'Breakthrough Extreme Metal Anthem', 4),
        ('Windowpane', 2003, 'Damnation', 'Signature Acoustic / Clean Progressive Rock Single', 1),
        ('The Grand Conjuration', 2005, 'Ghost Reveries', 'Billboard European Radio Chart & MTV Video Airplay', 7),
        ('Deliverance', 2002, 'Deliverance', 'Legendary Epics / Concert Closer', 6),
        ('Sorceress', 2016, 'Sorceress', 'US Billboard Mainstream Rock Top 20 Hit', 1),
        ('Reverie/Harlequin Forest', 2005, 'Ghost Reveries', 'Acclaimed Epic Multi-Movement Composition', 7),
        ('Blackwater Park', 2001, 'Blackwater Park', 'Definitive 12-Minute Closing Epic', 8)
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
        ('Ghost of Perdition', 2005, 'Fan-Favorite & Progressive Death Metal Masterpiece'),
        ('Bleak', 2001, 'Benchmark Track Featuring Steven Wilson'),
        ('The Drapery Falls', 2001, 'Critical Acclaim & Prog-Metal Radio Staple'),
        ('Demon of the Fall', 1998, 'Breakthrough Extreme Metal Anthem'),
        ('Windowpane', 2003, 'Signature Acoustic / Clean Progressive Rock Single'),
        ('The Grand Conjuration', 2005, 'Billboard European Radio Chart & MTV Video Airplay'),
        ('Deliverance', 2002, 'Legendary Epics / Concert Closer'),
        ('Sorceress', 2016, 'US Billboard Mainstream Rock Top 20 Hit'),
        ('Reverie/Harlequin Forest', 2005, 'Acclaimed Epic Multi-Movement Composition'),
        ('Blackwater Park', 2001, 'Definitive 12-Minute Closing Epic')
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
        ('Ghost of Perdition', 2005, 'Ghost Reveries', 5),
        ('Bleak', 2001, 'Blackwater Park', 2),
        ('The Drapery Falls', 2001, 'Blackwater Park', 5),
        ('Demon of the Fall', 1998, 'My Arms, Your Hearse', 4),
        ('Windowpane', 2003, 'Damnation', 1),
        ('The Grand Conjuration', 2005, 'Ghost Reveries', 7),
        ('Deliverance', 2002, 'Deliverance', 6),
        ('Sorceress', 2016, 'Sorceress', 1),
        ('Reverie/Harlequin Forest', 2005, 'Ghost Reveries', 7),
        ('Blackwater Park', 2001, 'Blackwater Park', 8)
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
   AND band."es_id" = 'band-opeth'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
