INSERT INTO "Genere" ("name")
SELECT 'Neo-prog'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Neo-prog' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Symphonic prog'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Symphonic prog' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Sleaze rock'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Sleaze rock' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'New Romantic'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'New Romantic' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Blue-eyed soul'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Blue-eyed soul' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'IQ' COLLATE NOCASE
  AND genere."name" IN ('Neo-prog', 'Progressive Rock', 'Symphonic prog')
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Guns N'' Roses' COLLATE NOCASE
  AND genere."name" IN ('Hard Rock', 'Heavy Metal', 'Sleaze rock')
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Metallica' COLLATE NOCASE
  AND genere."name" IN ('Thrash Metal', 'Heavy Metal', 'Speed Metal')
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Duran Duran' COLLATE NOCASE
  AND genere."name" IN ('New Wave', 'Synth-Pop', 'New Romantic')
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Culture Club' COLLATE NOCASE
  AND genere."name" IN ('New Wave', 'Blue-eyed soul', 'New Romantic')
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
