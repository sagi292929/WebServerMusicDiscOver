INSERT INTO "Instrument" ("name", "Type")
SELECT 'Electronics', 'Keyboards'
WHERE NOT EXISTS (
    SELECT 1
    FROM "Instrument" AS existing
    WHERE existing."name" = 'Electronics'
);

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Marc Almond', '1957-07-09T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-soft-cell'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Marc Almond'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'David Ball', '1959-05-03T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-soft-cell'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'David Ball'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Marc Almond', 'LeadVocals'),
        ('David Ball', 'Keyboards'),
        ('David Ball', 'Synthesizer'),
        ('David Ball', 'Electronics'),
        ('David Ball', 'BackingVocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-soft-cell'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
