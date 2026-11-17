INSERT INTO "Genere" ("name")
SELECT 'Euro-Disco'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Euro-Disco' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Bananarama' COLLATE NOCASE
  AND genere."name" IN (
      'Pop',
      'Dance-Pop',
      'New Wave',
      'Euro-Disco',
      'Synth-Pop'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
