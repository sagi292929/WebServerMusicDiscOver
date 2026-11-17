INSERT INTO "Genere" ("name")
SELECT 'Samba-funk'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'Samba-funk' COLLATE NOCASE
);

INSERT INTO "Genere" ("name")
SELECT 'MPB (Música Popular Brasileira)'
WHERE NOT EXISTS (
    SELECT 1 FROM "Genere" WHERE "name" = 'MPB (Música Popular Brasileira)' COLLATE NOCASE
);

INSERT INTO "band_genere" ("band_id", "genere_id")
SELECT band."Id", genere."Id"
FROM "Band" AS band
CROSS JOIN "Genere" AS genere
WHERE band."name" = 'Banda Black Rio' COLLATE NOCASE
  AND genere."name" IN (
      'Samba-funk',
      'Soul',
      'Jazz-Funk',
      'MPB (Música Popular Brasileira)',
      'Disco'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM "band_genere" AS existing
      WHERE existing."band_id" = band."Id"
        AND existing."genere_id" = genere."Id"
  );
