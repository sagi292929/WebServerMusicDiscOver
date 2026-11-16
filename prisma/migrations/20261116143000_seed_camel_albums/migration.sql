WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Camel', 1973, '39:15'),
        ('Mirage', 1974, '37:58'),
        ('The Snow Goose', 1975, '43:34'),
        ('Moonmadness', 1976, '39:12'),
        ('Rain Dances', 1977, '41:06'),
        ('Breathless', 1978, '44:53'),
        ('I Can See Your House from Here', 1979, '46:11'),
        ('Nude', 1981, '44:40'),
        ('The Single Factor', 1982, '38:49'),
        ('Stationary Traveller', 1984, '42:15'),
        ('Dust and Dreams', 1991, '47:55'),
        ('Harbour of Tears', 1996, '62:14'),
        ('Rajaz', 1999, '58:06'),
        ('A Nod and a Wink', 2002, '55:32'),
        ('The Snow Goose (2013 Re-recording)', 2013, '50:31')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-camel'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
