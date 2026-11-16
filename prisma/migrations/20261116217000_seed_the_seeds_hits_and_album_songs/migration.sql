WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Pushin'' Too Hard', 1965, 'The Seeds', 'US Billboard Hot 100 #36 & Garage Rock Anthem', 1),
        ('Can''t Seem to Make You Mine', 1965, 'The Seeds', 'US Billboard Hot 100 #41 & Proto-Punk Classic', 4),
        ('Mr. Farmer', 1966, 'A Web of Sound', 'US Billboard Hot 100 #86 & Underground Cult Hit', 1),
        ('A Thousand Shadows', 1967, 'Future', 'US Billboard Hot 100 #72 & Psychedelic Rock Staple', 1),
        ('March of the Flower Children', 1967, 'Future', 'Definitive 1967 Summer of Love Psychedelic Anthem', 2),
        ('No Escape', 1966, 'The Seeds', 'Featured in Cult Garage Rock Compilations (Nuggets)', 2),
        ('Evil Hoodoo', 1966, 'A Web of Sound', 'Pioneering Proto-Punk Extended Jam (Over 5 Minutes)', 7)
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
        ('Pushin'' Too Hard', 1965, 'US Billboard Hot 100 #36 & Garage Rock Anthem'),
        ('Can''t Seem to Make You Mine', 1965, 'US Billboard Hot 100 #41 & Proto-Punk Classic'),
        ('Mr. Farmer', 1966, 'US Billboard Hot 100 #86 & Underground Cult Hit'),
        ('A Thousand Shadows', 1967, 'US Billboard Hot 100 #72 & Psychedelic Rock Staple'),
        ('March of the Flower Children', 1967, 'Definitive 1967 Summer of Love Psychedelic Anthem'),
        ('No Escape', 1966, 'Featured in Cult Garage Rock Compilations (Nuggets)'),
        ('Evil Hoodoo', 1966, 'Pioneering Proto-Punk Extended Jam (Over 5 Minutes)')
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
        ('Pushin'' Too Hard', 1965, 'The Seeds', 1),
        ('Can''t Seem to Make You Mine', 1965, 'The Seeds', 4),
        ('Mr. Farmer', 1966, 'A Web of Sound', 1),
        ('A Thousand Shadows', 1967, 'Future', 1),
        ('March of the Flower Children', 1967, 'Future', 2),
        ('No Escape', 1966, 'The Seeds', 2),
        ('Evil Hoodoo', 1966, 'A Web of Sound', 7)
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
   AND band."es_id" = 'band-the-seeds'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
