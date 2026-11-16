WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Kissing to Be Clever', 1982, '36:40'),
        ('Colour by Numbers', 1983, '39:30'),
        ('Waking Up with the House on Fire', 1984, '39:51'),
        ('From Luxury to Heartache', 1986, '43:08'),
        ('Don''t Mind If I Do', 1999, '58:14'),
        ('Life', 2018, '45:23')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-culture-club'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
