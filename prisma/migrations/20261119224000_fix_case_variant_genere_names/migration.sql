UPDATE "Genere"
SET "main_genere" = 'R&B, Soul, Funk & Gospel'
WHERE "name" COLLATE NOCASE = 'Blue-Eyed Soul';

UPDATE "Genere"
SET "main_genere" = 'Rock & Punk'
WHERE "name" COLLATE NOCASE IN ('Neo-Prog', 'Sleaze Rock', 'Symphonic Prog');

UPDATE "Genere"
SET "main_genere" = 'Latin & Brazilian'
WHERE "name" COLLATE NOCASE = 'Samba-Funk';
