INSERT INTO "Genere" ("name")
SELECT 'Soft Rock'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Soft Rock' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Bee Gees' COLLATE NOCASE
  AND genere."name" IN (
      'Pop',
      'Disco',
      'Soft Rock',
      'Pop Rock',
      'Psychedelic Pop'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
