WITH instruments(name, type) AS (
    VALUES
        ('BackingVocals', 'Vocals'),
        ('LeadVocals', 'Vocals'),
        ('Guitars', 'Strings'),
        ('Keyboards', 'Keyboards'),
        ('Percussion', 'Percussion')
)
INSERT INTO "Instrument" ("name", "Type")
SELECT instruments.name, instruments.type
FROM instruments
WHERE NOT EXISTS (
    SELECT 1
    FROM "Instrument" AS existing
    WHERE existing."name" = instruments.name
);

WITH requested_instruments(artistName, instrumentName) AS (
    VALUES
        ('Steve Howe', 'ElectricGuitar'),
        ('Steve Howe', 'AcousticGuitar'),
        ('Steve Howe', 'LapSteelGuitar'),
        ('Steve Howe', 'PedalSteelGuitar'),
        ('Steve Howe', 'BackingVocals'),
        ('Geoff Downes', 'Keyboards'),
        ('Geoff Downes', 'Synthesizer'),
        ('Geoff Downes', 'Vocoder'),
        ('Billy Sherwood', 'BassGuitar'),
        ('Billy Sherwood', 'BackingVocals'),
        ('Billy Sherwood', 'Guitars'),
        ('Billy Sherwood', 'Keyboards'),
        ('Jon Davison', 'LeadVocals'),
        ('Jon Davison', 'AcousticGuitar'),
        ('Jon Davison', 'Percussion'),
        ('Jay Schellen', 'DrumKit'),
        ('Jay Schellen', 'Percussion')
)
INSERT INTO "artist_instruments" ("artist_id", "instrument_id")
SELECT artist."Id", instrument."Id"
FROM requested_instruments
JOIN "Artist" AS artist
    ON artist."name" = requested_instruments.artistName
JOIN "Band" AS band
    ON band."Id" = artist."BandId"
   AND band."es_id" = 'band-yes'
JOIN "Instrument" AS instrument
    ON instrument."name" = requested_instruments.instrumentName
WHERE NOT EXISTS (
    SELECT 1
    FROM "artist_instruments" AS existing
    WHERE existing."artist_id" = artist."Id"
      AND existing."instrument_id" = instrument."Id"
);
