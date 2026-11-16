INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Cliff Burton', '1962-01-10T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-metallica'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Cliff Burton'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Jason Newsted', '1963-03-04T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-metallica'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Jason Newsted'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('James Hetfield', 'AcousticGuitar'),
        ('James Hetfield', 'LeadGuitar'),
        ('Lars Ulrich', 'Percussion'),
        ('Kirk Hammett', 'RhythmGuitar'),
        ('Cliff Burton', 'BassGuitar'),
        ('Cliff Burton', 'BackingVocals'),
        ('Cliff Burton', 'Keyboards'),
        ('Cliff Burton', 'AcousticGuitar'),
        ('Jason Newsted', 'BassGuitar'),
        ('Jason Newsted', 'BackingVocals')
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
