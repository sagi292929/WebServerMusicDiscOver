WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Non-Stop Erotic Cabaret', 1981, '39:31'),
        ('Non Stop Ecstatic Dancing', 1982, '36:40'),
        ('The Art of Falling Apart', 1983, '43:08'),
        ('This Last Night in Sodom', 1984, '41:45'),
        ('Cruelty Without Beauty', 2002, '58:02'),
        ('*Happiness Not Included', 2022, '54:12')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-soft-cell'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
