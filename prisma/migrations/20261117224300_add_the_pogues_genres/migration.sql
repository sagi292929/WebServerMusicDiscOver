INSERT INTO "Genere" ("name")
SELECT 'Celtic Punk'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Celtic Punk' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Folk Punk'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Folk Punk' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Irish Folk'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Irish Folk' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'The Pogues' COLLATE NOCASE
  AND genere."name" IN ('Celtic Punk', 'Folk Punk', 'Irish Folk')
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
