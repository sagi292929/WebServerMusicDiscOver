INSERT INTO "Instrument" ("name", "Type")
SELECT 'BassPedals', 'Keyboards'
WHERE NOT EXISTS (
    SELECT 1
    FROM "Instrument" AS existing
    WHERE existing."name" = 'BassPedals'
);

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Peter Nicholls', '1959-02-13T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-iq'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Peter Nicholls'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Mike Holmes', '1970-01-01T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-iq'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Mike Holmes'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Tim Esau', '1970-01-01T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-iq'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Tim Esau'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Paul Cook', '1970-01-01T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-iq'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Paul Cook'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Neil Durant', '1970-01-01T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-iq'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Neil Durant'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Martin Orford', '1959-06-10T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-iq'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Martin Orford'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('Peter Nicholls', 'LeadVocals'),
        ('Peter Nicholls', 'BackingVocals'),
        ('Peter Nicholls', 'Keyboards'),
        ('Peter Nicholls', 'Percussion'),
        ('Mike Holmes', 'Guitars'),
        ('Mike Holmes', 'Keyboards'),
        ('Mike Holmes', 'BackingVocals'),
        ('Tim Esau', 'BassGuitar'),
        ('Tim Esau', 'BassPedals'),
        ('Tim Esau', 'BackingVocals'),
        ('Paul Cook', 'DrumKit'),
        ('Paul Cook', 'Percussion'),
        ('Neil Durant', 'Keyboards'),
        ('Neil Durant', 'Synthesizer'),
        ('Martin Orford', 'Keyboards'),
        ('Martin Orford', 'BackingVocals'),
        ('Martin Orford', 'LeadVocals'),
        ('Martin Orford', 'Flute')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-iq'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
