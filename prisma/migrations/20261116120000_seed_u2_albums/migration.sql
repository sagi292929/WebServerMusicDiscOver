WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Boy', 1980, '42:17'),
        ('October', 1981, '41:05'),
        ('War', 1983, '42:03'),
        ('The Unforgettable Fire', 1984, '42:38'),
        ('The Joshua Tree', 1987, '50:11'),
        ('Rattle and Hum', 1988, '72:27'),
        ('Achtung Baby', 1991, '55:27'),
        ('Zooropa', 1993, '51:15'),
        ('Pop', 1997, '60:09'),
        ('All That You Can''t Leave Behind', 2000, '49:05'),
        ('How to Dismantle an Atomic Bomb', 2004, '49:08'),
        ('No Line on the Horizon', 2009, '53:44'),
        ('Songs of Innocence', 2014, '48:11'),
        ('Songs of Experience', 2017, '51:07'),
        ('Songs of Surrender', 2023, '162:25'),
        ('Carnaval de Luz', 2026, '47:02')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-u2'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
