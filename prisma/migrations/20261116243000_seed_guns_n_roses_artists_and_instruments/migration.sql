INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Axl Rose', '1962-02-06T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-guns-n-roses'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Axl Rose'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Slash', '1965-07-23T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-guns-n-roses'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Slash'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Izzy Stradlin', '1962-04-08T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-guns-n-roses'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Izzy Stradlin'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Duff McKagan', '1964-02-05T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-guns-n-roses'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Duff McKagan'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Steven Adler', '1965-01-22T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-guns-n-roses'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Steven Adler'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Axl Rose', 'LeadVocals'),
        ('Axl Rose', 'Piano'),
        ('Axl Rose', 'RhythmGuitar'),
        ('Axl Rose', 'Percussion'),
        ('Slash', 'LeadGuitar'),
        ('Slash', 'RhythmGuitar'),
        ('Slash', 'BackingVocals'),
        ('Izzy Stradlin', 'RhythmGuitar'),
        ('Izzy Stradlin', 'LeadGuitar'),
        ('Izzy Stradlin', 'BackingVocals'),
        ('Izzy Stradlin', 'LeadVocals'),
        ('Izzy Stradlin', 'Percussion'),
        ('Duff McKagan', 'BassGuitar'),
        ('Duff McKagan', 'BackingVocals'),
        ('Duff McKagan', 'LeadVocals'),
        ('Duff McKagan', 'AcousticGuitar'),
        ('Duff McKagan', 'Percussion'),
        ('Steven Adler', 'DrumKit'),
        ('Steven Adler', 'Percussion')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-guns-n-roses'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
