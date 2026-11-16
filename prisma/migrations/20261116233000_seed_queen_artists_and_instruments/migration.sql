INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Freddie Mercury', '1946-09-05T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-queen'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Freddie Mercury'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Brian May', '1947-07-19T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-queen'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Brian May'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Roger Taylor', '1949-07-26T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-queen'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Roger Taylor'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'John Deacon', '1951-08-19T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-queen'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'John Deacon'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Freddie Mercury', 'LeadVocals'),
        ('Freddie Mercury', 'Piano'),
        ('Freddie Mercury', 'Keyboards'),
        ('Freddie Mercury', 'Guitars'),
        ('Brian May', 'Guitars'),
        ('Brian May', 'LeadVocals'),
        ('Brian May', 'BackingVocals'),
        ('Brian May', 'Keyboards'),
        ('Roger Taylor', 'DrumKit'),
        ('Roger Taylor', 'Percussion'),
        ('Roger Taylor', 'LeadVocals'),
        ('Roger Taylor', 'BackingVocals'),
        ('John Deacon', 'BassGuitar'),
        ('John Deacon', 'Keyboards'),
        ('John Deacon', 'Guitars'),
        ('John Deacon', 'BackingVocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-queen'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
