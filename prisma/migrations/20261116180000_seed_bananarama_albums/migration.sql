WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Deep Sea Skiving', 1983, '36:49'),
        ('Bananarama', 1984, '43:02'),
        ('True Confessions', 1986, '43:54'),
        ('Wow!', 1987, '38:15'),
        ('Pop Life', 1991, '52:18'),
        ('Please Yourself', 1993, '39:42'),
        ('Ultra Violet', 1995, '46:55'),
        ('Exotica', 2001, '45:10'),
        ('Drama', 2005, '41:28'),
        ('Viva', 2009, '40:14'),
        ('In Stereo', 2019, '36:38'),
        ('Masquerade', 2022, '41:05')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-bananarama'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
