INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Dolores O''Riordan', '1971-09-06T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-cranberries'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Dolores O''Riordan'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Noel Hogan', '1971-12-25T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-cranberries'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Noel Hogan'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Mike Hogan', '1973-04-29T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-cranberries'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Mike Hogan'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Fergal Lawler', '1971-03-04T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-cranberries'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Fergal Lawler'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Dolores O''Riordan', 'LeadVocals'),
        ('Dolores O''Riordan', 'RhythmGuitar'),
        ('Dolores O''Riordan', 'AcousticGuitar'),
        ('Dolores O''Riordan', 'Keyboards'),
        ('Noel Hogan', 'LeadGuitar'),
        ('Noel Hogan', 'AcousticGuitar'),
        ('Noel Hogan', 'BackingVocals'),
        ('Mike Hogan', 'BassGuitar'),
        ('Fergal Lawler', 'DrumKit'),
        ('Fergal Lawler', 'Percussion')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-the-cranberries'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
