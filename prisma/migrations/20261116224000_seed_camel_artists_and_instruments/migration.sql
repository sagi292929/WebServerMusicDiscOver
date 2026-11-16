INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Andrew Latimer', '1949-05-17T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-camel'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Andrew Latimer'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Colin Bass', '1951-05-04T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-camel'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Colin Bass'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Denis Clement', '1971-07-05T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-camel'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Denis Clement'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Peter Jones', '1980-10-06T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-camel'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Peter Jones'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Andrew Latimer', 'Guitars'),
        ('Andrew Latimer', 'Flute'),
        ('Andrew Latimer', 'Keyboards'),
        ('Andrew Latimer', 'Synthesizer'),
        ('Andrew Latimer', 'LeadVocals'),
        ('Colin Bass', 'BassGuitar'),
        ('Colin Bass', 'AcousticGuitar'),
        ('Colin Bass', 'Keyboards'),
        ('Colin Bass', 'BackingVocals'),
        ('Denis Clement', 'DrumKit'),
        ('Denis Clement', 'Percussion'),
        ('Denis Clement', 'Keyboards'),
        ('Peter Jones', 'Keyboards'),
        ('Peter Jones', 'Synthesizer'),
        ('Peter Jones', 'Saxophone'),
        ('Peter Jones', 'BackingVocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-camel'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
