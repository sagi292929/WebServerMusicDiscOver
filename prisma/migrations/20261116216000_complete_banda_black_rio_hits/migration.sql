INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'Maria Fumaça', 1977, 'Classic Samba-Funk Instrumental Anthem', TRUE
WHERE NOT EXISTS (
    SELECT 1
    FROM "Song"
    WHERE "title" = 'Maria Fumaça'
      AND "year" = 1977
);

INSERT INTO "Song" ("title", "year", "achievement", "hit")
SELECT 'Saci Pererê', 1980, 'Pioneering Afro-Brazilian Instrumental Fusion', TRUE
WHERE NOT EXISTS (
    SELECT 1
    FROM "Song"
    WHERE "title" = 'Saci Pererê'
      AND "year" = 1980
);

UPDATE "Song"
SET "hit" = TRUE,
    "achievement" = 'Classic Samba-Funk Instrumental Anthem'
WHERE "title" = 'Maria Fumaça'
  AND "year" = 1977;

UPDATE "Song"
SET "hit" = TRUE,
    "achievement" = 'Pioneering Afro-Brazilian Instrumental Fusion'
WHERE "title" = 'Saci Pererê'
  AND "year" = 1980;

INSERT INTO "album_songs" ("album_id", "song_id", "track_number")
SELECT album."Id", song."Id", 1
FROM "Song" AS song
JOIN "Album" AS album ON album."title" = 'Maria Fumaça'
JOIN "Band" AS band ON band."Id" = album."BandId"
WHERE song."title" = 'Maria Fumaça'
  AND song."year" = 1977
  AND band."es_id" = 'band-banda-black-rio'
  AND NOT EXISTS (
      SELECT 1 FROM "album_songs" AS existing
      WHERE existing."album_id" = album."Id"
        AND existing."song_id" = song."Id"
  );

INSERT INTO "album_songs" ("album_id", "song_id", "track_number")
SELECT album."Id", song."Id", 1
FROM "Song" AS song
JOIN "Album" AS album ON album."title" = 'Saci Pererê'
JOIN "Band" AS band ON band."Id" = album."BandId"
WHERE song."title" = 'Saci Pererê'
  AND song."year" = 1980
  AND band."es_id" = 'band-banda-black-rio'
  AND NOT EXISTS (
      SELECT 1 FROM "album_songs" AS existing
      WHERE existing."album_id" = album."Id"
        AND existing."song_id" = song."Id"
  );
