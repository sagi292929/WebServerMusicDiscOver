WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Seven Stories into Eight', 1982, '43:15'),
        ('Tales from the Lush Attic', 1983, '44:40'),
        ('The Wake', 1985, '50:32'),
        ('Nomzamo', 1987, '53:18'),
        ('Are You Sitting Comfortably?', 1989, '45:21'),
        ('Ever', 1993, '56:15'),
        ('Subterranea', 1997, '102:14'),
        ('The Seventh House', 2000, '56:48'),
        ('Dark Matter', 2004, '55:19'),
        ('Frequency', 2009, '65:33'),
        ('The Road of Bones', 2014, '57:40'),
        ('Resistance', 2019, '109:05'),
        ('Dominion', 2025, '64:12')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-iq'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
