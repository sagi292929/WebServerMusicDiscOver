WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Duran Duran', 1981, '39:42'),
        ('Rio', 1982, '43:05'),
        ('Seven and the Ragged Tiger', 1983, '47:37'),
        ('Notorious', 1986, '45:23'),
        ('Big Thing', 1988, '52:09'),
        ('Liberty', 1990, '46:50'),
        ('Duran Duran (The Wedding Album)', 1993, '59:42'),
        ('Thank You', 1995, '55:56'),
        ('Medazzaland', 1997, '53:58'),
        ('Pop Trash', 2000, '58:02'),
        ('Astronaut', 2004, '54:47'),
        ('Red Carpet Massacre', 2007, '48:58'),
        ('All You Need Is Now', 2010, '37:13'),
        ('Paper Gods', 2015, '52:01'),
        ('Future Past', 2021, '42:12'),
        ('Danse Macabre', 2023, '52:20')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-duran-duran'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
