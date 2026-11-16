WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Kill ''Em All', 1983, '51:20'),
        ('Ride the Lightning', 1984, '47:25'),
        ('Master of Puppets', 1986, '54:47'),
        ('...And Justice for All', 1988, '65:24'),
        ('Metallica', 1991, '62:40'),
        ('Load', 1996, '78:59'),
        ('Reload', 1997, '76:04'),
        ('St. Anger', 2003, '75:04'),
        ('Death Magnetic', 2008, '74:46'),
        ('Hardwired... to Self-Destruct', 2016, '77:42'),
        ('72 Seasons', 2023, '77:13')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-metallica'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
