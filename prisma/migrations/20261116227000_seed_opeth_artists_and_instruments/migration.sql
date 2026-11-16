INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Mikael Åkerfeldt', '1974-04-17T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-opeth'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Mikael Åkerfeldt'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Martín Méndez', '1978-04-06T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-opeth'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Martín Méndez'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Fredrik Åkesson', '1972-07-18T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-opeth'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Fredrik Åkesson'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Joakim Svalberg', '1969-02-22T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-opeth'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Joakim Svalberg'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Waltteri Väyrynen', '1994-07-05T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-opeth'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Waltteri Väyrynen'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Mikael Åkerfeldt', 'LeadVocals'),
        ('Mikael Åkerfeldt', 'Guitars'),
        ('Mikael Åkerfeldt', 'BassGuitar'),
        ('Martín Méndez', 'BassGuitar'),
        ('Martín Méndez', 'BackingVocals'),
        ('Fredrik Åkesson', 'Guitars'),
        ('Fredrik Åkesson', 'BackingVocals'),
        ('Joakim Svalberg', 'Keyboards'),
        ('Joakim Svalberg', 'Synthesizer'),
        ('Joakim Svalberg', 'BackingVocals'),
        ('Joakim Svalberg', 'Percussion'),
        ('Waltteri Väyrynen', 'DrumKit'),
        ('Waltteri Väyrynen', 'Percussion'),
        ('Waltteri Väyrynen', 'BackingVocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-opeth'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
