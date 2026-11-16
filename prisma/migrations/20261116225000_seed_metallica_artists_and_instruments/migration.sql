WITH instruments(name, type) AS (
    VALUES
        ('RhythmGuitar', 'Strings'),
        ('LeadGuitar', 'Strings')
)
INSERT INTO "Instrument" ("name", "Type")
SELECT instruments.name, instruments.type
FROM instruments
WHERE NOT EXISTS (
    SELECT 1
    FROM "Instrument" AS existing
    WHERE existing."name" = instruments.name
);

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'James Hetfield', '1963-08-03T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-metallica'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'James Hetfield'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Lars Ulrich', '1963-12-26T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-metallica'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Lars Ulrich'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Kirk Hammett', '1962-11-18T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-metallica'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Kirk Hammett'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Robert Trujillo', '1964-10-23T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-metallica'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Robert Trujillo'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('James Hetfield', 'LeadVocals'),
        ('James Hetfield', 'RhythmGuitar'),
        ('Lars Ulrich', 'DrumKit'),
        ('Kirk Hammett', 'LeadGuitar'),
        ('Kirk Hammett', 'BackingVocals'),
        ('Robert Trujillo', 'BassGuitar'),
        ('Robert Trujillo', 'BackingVocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-metallica'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
