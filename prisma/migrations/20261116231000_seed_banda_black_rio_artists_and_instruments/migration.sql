INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Oberdan Magalhães', '1945-03-31T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-banda-black-rio'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Oberdan Magalhães'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Cristóvão Bastos', '1946-12-03T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-banda-black-rio'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Cristóvão Bastos'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Luiz Carlos Batera', '1945-01-01T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-banda-black-rio'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Luiz Carlos Batera'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Jamil Joanes', '1952-03-12T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-banda-black-rio'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Jamil Joanes'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Cláudio Stevenson', '1955-03-01T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-banda-black-rio'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Cláudio Stevenson'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Oberdan Magalhães', 'Saxophone'),
        ('Oberdan Magalhães', 'Flute'),
        ('Cristóvão Bastos', 'Keyboards'),
        ('Cristóvão Bastos', 'Piano'),
        ('Luiz Carlos Batera', 'DrumKit'),
        ('Luiz Carlos Batera', 'Percussion'),
        ('Jamil Joanes', 'BassGuitar'),
        ('Cláudio Stevenson', 'Guitars')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-banda-black-rio'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
