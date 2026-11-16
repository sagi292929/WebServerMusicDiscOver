INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Boy George', '1961-06-14T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-culture-club'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Boy George'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Roy Hay', '1961-08-12T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-culture-club'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Roy Hay'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Mikey Craig', '1960-02-15T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-culture-club'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Mikey Craig'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Jon Moss', '1957-09-11T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-culture-club'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Jon Moss'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Boy George', 'LeadVocals'),
        ('Roy Hay', 'Guitars'),
        ('Roy Hay', 'Keyboards'),
        ('Roy Hay', 'Sitar'),
        ('Roy Hay', 'BackingVocals'),
        ('Mikey Craig', 'BassGuitar'),
        ('Mikey Craig', 'Keyboards'),
        ('Mikey Craig', 'Piano'),
        ('Mikey Craig', 'BackingVocals'),
        ('Jon Moss', 'DrumKit'),
        ('Jon Moss', 'Percussion'),
        ('Jon Moss', 'BackingVocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-culture-club'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
