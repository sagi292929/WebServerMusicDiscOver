INSERT INTO "Genere" ("name")
SELECT 'Rock'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Rock' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Pop'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Pop' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Pop Rock'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Pop Rock' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Experimental Rock'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Experimental Rock' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'The Beatles' COLLATE NOCASE
  AND genere."name" IN (
      'Rock',
      'Pop',
      'Psychedelic Rock',
      'Pop Rock',
      'Experimental Rock'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
