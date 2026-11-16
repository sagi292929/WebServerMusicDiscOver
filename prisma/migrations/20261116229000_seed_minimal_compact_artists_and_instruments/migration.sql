INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Malka Spigel', '1954-07-19T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-minimal-compact'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Malka Spigel'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Samy Birnbach', '1948-01-01T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-minimal-compact'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Samy Birnbach'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Berry Sakharof', '1957-07-07T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-minimal-compact'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Berry Sakharof'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Rami Fortis', '1954-07-07T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-minimal-compact'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Rami Fortis'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Malka Spigel', 'BassGuitar'),
        ('Malka Spigel', 'Vocals'),
        ('Samy Birnbach', 'Vocals'),
        ('Berry Sakharof', 'Guitars'),
        ('Berry Sakharof', 'Keyboards'),
        ('Berry Sakharof', 'Vocals'),
        ('Rami Fortis', 'Guitars'),
        ('Rami Fortis', 'Vocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-minimal-compact'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
