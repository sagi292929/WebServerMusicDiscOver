INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Phil Lynott', '1949-08-20T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-thin-lizzy'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Phil Lynott'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Scott Gorham', '1951-03-17T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-thin-lizzy'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Scott Gorham'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Brian Robertson', '1956-02-12T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-thin-lizzy'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Brian Robertson'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Brian Downey', '1951-01-27T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-thin-lizzy'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Brian Downey'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Eric Bell', '1947-09-03T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-thin-lizzy'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Eric Bell'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Phil Lynott', 'LeadVocals'),
        ('Phil Lynott', 'BassGuitar'),
        ('Phil Lynott', 'AcousticGuitar'),
        ('Scott Gorham', 'LeadGuitar'),
        ('Scott Gorham', 'RhythmGuitar'),
        ('Scott Gorham', 'BackingVocals'),
        ('Brian Robertson', 'LeadGuitar'),
        ('Brian Robertson', 'RhythmGuitar'),
        ('Brian Robertson', 'BackingVocals'),
        ('Brian Downey', 'DrumKit'),
        ('Brian Downey', 'Percussion'),
        ('Eric Bell', 'LeadGuitar'),
        ('Eric Bell', 'BackingVocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-thin-lizzy'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
