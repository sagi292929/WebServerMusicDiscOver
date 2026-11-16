WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Maria Fumaça', 1977, '32:21'),
        ('Gafieira Universal', 1978, '36:09'),
        ('Saci Pererê', 1980, '34:28'),
        ('Movimento', 2001, '52:14'),
        ('Super Nova Samba Funk', 2011, '43:46'),
        ('O Som das Américas', 2019, '40:12')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-banda-black-rio'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
