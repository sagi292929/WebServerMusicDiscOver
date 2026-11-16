WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Queen', 1973, '38:36'),
        ('Queen II', 1974, '40:42'),
        ('Sheer Heart Attack', 1974, '38:56'),
        ('A Night at the Opera', 1975, '43:08'),
        ('A Day at the Races', 1976, '44:13'),
        ('News of the World', 1977, '39:15'),
        ('Jazz', 1978, '44:43'),
        ('The Game', 1980, '35:39'),
        ('Flash Gordon', 1980, '35:11'),
        ('Hot Space', 1982, '43:29'),
        ('The Works', 1984, '37:30'),
        ('A Kind of Magic', 1986, '40:58'),
        ('The Miracle', 1989, '41:22'),
        ('Innuendo', 1991, '53:44'),
        ('Made in Heaven', 1995, '70:21')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-queen'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
