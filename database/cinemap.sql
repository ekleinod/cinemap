SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `cinemap_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_items` ;

CREATE  TABLE IF NOT EXISTS `cinemap_items` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'This table contains a unique id for all items. This is neede' /* comment truncated */;


-- -----------------------------------------------------
-- Table `cinemap_movies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_movies` ;

CREATE  TABLE IF NOT EXISTS `cinemap_movies` (
  `imdb_key` TEXT NOT NULL COMMENT 'IMDB key' ,
  `wikipedia` TEXT NULL COMMENT 'Page name of the english Wikipedia.' ,
  `marker` TEXT NULL COMMENT 'Name of the special marker, if needed. (overrides default marker)' ,
  `id` INT NOT NULL COMMENT 'Unique id (inherited from cinemap_id).' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Stored movies.';


-- -----------------------------------------------------
-- Table `cinemap_reporters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_reporters` ;

CREATE  TABLE IF NOT EXISTS `cinemap_reporters` (
  `short` TEXT NOT NULL ,
  `name` TEXT NULL COMMENT 'Full name.' ,
  `mail` TEXT NULL COMMENT 'mail address' ,
  `url` TEXT NULL COMMENT 'URL' ,
  `id` INT NOT NULL COMMENT 'Unique id (inherited from cinemap_id).' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Reporters of locations.';


-- -----------------------------------------------------
-- Table `cinemap_locations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_locations` ;

CREATE  TABLE IF NOT EXISTS `cinemap_locations` (
  `latitude` DOUBLE NOT NULL ,
  `longitude` DOUBLE NOT NULL COMMENT 'Mandatory longitude of position.' ,
  `marker` TEXT NULL COMMENT 'Name of the special marker, if needed. (overrides default marker)' ,
  `id` INT NOT NULL COMMENT 'Unique id (inherited from cinemap_id).' ,
  `movie_id` INT NOT NULL ,
  `reporter_id` INT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Stored locations for a movie. Every location is linked to on' /* comment truncated */;


-- -----------------------------------------------------
-- Table `cinemap_links`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_links` ;

CREATE  TABLE IF NOT EXISTS `cinemap_links` (
  `url` TEXT NOT NULL ,
  `id` INT NOT NULL COMMENT 'Unique id (inherited from cinemap_id).' ,
  `movie_id` INT NULL COMMENT 'ID of the movie (if the link belongs to a movie)' ,
  `location_id` INT NULL COMMENT 'ID of the location (if the link belongs to a location)' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Internetlinks for entries.';


-- -----------------------------------------------------
-- Table `cinemap_languages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_languages` ;

CREATE  TABLE IF NOT EXISTS `cinemap_languages` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `iso_639_3` VARCHAR(3) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `tag_UNIQUE` (`iso_639_3` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Available languages.';


-- -----------------------------------------------------
-- Table `cinemap_text_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_text_types` ;

CREATE  TABLE IF NOT EXISTS `cinemap_text_types` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `tag_UNIQUE` (`title` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Predefined text types.';


-- -----------------------------------------------------
-- Table `cinemap_texts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_texts` ;

CREATE  TABLE IF NOT EXISTS `cinemap_texts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `item_id` INT UNSIGNED NOT NULL ,
  `language_id` INT UNSIGNED NOT NULL ,
  `text_type_id` INT UNSIGNED NOT NULL ,
  `text_type` VARCHAR(100) NULL ,
  `value` TEXT NOT NULL ,
  UNIQUE INDEX `unique_index` (`item_id` ASC, `language_id` ASC, `text_type` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'All user visible texts that can be translated.\nThis is a ver' /* comment truncated */;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `cinemap_text_types`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `cinemap_text_types` (`id`, `title`) VALUES (1, 'other');
INSERT INTO `cinemap_text_types` (`id`, `title`) VALUES (2, 'title');
INSERT INTO `cinemap_text_types` (`id`, `title`) VALUES (3, 'description');

COMMIT;
