ALTER TABLE "Genere" ADD COLUMN "main_genere" TEXT;

UPDATE "Genere" SET "main_genere" = 'Rock & Punk' WHERE "name" IN (
    'Classic Rock', 'Hard Rock', 'Progressive Rock', 'Psychedelic Rock',
    'Alternative Rock', 'Indie Rock', 'Garage Rock', 'Punk Rock', 'Post-Punk',
    'Pop Punk', 'Hardcore Punk', 'Grunge', 'Post-Rock', 'Math Rock', 'Shoegaze',
    'Dream Pop', 'Krautrock', 'Space Rock', 'Art Rock', 'Glam Rock', 'Gothic Rock',
    'New Wave', 'No Wave', 'Coldwave', 'Dark Wave', 'Emo', 'Screamo', 'Midwest Emo',
    'Surf Rock', 'Folk Rock', 'Blues Rock', 'Southern Rock', 'Stoner Rock',
    'Noise Rock', 'Britpop'
);

UPDATE "Genere" SET "main_genere" = 'Heavy Metal' WHERE "name" IN (
    'Heavy Metal', 'Thrash Metal', 'Death Metal', 'Black Metal', 'Doom Metal',
    'Power Metal', 'Progressive Metal', 'Symphonic Metal', 'Folk Metal', 'Nu Metal',
    'Metalcore', 'Deathcore', 'Grindcore', 'Sludge Metal', 'Groove Metal',
    'Speed Metal', 'Gothic Metal', 'Industrial Metal', 'Melodic Death Metal',
    'Technical Death Metal', 'Avant-Garde Metal', 'Drone Metal', 'Djent',
    'Viking Metal', 'Crossover Thrash'
);

UPDATE "Genere" SET "main_genere" = 'Electronic & Dance (EDM)' WHERE "name" IN (
    'House', 'Deep House', 'Tech House', 'Progressive House', 'Acid House',
    'Chicago House', 'Tropical House', 'Big Room House', 'Future House',
    'Electro House', 'Techno', 'Detroit Techno', 'Minimal Techno', 'Acid Techno',
    'Dub Techno', 'Industrial Techno', 'Trance', 'Psytrance', 'Goa Trance',
    'Progressive Trance', 'Uplifting Trance', 'Hardstyle', 'Gabber',
    'Drum and Bass', 'Liquid Funk', 'Jungle', 'Breakbeat', 'Big Beat', 'Breakcore',
    'Dubstep', 'Brostep', 'Riddim', 'Future Bass', 'UK Garage', '2-Step', 'Grime',
    'Ambient', 'Dark Ambient', 'Drone', 'Downtempo', 'Trip Hop', 'IDM',
    'Chiptune', 'Synthwave', 'Vaporwave'
);

UPDATE "Genere" SET "main_genere" = 'Hip-Hop & Rap' WHERE "name" IN (
    'Old School Hip-Hop', 'Boom Bap', 'East Coast Hip-Hop', 'West Coast Hip-Hop',
    'Gangsta Rap', 'G-Funk', 'Trap', 'Drill', 'UK Drill', 'Brooklyn Drill',
    'Southern Hip-Hop', 'Crunk', 'Chopped and Screwed', 'Cloud Rap', 'Mumble Rap',
    'Lo-Fi Hip-Hop', 'Conscious Hip-Hop', 'Alternative Hip-Hop', 'Jazz Rap',
    'Industrial Hip-Hop', 'Horrorcore', 'Phonk', 'Drift Phonk', 'Bounce',
    'Miami Bass'
);

UPDATE "Genere" SET "main_genere" = 'Pop' WHERE "name" IN (
    'Synth-Pop', 'Electropop', 'Dance-Pop', 'Indie Pop', 'Art Pop', 'Baroque Pop',
    'Chamber Pop', 'Power Pop', 'Bubblegum Pop', 'Teen Pop', 'Hyperpop',
    'Sophisti-Pop', 'Sunshine Pop', 'Psychedelic Pop', 'J-Pop', 'K-Pop', 'C-Pop',
    'City Pop', 'Eurodance', 'Europop', 'Italo Disco', 'Disco', 'Nu-Disco',
    'French Pop', 'Cantopop'
);

