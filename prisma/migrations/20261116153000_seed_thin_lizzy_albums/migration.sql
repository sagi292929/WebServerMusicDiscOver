WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Thin Lizzy', 1971, '37:37'),
        ('Shades of a Blue Orphanage', 1972, '43:28'),
        ('Vagabonds of the Western World', 1973, '40:44'),
        ('Nightlife', 1974, '36:41'),
        ('Fighting', 1975, '37:01'),
        ('Jailbreak', 1976, '35:45'),
        ('Johnny the Fox', 1976, '35:46'),
        ('Bad Reputation', 1977, '34:19'),
        ('Black Rose: A Rock Legend', 1979, '38:08'),
        ('Chinatown', 1980, '36:25'),
        ('Renegade', 1981, '42:14'),
        ('Thunder and Lightning', 1983, '42:37')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-thin-lizzy'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
