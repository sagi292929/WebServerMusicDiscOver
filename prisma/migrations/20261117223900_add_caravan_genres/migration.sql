INSERT INTO "Genere" ("name")
SELECT 'Canterbury Scene'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Canterbury Scene' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Jazz Rock'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Jazz Rock' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Caravan' COLLATE NOCASE
  AND genere."name" IN (
      'Progressive Rock',
      'Canterbury Scene',
      'Jazz Rock',
      'Psychedelic Rock'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
