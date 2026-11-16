INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Alan Kendall', '1944-09-09T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bee-gees'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Alan Kendall'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Dennis Bryon', '1949-04-14T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bee-gees'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Dennis Bryon'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Blue Weaver', '1947-03-11T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bee-gees'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Blue Weaver'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Colin Petersen', '1946-03-24T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bee-gees'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Colin Petersen'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Vince Melouney', '1945-08-18T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bee-gees'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Vince Melouney'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Alan Kendall', 'LeadGuitar'),
        ('Alan Kendall', 'BassGuitar'),
        ('Alan Kendall', 'BackingVocals'),
        ('Dennis Bryon', 'DrumKit'),
        ('Dennis Bryon', 'Percussion'),
        ('Blue Weaver', 'Keyboards'),
        ('Blue Weaver', 'Synthesizer'),
        ('Blue Weaver', 'Piano'),
        ('Colin Petersen', 'DrumKit'),
        ('Vince Melouney', 'LeadGuitar'),
        ('Vince Melouney', 'Vocals')
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
