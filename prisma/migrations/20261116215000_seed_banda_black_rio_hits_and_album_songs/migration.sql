WITH hits(title, year, albumTitle, achievement, trackNumber) AS (
    VALUES
        ('Maria Fumaça', 1977, 'Maria Fumaça', 'Classic Samba-Funk Instrumental Anthem', 1),
        ('Mr. Funky Samba', 1977, 'Maria Fumaça', 'Definitive Brazilian Groove Standard', 2),
        ('Na Baixa Do Sapateiro', 1977, 'Maria Fumaça', 'Breakthrough Single & Samba-Soul Fusion', 3),
        ('Casa Da Luiza', 1978, 'Gafieira Universal', 'Crucial Jazz-Funk / Gafieira Highlight', 1),
        ('Gafieira Universal', 1978, 'Gafieira Universal', 'Title Track & Global Rare Groove Classic', 1),
        ('Saci Pererê', 1980, 'Saci Pererê', 'Pioneering Afro-Brazilian Instrumental Fusion', 1),
        ('Miss Cheryl', 1980, 'Saci Pererê', 'Club & Radio Soul Favorite', 2),
        ('Metalurgica', 1977, 'Maria Fumaça', 'Sampled Hip-Hop & Breakbeat Staple', 4),
        ('Expresso Itapeva', 1978, 'Gafieira Universal', 'Acclaimed Instrumental Brass Showcase', 3),
        ('Super Nova Samba Funk', 2011, 'Super Nova Samba Funk', 'International Revival & Contemporary Latin Groove Hit', 1)
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
        ('Maria Fumaça', 1977, 'Classic Samba-Funk Instrumental Anthem'),
        ('Mr. Funky Samba', 1977, 'Definitive Brazilian Groove Standard'),
        ('Na Baixa Do Sapateiro', 1977, 'Breakthrough Single & Samba-Soul Fusion'),
        ('Casa Da Luiza', 1978, 'Crucial Jazz-Funk / Gafieira Highlight'),
        ('Gafieira Universal', 1978, 'Title Track & Global Rare Groove Classic'),
        ('Saci Pererê', 1980, 'Pioneering Afro-Brazilian Instrumental Fusion'),
        ('Miss Cheryl', 1980, 'Club & Radio Soul Favorite'),
        ('Metalurgica', 1977, 'Sampled Hip-Hop & Breakbeat Staple'),
        ('Expresso Itapeva', 1978, 'Acclaimed Instrumental Brass Showcase'),
        ('Super Nova Samba Funk', 2011, 'International Revival & Contemporary Latin Groove Hit')
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
        ('Maria Fumaça', 1977, 'Maria Fumaça', 1),
        ('Mr. Funky Samba', 1977, 'Maria Fumaça', 2),
        ('Na Baixa Do Sapateiro', 1977, 'Maria Fumaça', 3),
        ('Casa Da Luiza', 1978, 'Gafieira Universal', 1),
        ('Gafieira Universal', 1978, 'Gafieira Universal', 1),
        ('Saci Pererê', 1980, 'Saci Pererê', 1),
        ('Miss Cheryl', 1980, 'Saci Pererê', 2),
        ('Metalurgica', 1977, 'Maria Fumaça', 4),
        ('Expresso Itapeva', 1978, 'Gafieira Universal', 3),
        ('Super Nova Samba Funk', 2011, 'Super Nova Samba Funk', 1)
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
   AND band."es_id" = 'band-banda-black-rio'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
