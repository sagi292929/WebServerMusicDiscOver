INSERT INTO "Instrument" ("name", "Type")
SELECT 'Organ', 'Keyboards'
WHERE NOT EXISTS (
    SELECT 1
    FROM "Instrument" AS existing
    WHERE existing."name" = 'Organ'
);

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Pye Hastings', '1947-01-21T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-caravan'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Pye Hastings'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Richard Sinclair', '1948-06-06T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-caravan'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Richard Sinclair'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Dave Sinclair', '1947-11-24T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-caravan'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Dave Sinclair'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Richard Coughlan', '1947-09-02T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-caravan'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Richard Coughlan'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Pye Hastings', 'Guitars'),
        ('Pye Hastings', 'LeadVocals'),
        ('Pye Hastings', 'BackingVocals'),
        ('Richard Sinclair', 'BassGuitar'),
        ('Richard Sinclair', 'AcousticGuitar'),
        ('Richard Sinclair', 'LeadVocals'),
        ('Richard Sinclair', 'BackingVocals'),
        ('Dave Sinclair', 'Keyboards'),
        ('Dave Sinclair', 'Piano'),
        ('Dave Sinclair', 'Organ'),
        ('Dave Sinclair', 'BackingVocals'),
        ('Richard Coughlan', 'DrumKit'),
        ('Richard Coughlan', 'Percussion')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-caravan'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
