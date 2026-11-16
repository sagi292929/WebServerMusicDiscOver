INSERT INTO "Instrument" ("name", "Type")
SELECT 'Organ', 'Keyboards'
WHERE NOT EXISTS (
    SELECT 1
    FROM "Instrument" AS existing
    WHERE existing."name" = 'Organ'
);

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Sky Saxon', '1937-08-20T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-seeds'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Sky Saxon'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Jan Savage', '1942-10-23T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-seeds'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Jan Savage'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Daryl Hooper', '1946-03-11T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-seeds'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Daryl Hooper'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Rick Andridge', '1945-03-28T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-seeds'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Rick Andridge'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Sky Saxon', 'LeadVocals'),
        ('Sky Saxon', 'BassGuitar'),
        ('Jan Savage', 'LeadGuitar'),
        ('Jan Savage', 'BackingVocals'),
        ('Daryl Hooper', 'Keyboards'),
        ('Daryl Hooper', 'Piano'),
        ('Daryl Hooper', 'Organ'),
        ('Daryl Hooper', 'BackingVocals'),
        ('Rick Andridge', 'DrumKit'),
        ('Rick Andridge', 'Percussion')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-the-seeds'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
