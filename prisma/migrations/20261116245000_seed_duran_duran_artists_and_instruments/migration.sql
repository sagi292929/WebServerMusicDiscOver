INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Simon Le Bon', '1958-10-27T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-duran-duran'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Simon Le Bon'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Nick Rhodes', '1962-06-08T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-duran-duran'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Nick Rhodes'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'John Taylor', '1960-06-20T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-duran-duran'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'John Taylor'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Andy Taylor', '1961-02-16T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-duran-duran'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Andy Taylor'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Roger Taylor', '1960-04-26T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-duran-duran'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Roger Taylor'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Simon Le Bon', 'LeadVocals'),
        ('Simon Le Bon', 'RhythmGuitar'),
        ('Nick Rhodes', 'Keyboards'),
        ('Nick Rhodes', 'Synthesizer'),
        ('Nick Rhodes', 'Piano'),
        ('Nick Rhodes', 'BackingVocals'),
        ('John Taylor', 'BassGuitar'),
        ('John Taylor', 'BackingVocals'),
        ('John Taylor', 'LeadVocals'),
        ('Andy Taylor', 'LeadGuitar'),
        ('Andy Taylor', 'RhythmGuitar'),
        ('Andy Taylor', 'BackingVocals'),
        ('Roger Taylor', 'DrumKit'),
        ('Roger Taylor', 'Percussion')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-duran-duran'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
