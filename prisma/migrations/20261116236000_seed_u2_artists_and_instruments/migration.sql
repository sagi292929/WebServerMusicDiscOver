INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Bono', '1960-05-10T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-u2'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Bono'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'The Edge', '1961-08-08T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-u2'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'The Edge'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Adam Clayton', '1960-03-13T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-u2'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Adam Clayton'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Larry Mullen Jr.', '1961-10-31T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-u2'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Larry Mullen Jr.'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Bono', 'LeadVocals'),
        ('Bono', 'RhythmGuitar'),
        ('Bono', 'Harmonica'),
        ('Bono', 'Piano'),
        ('The Edge', 'LeadGuitar'),
        ('The Edge', 'Keyboards'),
        ('The Edge', 'Piano'),
        ('The Edge', 'BackingVocals'),
        ('The Edge', 'BassGuitar'),
        ('Adam Clayton', 'BassGuitar'),
        ('Adam Clayton', 'Keyboards'),
        ('Larry Mullen Jr.', 'DrumKit'),
        ('Larry Mullen Jr.', 'Percussion'),
        ('Larry Mullen Jr.', 'BackingVocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-u2'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
