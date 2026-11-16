INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Sara Dallin', '1961-12-17T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bananarama'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Sara Dallin'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Keren Woodward', '1961-04-02T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bananarama'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Keren Woodward'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Siobhan Fahey', '1958-09-10T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bananarama'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Siobhan Fahey'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Jacquie O''Sullivan', '1960-08-07T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-bananarama'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Jacquie O''Sullivan'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Sara Dallin', 'LeadVocals'),
        ('Sara Dallin', 'BackingVocals'),
        ('Keren Woodward', 'LeadVocals'),
        ('Keren Woodward', 'BackingVocals'),
        ('Siobhan Fahey', 'LeadVocals'),
        ('Siobhan Fahey', 'BackingVocals'),
        ('Jacquie O''Sullivan', 'LeadVocals'),
        ('Jacquie O''Sullivan', 'BackingVocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-bananarama'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
