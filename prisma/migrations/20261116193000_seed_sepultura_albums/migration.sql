WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Morbid Visions', 1986, '33:56'),
        ('Schizophrenia', 1987, '37:28'),
        ('Beneath the Remains', 1989, '42:15'),
        ('Arise', 1991, '43:46'),
        ('Chaos A.D.', 1993, '46:33'),
        ('Roots', 1996, '72:07'),
        ('Against', 1998, '47:01'),
        ('Nation', 2001, '48:45'),
        ('Roorback', 2003, '45:23'),
        ('Dante XXI', 2006, '40:47'),
        ('A-Lex', 2009, '54:25'),
        ('Kairos', 2011, '47:49'),
        ('The Mediator Between Head and Hands Must Be the Heart', 2013, '44:44'),
        ('Machine Messiah', 2017, '57:50'),
        ('Quadra', 2020, '50:32')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-sepultura'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
