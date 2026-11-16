WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Minimal Compact', 1981, '21:39'),
        ('One by One', 1982, '34:08'),
        ('Deadly Weapons', 1984, '32:09'),
        ('Raging Souls', 1985, '39:13'),
        ('The Figure One Cuts', 1987, '43:18'),
        ('Lowlands Flight', 1987, '37:37'),
        ('Live', 1988, '54:23')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-minimal-compact'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
