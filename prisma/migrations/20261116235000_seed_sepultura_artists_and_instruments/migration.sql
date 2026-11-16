INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Max Cavalera', '1969-08-04T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-sepultura'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Max Cavalera'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Andreas Kisser', '1968-08-24T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-sepultura'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Andreas Kisser'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Paulo Jr.', '1969-04-30T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-sepultura'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Paulo Jr.'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Igor Cavalera', '1970-09-04T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-sepultura'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Igor Cavalera'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Max Cavalera', 'LeadVocals'),
        ('Max Cavalera', 'RhythmGuitar'),
        ('Andreas Kisser', 'LeadGuitar'),
        ('Andreas Kisser', 'BackingVocals'),
        ('Paulo Jr.', 'BassGuitar'),
        ('Igor Cavalera', 'DrumKit'),
        ('Igor Cavalera', 'Percussion')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-sepultura'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
