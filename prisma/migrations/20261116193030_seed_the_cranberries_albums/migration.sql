WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Everybody Else Is Doing It, So Why Can''t We?', 1993, '40:44'),
        ('No Need to Argue', 1994, '50:30'),
        ('To the Faithful Departed', 1996, '52:16'),
        ('Bury the Hatchet', 1999, '49:06'),
        ('Wake Up and Smell the Coffee', 2001, '47:01'),
        ('Roses', 2012, '37:37'),
        ('Something Else', 2017, '47:48'),
        ('In the End', 2019, '41:41')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-the-cranberries'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
