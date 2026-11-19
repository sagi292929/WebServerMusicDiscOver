ALTER TABLE "Genere" RENAME TO "Genre";
ALTER TABLE "Genre" RENAME COLUMN "main_genere" TO "main_genre";

ALTER TABLE "band_genere" RENAME TO "band_genre";
ALTER TABLE "band_genre" RENAME COLUMN "genere_id" TO "genre_id";
