WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('The Seeds', 1966, '32:28'),
        ('A Web of Sound', 1966, '36:42'),
        ('Future', 1967, '37:44'),
        ('A Full Spoon of Seedy Blues', 1967, '33:55'),
        ('Raw & Alive: The Seeds in Concert at Merlin''s Music Box', 1968, '43:08'),
        ('Fallin'' Off the Edge', 1977, '31:50'),
        ('Red Planet', 2004, '44:15')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-the-seeds'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
