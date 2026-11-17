INSERT INTO "Genere" ("name")
SELECT 'Electronic'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Electronic' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Soft Cell' COLLATE NOCASE
  AND genere."name" IN (
      'Synth-Pop',
      'New Wave',
      'Post-Punk',
      'Electronic'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
