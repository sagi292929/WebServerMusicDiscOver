WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Appetite for Destruction', 1987, '53:51'),
        ('G N'' R Lies', 1988, '33:25'),
        ('Use Your Illusion I', 1991, '76:04'),
        ('Use Your Illusion II', 1991, '75:52'),
        ('"The Spaghetti Incident?"', 1993, '46:02'),
        ('Chinese Democracy', 2008, '71:18')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-guns-n-roses'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
