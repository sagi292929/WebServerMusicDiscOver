INSERT INTO "Genere" ("name")
SELECT 'Worldbeat'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Worldbeat' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Minimal Compact' COLLATE NOCASE
  AND genere."name" IN (
      'Post-Punk',
      'New Wave',
      'Coldwave',
      'Experimental Rock',
      'Worldbeat'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
