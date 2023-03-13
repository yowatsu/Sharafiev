/*test database*/

DROP DATABASE test;
CREATE DATABASE IF NOT EXISTS test;
USE test;

DROP TABLE IF EXISTS Account;
CREATE TABLE IF NOT EXISTS Account(
	id int PRIMARY KEY AUTO_INCREMENT,
	login varchar(64) UNIQUE NOT NULL,
	`password` varchar(128) NOT NULL
);

DROP TABLE IF EXISTS `User`;
CREATE TABLE IF NOT EXISTS `User`(
	account_id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(64) NOT NULL,
	registered date NOT NULL,
	FOREIGN KEY (account_id) REFERENCES Account(id)
);

DROP TABLE IF EXISTS Artist;
CREATE TABLE IF NOT EXISTS Artist(
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(64) NOT NULL
);

DROP TABLE IF EXISTS Album;
CREATE TABLE IF NOT EXISTS Album(
	id int PRIMARY KEY AUTO_INCREMENT,
	artist_id int NOT NULL,
	title varchar(64) NOT NULL,
	cover mediumblob,
	released date NOT NULL,
	FOREIGN KEY (artist_id) REFERENCES Artist(id)
);

DROP TABLE IF EXISTS Track;
CREATE TABLE IF NOT EXISTS Track(
	id int PRIMARY KEY AUTO_INCREMENT,
	title varchar(128),
	artist_id int NOT NULL,
	album_id int NOT NULL,
	FOREIGN KEY (artist_id) REFERENCES Artist(id),
	FOREIGN KEY (album_id) REFERENCES Album(id)
);

DROP TABLE IF EXISTS Genre;
CREATE TABLE IF NOT EXISTS Genre(
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(64) NOT NULL
);

DROP TABLE IF EXISTS `Track Genre`;
CREATE TABLE IF NOT EXISTS `Track Genre`(
  	track_id int NOT NULL,
  	genre_id int NOT NULL,
  	PRIMARY KEY (track_id, genre_id),
  	FOREIGN KEY (track_id) REFERENCES Track(id),
  	FOREIGN KEY (genre_id) REFERENCES Genre(id)
);

CREATE TABLE IF NOT EXISTS `User Album`(
  	account_id int NOT NULL,
  	album_id int NOT NULL,
  	PRIMARY KEY (account_id, album_id),
  	FOREIGN KEY (account_id) REFERENCES `User`(account_id),
  	FOREIGN KEY (album_id) REFERENCES Album(id)
);

CREATE TABLE IF NOT EXISTS `User Track`(
 	account_id int NOT NULL,
  	track_id int NOT NULL,
  	PRIMARY KEY (account_id, track_id),
  	FOREIGN KEY (account_id) REFERENCES `User`(account_id),
  	FOREIGN KEY (track_id) REFERENCES Track(id)
);
