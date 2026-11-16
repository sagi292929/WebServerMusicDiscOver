INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Shane MacGowan', '1957-12-25T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-pogues'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Shane MacGowan'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Spider Stacy', '1958-12-14T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-pogues'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Spider Stacy'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Jem Finer', '1955-07-20T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-pogues'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Jem Finer'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'James Fearnley', '1954-10-09T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-pogues'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'James Fearnley'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Andrew Ranken', '1953-11-13T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-pogues'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Andrew Ranken'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Cait O''Riordan', '1965-01-04T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-pogues'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Cait O''Riordan'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Darryl Hunt', '1950-05-04T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-pogues'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Darryl Hunt'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Philip Chevron', '1957-06-17T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-pogues'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Philip Chevron'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Terry Woods', '1947-12-04T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-pogues'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Terry Woods'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Shane MacGowan', 'LeadVocals'),
        ('Shane MacGowan', 'Guitars'),
        ('Shane MacGowan', 'Banjo'),
        ('Shane MacGowan', 'Bodhran'),
        ('Shane MacGowan', 'Piano'),
        ('Spider Stacy', 'TinWhistle'),
        ('Spider Stacy', 'Vocals'),
        ('Jem Finer', 'Banjo'),
        ('Jem Finer', 'Mandola'),
        ('Jem Finer', 'Guitars'),
        ('Jem Finer', 'HurdyGurdy'),
        ('Jem Finer', 'Saxophone'),
        ('Jem Finer', 'BackingVocals'),
        ('James Fearnley', 'Accordion'),
        ('James Fearnley', 'Piano'),
        ('James Fearnley', 'Mandolin'),
        ('James Fearnley', 'Guitars'),
        ('James Fearnley', 'BackingVocals'),
        ('Andrew Ranken', 'DrumKit'),
        ('Andrew Ranken', 'Percussion'),
        ('Andrew Ranken', 'Harmonica'),
        ('Andrew Ranken', 'BackingVocals'),
        ('Cait O''Riordan', 'BassGuitar'),
        ('Cait O''Riordan', 'BackingVocals'),
        ('Darryl Hunt', 'BassGuitar'),
        ('Darryl Hunt', 'BackingVocals'),
        ('Philip Chevron', 'Guitars'),
        ('Philip Chevron', 'Mandolin'),
        ('Philip Chevron', 'Banjo'),
        ('Philip Chevron', 'BackingVocals'),
        ('Terry Woods', 'Mandolin'),
        ('Terry Woods', 'Cittern'),
        ('Terry Woods', 'Concertina'),
        ('Terry Woods', 'Guitars'),
        ('Terry Woods', 'BackingVocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-the-pogues'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
