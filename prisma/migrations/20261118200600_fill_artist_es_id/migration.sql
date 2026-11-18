UPDATE "Artist"
SET "es_id" = 'artists-' || replace(replace(replace(replace(lower(trim("name")), '''', ''), ',', ''), '.', ''), ' ', '-')
WHERE "es_id" = '' OR "es_id" IS NULL;

UPDATE "Artist" SET "es_id" = 'artists-mikael-akerfeldt' WHERE "name" = 'Mikael Åkerfeldt';
UPDATE "Artist" SET "es_id" = 'artists-martin-mendez' WHERE "name" = 'Martín Méndez';
UPDATE "Artist" SET "es_id" = 'artists-fredrik-akesson' WHERE "name" = 'Fredrik Åkesson';
UPDATE "Artist" SET "es_id" = 'artists-waltteri-vayrynen' WHERE "name" = 'Waltteri Väyrynen';
UPDATE "Artist" SET "es_id" = 'artists-oberdan-magalhaes' WHERE "name" = 'Oberdan Magalhães';
UPDATE "Artist" SET "es_id" = 'artists-cristovao-bastos' WHERE "name" = 'Cristóvão Bastos';
UPDATE "Artist" SET "es_id" = 'artists-claudio-stevenson' WHERE "name" = 'Cláudio Stevenson';
