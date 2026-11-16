INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'John Lennon', '1940-10-09T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-beatles'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'John Lennon'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Paul McCartney', '1942-06-18T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-beatles'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Paul McCartney'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'George Harrison', '1943-02-25T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-beatles'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'George Harrison'
        AND existing."BandId" = band."Id"
  );

INSERT INTO "Artist" ("name", "birthdate", "BandId")
SELECT 'Ringo Starr', '1940-07-07T00:00:00.000Z', band."Id"
FROM "Band" AS band
WHERE band."es_id" = 'band-the-beatles'
  AND NOT EXISTS (
      SELECT 1
      FROM "Artist" AS existing
      WHERE existing."name" = 'Ringo Starr'
        AND existing."BandId" = band."Id"
  );

WITH artist_instrument_data(artistName, instrumentName) AS (
    VALUES
        ('John Lennon', 'LeadVocals'),
        ('John Lennon', 'Vocals'),
        ('John Lennon', 'RhythmGuitar'),
        ('John Lennon', 'AcousticGuitar'),
        ('John Lennon', 'Keyboards'),
        ('John Lennon', 'Harmonica'),
        ('John Lennon', 'Percussion'),
        ('Paul McCartney', 'LeadVocals'),
        ('Paul McCartney', 'BackingVocals'),
        ('Paul McCartney', 'BassGuitar'),
        ('Paul McCartney', 'AcousticGuitar'),
        ('Paul McCartney', 'ElectricGuitar'),
        ('Paul McCartney', 'Keyboards'),
        ('Paul McCartney', 'Piano'),
        ('Paul McCartney', 'DrumKit'),
        ('Paul McCartney', 'Percussion'),
        ('George Harrison', 'LeadGuitar'),
        ('George Harrison', 'RhythmGuitar'),
        ('George Harrison', 'Sitar'),
        ('George Harrison', 'BackingVocals'),
        ('George Harrison', 'LeadVocals'),
        ('George Harrison', 'Keyboards'),
        ('George Harrison', 'Percussion'),
        ('Ringo Starr', 'DrumKit'),
        ('Ringo Starr', 'Percussion'),
        ('Ringo Starr', 'LeadVocals'),
        ('Ringo Starr', 'BackingVocals')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM artist_instrument_data
JOIN "Artist" AS artist
    ON artist."name" = artist_instrument_data.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-the-beatles'
JOIN "Instrument" AS instrument
    ON instrument."name" = artist_instrument_data.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
