INSERT INTO "Instrument" ("name", "Type")
SELECT 'ElectricGuitar', 'Strings'
WHERE NOT EXISTS (SELECT 1 FROM "Instrument" WHERE "name" = 'ElectricGuitar');

INSERT INTO "Instrument" ("name", "Type")
SELECT 'Piano', 'Keyboards'
WHERE NOT EXISTS (SELECT 1 FROM "Instrument" WHERE "name" = 'Piano');

INSERT INTO "Instrument" ("name", "Type")
SELECT 'BassGuitar', 'Strings'
WHERE NOT EXISTS (SELECT 1 FROM "Instrument" WHERE "name" = 'BassGuitar');

INSERT INTO "Instrument" ("name", "Type")
SELECT 'DrumKit', 'Percussion'
WHERE NOT EXISTS (SELECT 1 FROM "Instrument" WHERE "name" = 'DrumKit');

INSERT INTO "Instrument" ("name", "Type")
SELECT 'Vocals', 'Vocals'
WHERE NOT EXISTS (SELECT 1 FROM "Instrument" WHERE "name" = 'Vocals');

INSERT INTO "Artist" ("name", "birthdate", "BandId", "mainInstrumentId")
SELECT 'Steve Howe', '1947-04-08T00:00:00.000Z', "Band"."Id", "Instrument"."Id"
FROM "Band", "Instrument"
WHERE "Band"."es_id" = 'band-yes' AND "Instrument"."name" = 'ElectricGuitar';

INSERT INTO "Artist" ("name", "birthdate", "BandId", "mainInstrumentId")
SELECT 'Geoff Downes', '1952-08-25T00:00:00.000Z', "Band"."Id", "Instrument"."Id"
FROM "Band", "Instrument"
WHERE "Band"."es_id" = 'band-yes' AND "Instrument"."name" = 'Piano';

INSERT INTO "Artist" ("name", "birthdate", "BandId", "mainInstrumentId")
SELECT 'Billy Sherwood', '1965-03-14T00:00:00.000Z', "Band"."Id", "Instrument"."Id"
FROM "Band", "Instrument"
WHERE "Band"."es_id" = 'band-yes' AND "Instrument"."name" = 'BassGuitar';

INSERT INTO "Artist" ("name", "birthdate", "BandId", "mainInstrumentId")
SELECT 'Jon Davison', '1971-01-16T00:00:00.000Z', "Band"."Id", "Instrument"."Id"
FROM "Band", "Instrument"
WHERE "Band"."es_id" = 'band-yes' AND "Instrument"."name" = 'Vocals';

INSERT INTO "Artist" ("name", "birthdate", "BandId", "mainInstrumentId")
SELECT 'Jay Schellen', '1960-05-20T00:00:00.000Z', "Band"."Id", "Instrument"."Id"
FROM "Band", "Instrument"
WHERE "Band"."es_id" = 'band-yes' AND "Instrument"."name" = 'DrumKit';