UPDATE "Genere" SET "main_genere" = 'R&B, Soul, Funk & Gospel' WHERE "name" IN (
    'Contemporary R&B', 'Rhythm and Blues', 'Soul', 'Neo-Soul', 'Motown',
    'Northern Soul', 'Southern Soul', 'Psychedelic Soul', 'Quiet Storm',
    'New Jack Swing', 'Funk', 'P-Funk', 'Jazz-Funk', 'Synth-Funk', 'Boogie',
    'Doo-Wop', 'Gospel', 'Urban Contemporary Gospel', 'Alternative R&B',
    'Minneapolis Sound'
);

UPDATE "Genere" SET "main_genere" = 'Jazz' WHERE "name" IN (
    'Swing', 'Big Band', 'Bebop', 'Hard Bop', 'Cool Jazz', 'Modal Jazz',
    'Free Jazz', 'Avant-Garde Jazz', 'Jazz Fusion', 'Smooth Jazz', 'Acid Jazz',
    'Nu Jazz', 'Latin Jazz', 'Afro-Cuban Jazz', 'Gypsy Jazz', 'Dixieland',
    'Ragtime', 'Soul Jazz', 'Post-Bop', 'Third Stream'
);

UPDATE "Genere" SET "main_genere" = 'Blues' WHERE "name" IN (
    'Delta Blues', 'Chicago Blues', 'Texas Blues', 'Piedmont Blues',
    'Country Blues', 'Electric Blues', 'British Blues', 'Jump Blues',
    'Boogie-Woogie', 'Swamp Blues', 'Hill Country Blues', 'Soul Blues',
    'Acoustic Blues', 'West Coast Blues', 'Memphis Blues'
);

UPDATE "Genere" SET "main_genere" = 'Country & Rockabilly' WHERE "name" IN (
    'Traditional Country', 'Outlaw Country', 'Country Pop', 'Country Rock',
    'Alt-Country', 'Americana', 'Bluegrass', 'Progressive Bluegrass',
    'Honky Tonk', 'Western Swing', 'Bakersfield Sound', 'Red Dirt',
    'Bro-Country', 'Rockabilly', 'Psychobilly'
);

UPDATE "Genere" SET "main_genere" = 'Folk & Singer-Songwriter' WHERE "name" IN (
    'Traditional Folk', 'Contemporary Folk', 'Indie Folk', 'Freak Folk',
    'Anti-Folk', 'Folktronica', 'Celtic Folk', 'Irish Traditional',
    'Appalachian Folk', 'Singer-Songwriter'
);

UPDATE "Genere" SET "main_genere" = 'Latin & Brazilian' WHERE "name" IN (
    'Salsa', 'Bachata', 'Merengue', 'Cumbia', 'Reggaeton', 'Latin Trap',
    'Bossa Nova', 'Samba', 'MPB', 'Tropicália', 'Forró', 'Baile Funk', 'Tango',
    'Mariachi', 'Ranchera', 'Norteño', 'Tejano', 'Bolero', 'Mambo', 'Cha-Cha-Chá'
);

UPDATE "Genere" SET "main_genere" = 'Caribbean & Jamaican' WHERE "name" IN (
    'Reggae', 'Dub', 'Ska', 'Rocksteady', 'Dancehall'
);

UPDATE "Genere" SET "main_genere" = 'Classical, Art Music & Avant-Garde' WHERE "name" IN (
    'Baroque', 'Classical Period', 'Romantic', 'Renaissance', 'Medieval',
    'Gregorian Chant', 'Impressionism', 'Modernism', 'Minimalism', 'Serialism',
    'Opera', 'Chamber Music', 'Symphony', 'Choral', 'Neoclassical',
    'Musique Concrète', 'Electroacoustic', 'Noise', 'Sound Collage', 'Microtonal'
);

UPDATE "Genere" SET "main_genere" = 'Global, African & Regional Traditions' WHERE "name" IN (
    'Afrobeat', 'Afrobeats', 'Amapiano', 'Highlife', 'Soukous', 'Mbalax',
    'Gnawa', 'Raï', 'Flamenco', 'Fado', 'Klezmer', 'Balkan Brass', 'Polka',
    'Hindustani Classical', 'Carnatic Classical', 'Qawwali', 'Bhangra',
    'Gamelan', 'Enka', 'Tuvan Throat Singing'
);
