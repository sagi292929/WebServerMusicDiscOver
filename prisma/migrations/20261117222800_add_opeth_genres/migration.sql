INSERT INTO "Genere" ("name")
SELECT 'Progressive Death Metal'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Progressive Death Metal' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Acoustic Rock'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Acoustic Rock' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Opeth' COLLATE NOCASE
  AND genere."name" IN (
      'Progressive Metal',
      'Progressive Rock',
      'Progressive Death Metal',
      'Acoustic Rock'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
