WITH albums(title, year, lengthMinutes) AS (
    VALUES
        ('The Bee Gees Sing and Play 14 Barry Gibb Songs', 1965, '33:55'),
        ('Spicks and Specks', 1966, '32:25'),
        ('Bee Gees'' 1st', 1967, '41:44'),
        ('Horizontal', 1968, '36:35'),
        ('Idea', 1968, '34:24'),
        ('Odessa', 1969, '63:48'),
        ('Cucumber Castle', 1970, '34:17'),
        ('2 Years On', 1970, '35:45'),
        ('Trafalgar', 1971, '43:05'),
        ('To Whom It May Concern', 1972, '42:12'),
        ('Life in a Tin Can', 1973, '34:54'),
        ('Mr. Natural', 1974, '39:31'),
        ('Main Course', 1975, '39:42'),
        ('Children of the World', 1976, '39:35'),
        ('Saturday Night Fever', 1977, '75:54'),
        ('Spirits Having Flown', 1979, '44:45'),
        ('Living Eyes', 1981, '42:19'),
        ('Staying Alive', 1983, '46:08'),
        ('E.S.P.', 1987, '49:06'),
        ('One', 1989, '48:43'),
        ('High Civilization', 1991, '55:34'),
        ('Size Isn''t Everything', 1993, '53:09'),
        ('Still Waters', 1997, '55:56'),
        ('This Is Where I Came In', 2001, '50:32')
)
INSERT INTO "Album" ("BandId", "title", "year", "lengthMinutes")
SELECT band."Id", albums.title, albums.year, albums.lengthMinutes
FROM "Band" AS band
CROSS JOIN albums
WHERE band."es_id" = 'band-bee-gees'
  AND NOT EXISTS (
      SELECT 1
      FROM "Album" AS existing
      WHERE existing."BandId" = band."Id"
        AND existing."title" = albums.title
  );
