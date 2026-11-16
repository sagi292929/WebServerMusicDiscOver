WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Orchid', 1995, '65:08'),
        ('Morningrise', 1996, '66:34'),
        ('My Arms, Your Hearse', 1998, '52:42'),
        ('Still Life', 1999, '62:31'),
        ('Blackwater Park', 2001, '67:03'),
        ('Deliverance', 2002, '61:45'),
        ('Damnation', 2003, '43:20'),
        ('Ghost Reveries', 2005, '66:46'),
        ('Watershed', 2008, '54:57'),
        ('Heritage', 2011, '56:58'),
        ('Pale Communion', 2014, '55:47'),
        ('Sorceress', 2016, '56:29'),
        ('In Cauda Venenum', 2019, '67:58'),
        ('The Last Will and Testament', 2024, '50:39')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-opeth'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
