
DROP TABLE album CASCADE;
CREATE TABLE album (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    PRIMARY KEY (id)
);

DROP TABLE track CASCADE;
CREATE TABLE track (
    id SERIAL,
    title TEXT,
    artist TEXT,
    album TEXT,
    album_id INT REFERENCES album(id) ON DELETE CASCADE,
    count INT,
    rating INT,
    len INT,
    PRIMARY KEY (id)
);

DROP TABLE artist CASCADE;
CREATE TABLE artist (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY (id)
);

DROP TABLE tracktoartist CASCADE;
CREATE TABLE tracktoartist (
    id SERIAL,
    track VARCHAR(128),
    track_id INT REFERENCES track(id) ON DELETE CASCADE,
    artist VARCHAR(128),
    artist_id INT REFERENCES artist(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);
