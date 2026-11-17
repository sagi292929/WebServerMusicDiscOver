CREATE TABLE "band_genere" (
    "band_id" INTEGER NOT NULL,
    "genere_id" INTEGER NOT NULL,

    PRIMARY KEY ("band_id", "genere_id"),
    CONSTRAINT "band_genere_band_id_fkey" FOREIGN KEY ("band_id") REFERENCES "Band" ("Id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "band_genere_genere_id_fkey" FOREIGN KEY ("genere_id") REFERENCES "Genere" ("Id") ON DELETE CASCADE ON UPDATE CASCADE
);
