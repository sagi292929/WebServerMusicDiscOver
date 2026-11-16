WITH song_albums(songTitle, albumTitle, trackNumber) AS (
    VALUES
        ('Owner of a Lonely Heart', '90125', 1),
        ('Roundabout', 'Fragile', 1),
        ('I''ve Seen All Good People', 'The Yes Album', 4),
        ('Leave It', '90125', 6),
        ('Love Will Find a Way', 'Big Generator', 5),
        ('Rhythm of Love', 'Big Generator', 1),
        ('Wonderous Stories', 'Going for the One', 4),
        ('Starship Trooper', 'The Yes Album', 3),
        ('Close to the Edge', 'Close to the Edge', 1),
        ('And You and I', 'Close to the Edge', 2)
)
INSERT INTO "album_songs" ("album_id", "song_id", "track_number")
SELECT album."Id", song."Id", song_albums.trackNumber
FROM song_albums
JOIN "Song" AS song ON song."title" = song_albums.songTitle
JOIN "Album" AS album ON album."title" = song_albums.albumTitle
JOIN "Band" AS albumBand ON albumBand."Id" = album."BandId"
    AND albumBand."es_id" = 'band-yes'
WHERE NOT EXISTS (
    SELECT 1
    FROM "album_songs" AS existing
    WHERE existing."album_id" = album."Id"
      AND existing."song_id" = song."Id"
);
