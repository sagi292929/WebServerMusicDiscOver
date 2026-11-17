INSERT INTO "Genere" ("name")
SELECT 'Celtic Rock'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Celtic Rock' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Thin Lizzy' COLLATE NOCASE
  AND genere."name" IN (
      'Hard Rock',
      'Heavy Metal',
      'Blues Rock',
      'Celtic Rock'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
