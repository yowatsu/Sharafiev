-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema msdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema msdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `msdb` DEFAULT CHARACTER SET utf8 ;
USE `msdb` ;

-- -----------------------------------------------------
-- Table `msdb`.`ACCOUNT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `msdb`.`ACCOUNT` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(64) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msdb`.`ARTIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `msdb`.`ARTIST` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msdb`.`ALBUM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `msdb`.`ALBUM` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(64) NOT NULL,
  `cover` MEDIUMBLOB NULL,
  `released` DATE NOT NULL,
  `ARTIST_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ARTIST_id` (`ARTIST_id` ASC) VISIBLE,
  CONSTRAINT `fk_artist_id`
    FOREIGN KEY (`ARTIST_id`)
    REFERENCES `msdb`.`ARTIST` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msdb`.`TRACK`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `msdb`.`TRACK` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(64) NOT NULL,
  `ALBUM_id` INT NOT NULL,
  `ARTIST_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ALBUM_id` (`ALBUM_id` ASC) VISIBLE,
  INDEX `fk_ARTIST_id` (`ARTIST_id` ASC) VISIBLE,
  CONSTRAINT `ALBUM_id`
    FOREIGN KEY (`ALBUM_id`)
    REFERENCES `msdb`.`ALBUM` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ARTIST_id`
    FOREIGN KEY (`ARTIST_id`)
    REFERENCES `msdb`.`ARTIST` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msdb`.`GENRE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `msdb`.`GENRE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msdb`.`TRACK GENRE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `msdb`.`TRACK GENRE` (
  `TRACK_id` INT NOT NULL,
  `GENRE_id` INT NOT NULL,
  PRIMARY KEY (`TRACK_id`, `GENRE_id`),
  INDEX `fk_GENRE_id` (`GENRE_id` ASC) VISIBLE,
  INDEX `fk_TRACK_id` (`TRACK_id` ASC) VISIBLE,
  CONSTRAINT `TRACK_id`
    FOREIGN KEY (`TRACK_id`)
    REFERENCES `msdb`.`TRACK` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `GENRE_id`
    FOREIGN KEY (`GENRE_id`)
    REFERENCES `msdb`.`GENRE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msdb`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `msdb`.`USER` (
  `ACCOUNT_id` INT NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `registered` DATE NOT NULL,
  PRIMARY KEY (`ACCOUNT_id`),
  INDEX `fk_ACCOUNT_id` (`ACCOUNT_id` ASC) VISIBLE,
  CONSTRAINT `ACCOUNT_id`
    FOREIGN KEY (`ACCOUNT_id`)
    REFERENCES `msdb`.`ACCOUNT` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msdb`.`USER ALBUM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `msdb`.`USER ALBUM` (
  `USER_ACCOUNT_id` INT NOT NULL,
  `ALBUM_id` INT NOT NULL,
  PRIMARY KEY (`USER_ACCOUNT_id`, `ALBUM_id`),
  INDEX `fk_USER_has_ALBUM_ALBUM1_idx` (`ALBUM_id` ASC) VISIBLE,
  INDEX `fk_USER_has_ALBUM_USER1_idx` (`USER_ACCOUNT_id` ASC) VISIBLE,
  CONSTRAINT `fk_USER_has_ALBUM_USER1`
    FOREIGN KEY (`USER_ACCOUNT_id`)
    REFERENCES `msdb`.`USER` (`ACCOUNT_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_has_ALBUM_ALBUM1`
    FOREIGN KEY (`ALBUM_id`)
    REFERENCES `msdb`.`ALBUM` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msdb`.`USER TRACK`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `msdb`.`USER TRACK` (
  `USER_ACCOUNT_id` INT NOT NULL,
  `TRACK_id` INT NOT NULL,
  PRIMARY KEY (`USER_ACCOUNT_id`, `TRACK_id`),
  INDEX `fk_USER_has_TRACK_TRACK1_idx` (`TRACK_id` ASC) VISIBLE,
  INDEX `fk_USER_has_TRACK_USER1_idx` (`USER_ACCOUNT_id` ASC) VISIBLE,
  CONSTRAINT `fk_USER_has_TRACK_USER1`
    FOREIGN KEY (`USER_ACCOUNT_id`)
    REFERENCES `msdb`.`USER` (`ACCOUNT_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_has_TRACK_TRACK1`
    FOREIGN KEY (`TRACK_id`)
    REFERENCES `msdb`.`TRACK` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
