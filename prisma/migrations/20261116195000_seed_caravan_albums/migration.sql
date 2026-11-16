WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Caravan', 1969, '36:40'),
        ('If I Could Do It All Over Again, I''d Do It All Over You', 1970, '44:45'),
        ('In the Land of Grey and Pink', 1971, '43:08'),
        ('Waterloo Lily', 1972, '43:29'),
        ('For Girls Who Grow Plump in the Night', 1973, '42:19'),
        ('Cunning Stunts', 1975, '46:50'),
        ('Blind Dog at St. Dunstans', 1976, '46:33'),
        ('Better by Far', 1977, '39:58'),
        ('The Album', 1980, '39:05'),
        ('Back to Front', 1982, '38:51'),
        ('Cool Water', 1994, '47:12'),
        ('The Battle of Hastings', 1995, '58:02'),
        ('The Unauthorised Breakfast Item', 2003, '65:34'),
        ('Paradise Filter', 2013, '52:40'),
        ('It''s None of Your Business', 2021, '53:14')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-caravan'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
