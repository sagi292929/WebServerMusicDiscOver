INSERT INTO "Genere" ("name")
SELECT 'Proto-Punk'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Proto-Punk' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'Acid Rock'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Acid Rock' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'The Seeds' COLLATE NOCASE
  AND genere."name" IN (
      'Garage Rock',
      'Psychedelic Rock',
      'Proto-Punk',
      'Acid Rock'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
