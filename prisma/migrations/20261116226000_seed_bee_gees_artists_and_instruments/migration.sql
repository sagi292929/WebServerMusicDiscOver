INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Barry Gibb', '1946-09-01T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bee-gees'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Barry Gibb'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Robin Gibb', '1949-12-22T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bee-gees'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Robin Gibb'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Maurice Gibb', '1949-12-22T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bee-gees'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Maurice Gibb'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Barry Gibb', 'Vocals'),
        ('Barry Gibb', 'RhythmGuitar'),
        ('Barry Gibb', 'LeadGuitar'),
        ('Robin Gibb', 'Vocals'),
        ('Maurice Gibb', 'BassGuitar'),
        ('Maurice Gibb', 'Guitars'),
        ('Maurice Gibb', 'Keyboards'),
        ('Maurice Gibb', 'Piano'),
        ('Maurice Gibb', 'Synthesizer'),
        ('Maurice Gibb', 'Vocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-bee-gees'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
