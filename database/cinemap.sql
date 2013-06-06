SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `cinemap_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_items` ;

CREATE  TABLE IF NOT EXISTS `cinemap_items` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'This table contains a unique id for all items. This is neede' /* comment truncated */;


-- -----------------------------------------------------
-- Table `cinemap_locations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_locations` ;

CREATE  TABLE IF NOT EXISTS `cinemap_locations` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `item_id` INT UNSIGNED NOT NULL COMMENT 'Unique id (inherited from cinemap_id).' ,
  `latitude` DOUBLE NOT NULL ,
  `longitude` DOUBLE NOT NULL COMMENT 'Mandatory longitude of position.' ,
  `altitude` DOUBLE NULL ,
  `marker` TEXT NULL COMMENT 'Name of the special marker, if needed. (overrides default marker)' ,
  UNIQUE INDEX `item_id_UNIQUE` (`item_id` ASC) ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Stored locations for a movie. Every location is linked to on' /* comment truncated */;


-- -----------------------------------------------------
-- Table `cinemap_links`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_links` ;

CREATE  TABLE IF NOT EXISTS `cinemap_links` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `item_id` INT UNSIGNED NOT NULL COMMENT 'Unique id (inherited from cinemap_id).' ,
  `url` TEXT NOT NULL ,
  UNIQUE INDEX `item_id_UNIQUE` (`item_id` ASC) ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Internetlinks for entries.';


-- -----------------------------------------------------
-- Table `cinemap_movies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_movies` ;

CREATE  TABLE IF NOT EXISTS `cinemap_movies` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `item_id` INT UNSIGNED NOT NULL COMMENT 'Unique id (inherited from cinemap_id).' ,
  `imdb_key` VARCHAR(20) NOT NULL COMMENT 'IMDB key' ,
  `marker` VARCHAR(100) NULL COMMENT 'Name of the special marker, if needed. (overrides default marker)' ,
  UNIQUE INDEX `item_id_UNIQUE` (`item_id` ASC) ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Stored movies.';


-- -----------------------------------------------------
-- Table `cinemap_user_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_user_roles` ;

CREATE  TABLE IF NOT EXISTS `cinemap_user_roles` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `sid` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `tag_UNIQUE` (`sid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Possible user roles.';


-- -----------------------------------------------------
-- Table `cinemap_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_users` ;

CREATE  TABLE IF NOT EXISTS `cinemap_users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `item_id` INT UNSIGNED NOT NULL COMMENT 'Unique id (inherited from cinemap_id).' ,
  `user_role_id` INT UNSIGNED NOT NULL COMMENT 'URL' ,
  `username` VARCHAR(100) NOT NULL ,
  `password` VARCHAR(128) NOT NULL COMMENT 'Full name.' ,
  `salt` VARCHAR(128) NOT NULL COMMENT 'mail address' ,
  `name` VARCHAR(100) NULL ,
  `email` VARCHAR(100) NULL ,
  `url` VARCHAR(100) NULL ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  UNIQUE INDEX `item_id_UNIQUE` (`item_id` ASC) ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Cinemap users.';


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
  `sid` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `tag_UNIQUE` (`sid` ASC) )
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
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  UNIQUE INDEX `unique_index` (`item_id` ASC, `language_id` ASC, `text_type` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'All user visible texts that can be translated.\nThis is a ver' /* comment truncated */;


-- -----------------------------------------------------
-- Table `cinemap_reference_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_reference_roles` ;

CREATE  TABLE IF NOT EXISTS `cinemap_reference_roles` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `sid` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `tag_UNIQUE` (`sid` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Possible reference roles.';


-- -----------------------------------------------------
-- Table `cinemap_references`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_references` ;

CREATE  TABLE IF NOT EXISTS `cinemap_references` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `item_id` INT UNSIGNED NOT NULL ,
  `referenced_item_id` INT UNSIGNED NOT NULL ,
  `reference_role_id` INT UNSIGNED NOT NULL ,
  `created` DATETIME NOT NULL ,
  `modified` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'This table contains alreferences between two items.';


-- -----------------------------------------------------
-- Table `cinemap_images`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_images` ;

CREATE  TABLE IF NOT EXISTS `cinemap_images` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `item_id` INT UNSIGNED NOT NULL COMMENT 'Unique id (inherited from cinemap_id).' ,
  `filename` VARCHAR(100) NOT NULL ,
  `filepath` VARCHAR(100) NULL ,
  `latitude` DOUBLE NULL ,
  `longitude` DOUBLE NULL COMMENT 'Mandatory longitude of position.' ,
  `altitude` DOUBLE NULL ,
  `direction` DOUBLE NULL ,
  `bearing` DOUBLE NULL ,
  UNIQUE INDEX `item_id_UNIQUE` (`item_id` ASC) ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
COMMENT = 'Images for a location, movie, user etc.';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
