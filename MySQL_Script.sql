/*mss — music streaming service*/

DROP DATABASE IF EXISTS mss;
CREATE DATABASE mss;
USE mss;

DROP TABLE IF EXISTS Users;
CREATE TABLE Users(
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(64) NOT NULL,
	login varchar(64) UNIQUE NOT NULL,
	pass varchar(255) NOT NULL
);

DROP TABLE IF EXISTS Artists;
CREATE TABLE Artists(
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(128) NOT NULL
);

DROP TABLE IF EXISTS Albums;
CREATE TABLE Albums(
	id int PRIMARY KEY AUTO_INCREMENT,
	artist_id int NOT NULL,
	title varchar(255) NOT NULL,
	cover blob,
	released date NOT NULL,
	FOREIGN KEY (artist_id) REFERENCES Artists(id)
);

DROP TABLE IF EXISTS Genres;
CREATE TABLE Genres(
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(64) NOT NULL
);

DROP TABLE IF EXISTS Tracks;
CREATE TABLE Tracks(
	id int PRIMARY KEY AUTO_INCREMENT,
	title varchar(255),
	artist_id int NOT NULL,
	album_id int NOT NULL,
	genre_id int NOT NULL,
	FOREIGN KEY (artist_id) REFERENCES Artists(id),
	FOREIGN KEY (album_id) REFERENCES Albums(id),
	FOREIGN KEY (genre_id) REFERENCES Genres(id)
);

DROP TABLE IF EXISTS Playlists;
CREATE TABLE Playlists(
	id int PRIMARY KEY AUTO_INCREMENT,
	title varchar(255),
	cover blob,
	description text,
	user_id int NOT NULL,
	track_id int NOT NULL,
	FOREIGN KEY (user_id) REFERENCES Users(id),
	FOREIGN KEY (track_id) REFERENCES Tracks(id)
);

DROP TABLE IF EXISTS Library;
CREATE TABLE Library(
	user_id int NOT NULL,
	album_id int NOT NULL,
	playlist_id int NOT NULL,
	track_id int NOT NULL,
	FOREIGN KEY (user_id) REFERENCES Users(id) ,
	FOREIGN KEY (album_id) REFERENCES Albums(id),
	FOREIGN KEY (playlist_id) REFERENCES Playlists(id),
	FOREIGN KEY (track_id) REFERENCES Tracks(id)
);



