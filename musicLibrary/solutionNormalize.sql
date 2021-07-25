


\copy track(title,artist,album,count,rating,len) FROM 'library.csv' WITH DELIMITER ',' CSV;

INSERT INTO album (title) SELECT DISTINCT album FROM track;
UPDATE track SET album_id = (SELECT album.id FROM album WHERE album.title = track.album);


INSERT INTO artist (name) SELECT DISTINCT artist FROM track;


INSERT INTO tracktoartist (track, artist) SELECT DISTINCT title, artist FROM track ORDER BY title;
  --migrate the track titles and artist name FROM tack table into corresponding tracktoartist text columns.
  --having these TEXT tables in tracktoartist would help insert the appropriate FK id's 


UPDATE tracktoartist SET track_id = (SELECT track.id FROM track WHERE track.title = tracktoartist.track);
  --update track id
UPDATE tracktoartist SET artist_id = (SELECT artist.id FROM artist WHERE artist.name = tracktoartist.artist);
  --update artist id



-- We are now done with these text fields
ALTER TABLE track DROP COLUMN album;
ALTER TABLE track DROP COLUMN artist;
ALTER TABLE tracktoartist DROP COLUMN track;
ALTER TABLE tracktoartist DROP COLUMN artist;


-- Test result
SELECT track.title, album.title, artist.name
FROM track
JOIN album ON track.album_id = album.id
JOIN tracktoartist ON track.id = tracktoartist.track_id
JOIN artist ON tracktoartist.artist_id = artist.id
ORDER BY track.title
LIMIT 3;

-- The expected result of this query on your database is:
-- title	                    album	                            artist
-- A Boy Named Sue (live)       The Legend Of Johnny Cash	        Johnny Cash
-- A Brief History of Packets	Computing Conversations	            IEEE Computer Society
-- Aguas De Marco	            Natural Wonders Music Sampler 1999	Rosa Passos

