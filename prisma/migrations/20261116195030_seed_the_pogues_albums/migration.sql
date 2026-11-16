WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Red Roses for Me', 1984, '36:40'),
        ('Rum Sodomy & the Lash', 1985, '43:08'),
        ('If I Should Fall from Grace with God', 1988, '47:13'),
        ('Peace and Love', 1989, '44:28'),
        ('Hell''s Ditch', 1990, '41:44'),
        ('Waiting for Herb', 1993, '43:12'),
        ('Pogue Mahone', 1996, '46:50')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-the-pogues'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
