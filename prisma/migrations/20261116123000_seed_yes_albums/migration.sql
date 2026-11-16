WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('Yes', 1969, '41:28'),
        ('Time and a Word', 1970, '39:59'),
        ('The Yes Album', 1971, '41:35'),
        ('Fragile', 1971, '41:14'),
        ('Close to the Edge', 1972, '37:50'),
        ('Tales from Topographic Oceans', 1973, '81:15'),
        ('Relayer', 1974, '40:26'),
        ('Going for the One', 1977, '38:49'),
        ('Tormato', 1978, '41:34'),
        ('Drama', 1980, '36:56'),
        ('90125', 1983, '44:48'),
        ('Big Generator', 1987, '43:39'),
        ('Anderson Bruford Wakeman Howe', 1989, '61:11'),
        ('Union', 1991, '65:37'),
        ('Talk', 1994, '55:19'),
        ('Keys to Ascension', 1996, '109:45'),
        ('Keys to Ascension 2', 1997, '105:00'),
        ('Open Your Eyes', 1997, '74:13'),
        ('The Ladder', 1999, '61:28'),
        ('Magnification', 2001, '60:11'),
        ('Fly from Here', 2011, '47:31'),
        ('Heaven & Earth', 2014, '51:29'),
        ('The Quest', 2021, '64:01'),
        ('Mirror to the Sky', 2023, '63:26')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-yes'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
