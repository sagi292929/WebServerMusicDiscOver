INSERT INTO "Genere" ("name")
SELECT 'Alternative Metal'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Alternative Metal' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Tribal Metal'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Tribal Metal' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Sepultura' COLLATE NOCASE
  AND genere."name" IN (
      'Groove Metal',
      'Thrash Metal',
      'Death Metal',
      'Alternative Metal',
      'Tribal Metal'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
