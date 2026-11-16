WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Please Please Me', 1963, '32:24'),
        ('With the Beatles', 1963, '33:07'),
        ('A Hard Day''s Night', 1964, '30:13'),
        ('Beatles for Sale', 1964, '34:13'),
        ('Help!', 1965, '33:50'),
        ('Rubber Soul', 1965, '35:50'),
        ('Revolver', 1966, '34:43'),
        ('Sgt. Pepper''s Lonely Hearts Club Band', 1967, '39:52'),
        ('Magical Mystery Tour', 1967, '36:48'),
        ('The Beatles', 1968, '93:33'),
        ('Yellow Submarine', 1969, '39:16'),
        ('Abbey Road', 1969, '47:03'),
        ('Let It Be', 1970, '35:10')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-the-beatles'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
