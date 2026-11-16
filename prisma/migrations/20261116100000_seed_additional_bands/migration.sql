INSERT INTO "Band" ("es_id", "name", "origin", "officialWebsite", "rockAndRollHallOfFameInduction")
SELECT 'band-u2', 'U2', 'Dublin, Ireland', 'https://www.u2.com', 2005
WHERE NOT EXISTS (SELECT 1 FROM "Band" WHERE "es_id" = 'band-u2');

INSERT INTO "Band" ("es_id", "name", "origin", "officialWebsite", "rockAndRollHallOfFameInduction")
SELECT 'band-caravan', 'Caravan', 'Canterbury, Kent, England', 'https://www.officialcaravan.co.uk', NULL
WHERE NOT EXISTS (SELECT 1 FROM "Band" WHERE "es_id" = 'band-caravan');

INSERT INTO "Band" ("es_id", "name", "origin", "officialWebsite", "rockAndRollHallOfFameInduction")
SELECT 'band-thin-lizzy', 'Thin Lizzy', 'Dublin, Ireland', 'https://www.thinlizzyofficial.com', NULL
WHERE NOT EXISTS (SELECT 1 FROM "Band" WHERE "es_id" = 'band-thin-lizzy');

INSERT INTO "Band" ("es_id", "name", "origin", "officialWebsite", "rockAndRollHallOfFameInduction")
SELECT 'band-the-cranberries', 'The Cranberries', 'Limerick, Ireland', 'https://www.cranberries.com', NULL
WHERE NOT EXISTS (SELECT 1 FROM "Band" WHERE "es_id" = 'band-the-cranberries');

INSERT INTO "Band" ("es_id", "name", "origin", "officialWebsite", "rockAndRollHallOfFameInduction")
SELECT 'band-soft-cell', 'Soft Cell', 'Leeds, West Yorkshire, England', 'https://www.softcell.co.uk', NULL
WHERE NOT EXISTS (SELECT 1 FROM "Band" WHERE "es_id" = 'band-soft-cell');

INSERT INTO "Band" ("es_id", "name", "origin", "officialWebsite", "rockAndRollHallOfFameInduction")
SELECT 'band-the-pogues', 'The Pogues', 'London, England', 'https://www.pogues.com', NULL
WHERE NOT EXISTS (SELECT 1 FROM "Band" WHERE "es_id" = 'band-the-pogues');

INSERT INTO "Band" ("es_id", "name", "origin", "officialWebsite", "rockAndRollHallOfFameInduction")
SELECT 'band-iq', 'IQ', 'Southampton, England', 'https://www.iq-hq.co.uk', NULL
WHERE NOT EXISTS (SELECT 1 FROM "Band" WHERE "es_id" = 'band-iq');

INSERT INTO "Band" ("es_id", "name", "origin", "officialWebsite", "rockAndRollHallOfFameInduction")
SELECT 'band-guns-n-roses', 'Guns N'' Roses', 'Los Angeles, California, U.S.', 'https://www.gunsnroses.com', 2012
WHERE NOT EXISTS (SELECT 1 FROM "Band" WHERE "es_id" = 'band-guns-n-roses');

INSERT INTO "Band" ("es_id", "name", "origin", "officialWebsite", "rockAndRollHallOfFameInduction")
SELECT 'band-metallica', 'Metallica', 'Los Angeles, California, U.S.', 'https://www.metallica.com', 2009
WHERE NOT EXISTS (SELECT 1 FROM "Band" WHERE "es_id" = 'band-metallica');

INSERT INTO "Band" ("es_id", "name", "origin", "officialWebsite", "rockAndRollHallOfFameInduction")
SELECT 'band-duran-duran', 'Duran Duran', 'Birmingham, England', 'https://duranduran.com', 2022
WHERE NOT EXISTS (SELECT 1 FROM "Band" WHERE "es_id" = 'band-duran-duran');

INSERT INTO "Band" ("es_id", "name", "origin", "officialWebsite", "rockAndRollHallOfFameInduction")
SELECT 'band-culture-club', 'Culture Club', 'London, England', 'https://cultureclub.co.uk', NULL
WHERE NOT EXISTS (SELECT 1 FROM "Band" WHERE "es_id" = 'band-culture-club');
