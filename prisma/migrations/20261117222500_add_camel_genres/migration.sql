INSERT INTO "Genere" ("name")
SELECT 'Symphonic Rock'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Symphonic Rock' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Instrumental Rock'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Instrumental Rock' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Camel' COLLATE NOCASE
  AND genere."name" IN ('Progressive Rock', 'Symphonic Rock', 'Instrumental Rock')
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
