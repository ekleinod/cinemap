-- -----------------------------------------------------
-- Table `cinemap_id`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_id` ;

CREATE  TABLE IF NOT EXISTS `cinemap_id` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Unique id throughout the whole database.' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COMMENT = 'This table contains a unique id for all elements. This is needed for uniquely identifying elements in order to translate parts of their data.';


-- -----------------------------------------------------
-- Table `cinemap_movies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_movies` ;

CREATE  TABLE IF NOT EXISTS `cinemap_movies` (
  `imdb_key` TEXT NOT NULL COMMENT 'IMDB key' ,
  `wikipedia` TEXT NULL COMMENT 'Page name of the english Wikipedia.' ,
  `marker` TEXT NULL COMMENT 'Name of the special marker, if needed. (overrides default marker)' ,
  `id` INT NOT NULL COMMENT 'Unique id (inherited from cinemap_id).' ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_cinemap_movies_cinemap_id`
    FOREIGN KEY (`id` )
    REFERENCES `cinemap_id` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
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
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_cinemap_reporters_cinemap_id1`
    FOREIGN KEY (`id` )
    REFERENCES `cinemap_id` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
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
  PRIMARY KEY (`id`) ,
  INDEX `fk_movie` (`movie_id` ASC) ,
  INDEX `fk_reporter` (`reporter_id` ASC) ,
  CONSTRAINT `fk_cinemap_locations_cinemap_id1`
    FOREIGN KEY (`id` )
    REFERENCES `cinemap_id` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cinemap_locations_cinemap_movies1`
    FOREIGN KEY (`movie_id` )
    REFERENCES `cinemap_movies` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cinemap_locations_cinemap_reporters1`
    FOREIGN KEY (`reporter_id` )
    REFERENCES `cinemap_reporters` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COMMENT = 'Stored locations for a movie. Every location is linked to one movie, every movie can have several locations.';


-- -----------------------------------------------------
-- Table `cinemap_links`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_links` ;

CREATE  TABLE IF NOT EXISTS `cinemap_links` (
  `url` TEXT NOT NULL ,
  `id` INT NOT NULL COMMENT 'Unique id (inherited from cinemap_id).' ,
  `movie_id` INT NULL COMMENT 'ID of the movie (if the link belongs to a movie)' ,
  `location_id` INT NULL COMMENT 'ID of the location (if the link belongs to a location)' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_movie` (`movie_id` ASC) ,
  INDEX `fk_location` (`location_id` ASC) ,
  CONSTRAINT `fk_cinemap_links_cinemap_id1`
    FOREIGN KEY (`id` )
    REFERENCES `cinemap_id` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cinemap_links_cinemap_movies1`
    FOREIGN KEY (`movie_id` )
    REFERENCES `cinemap_movies` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cinemap_links_cinemap_locations1`
    FOREIGN KEY (`location_id` )
    REFERENCES `cinemap_locations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COMMENT = 'Internetlinks for entries.';


-- -----------------------------------------------------
-- Table `cinemap_languages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_languages` ;

CREATE  TABLE IF NOT EXISTS `cinemap_languages` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Unique language id.' ,
  `tag` VARCHAR(100) NOT NULL COMMENT 'Language tag (e.g. IETF language tag) (varchar, because otherwise it could not be set to unique)' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `tag_UNIQUE` (`tag` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table of available languages. Because of the different kinds of language notation, the representation of the language was encapsulated in this table, so we can use \"TEXT\" as type of the column. Thus we use the language id in the texts table.\n(This is needed, because \"TEXT\" is not allowed an INDEX in a table.)';


-- -----------------------------------------------------
-- Table `cinemap_texts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinemap_texts` ;

CREATE  TABLE IF NOT EXISTS `cinemap_texts` (
  `entry_id` INT NOT NULL ,
  `language_id` INT NOT NULL COMMENT 'Language id.' ,
  `key` VARCHAR(100) NOT NULL COMMENT 'Name of the text. (key of key-value-store)\nHas to be a varchar, because of restrictions of MySQL indices, they cannot be TEXTs.\nA length of 100 should be sufficient.' ,
  `value` TEXT NOT NULL COMMENT 'Value of the text. (value of key-value-store)' ,
  INDEX `fk_entry` (`entry_id` ASC) ,
  INDEX `fk_language` (`language_id` ASC) ,
  UNIQUE INDEX `unique_index` (`entry_id` ASC, `language_id` ASC, `key` ASC) ,
  CONSTRAINT `fk_cinemap_texts_cinemap_id1`
    FOREIGN KEY (`entry_id` )
    REFERENCES `cinemap_id` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cinemap_texts_cinemap_languages1`
    FOREIGN KEY (`language_id` )
    REFERENCES `cinemap_languages` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COMMENT = 'All user visible texts that can be translated.\nThis is a very flexible method for displaying texts, you can put every text in this table, organizing them by the value of the \"name\" column.\nThe disadvantage of this approach lies in the weak typing of texts. E.g. you cannot enforce the user to put titles in \"title\" rather than \"titel\", or both (typo detection and correction).';



-- -----------------------------------------------------
-- Data for table `cinemap_id`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO cinemap_id (`id`) VALUES ('1');
INSERT INTO cinemap_id (`id`) VALUES ('2');
INSERT INTO cinemap_id (`id`) VALUES ('3');
INSERT INTO cinemap_id (`id`) VALUES ('4');
INSERT INTO cinemap_id (`id`) VALUES ('5');
INSERT INTO cinemap_id (`id`) VALUES ('6');
INSERT INTO cinemap_id (`id`) VALUES ('7');
INSERT INTO cinemap_id (`id`) VALUES ('8');
INSERT INTO cinemap_id (`id`) VALUES ('9');
INSERT INTO cinemap_id (`id`) VALUES ('10');
INSERT INTO cinemap_id (`id`) VALUES ('11');
INSERT INTO cinemap_id (`id`) VALUES ('12');

COMMIT;

-- -----------------------------------------------------
-- Data for table `cinemap_movies`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO cinemap_movies (`imdb_key`, `wikipedia`, `marker`, `id`) VALUES ('tt0372183', 'The_Bourne_Supremacy_(film)', NULL, '1');
INSERT INTO cinemap_movies (`imdb_key`, `wikipedia`, `marker`, `id`) VALUES ('tt0402022', NULL, NULL, '2');
INSERT INTO cinemap_movies (`imdb_key`, `wikipedia`, `marker`, `id`) VALUES ('tt0434409', NULL, NULL, '8');
INSERT INTO cinemap_movies (`imdb_key`, `wikipedia`, `marker`, `id`) VALUES ('tt0081947', NULL, NULL, '10');

COMMIT;

-- -----------------------------------------------------
-- Data for table `cinemap_reporters`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO cinemap_reporters (`short`, `name`, `mail`, `url`, `id`) VALUES ('ekleinod', 'Ekkart Kleinod', NULL, 'http://www.ekkart.de/', '5');

COMMIT;

-- -----------------------------------------------------
-- Data for table `cinemap_locations`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO cinemap_locations (`latitude`, `longitude`, `marker`, `id`, `movie_id`, `reporter_id`) VALUES ('52.52253', '13.42879', NULL, '3', '1', '5');
INSERT INTO cinemap_locations (`latitude`, `longitude`, `marker`, `id`, `movie_id`, `reporter_id`) VALUES ('52.43148', '13.53029', NULL, '4', '2', '5');
INSERT INTO cinemap_locations (`latitude`, `longitude`, `marker`, `id`, `movie_id`, `reporter_id`) VALUES ('52.51361', '13.39233', NULL, '9', '8', '5');
INSERT INTO cinemap_locations (`latitude`, `longitude`, `marker`, `id`, `movie_id`, `reporter_id`) VALUES ('53.91472', '10.03527', NULL, '11', '10', '5');

COMMIT;

-- -----------------------------------------------------
-- Data for table `cinemap_links`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO cinemap_links (`url`, `id`, `movie_id`, `location_id`) VALUES ('http://en.wikipedia.org/wiki/Charlize_Theron', '6', '2', NULL);
INSERT INTO cinemap_links (`url`, `id`, `movie_id`, `location_id`) VALUES ('http://www.imdb.com/name/nm0000234/', '7', '2', NULL);
INSERT INTO cinemap_links (`url`, `id`, `movie_id`, `location_id`) VALUES ('http://www.flugplatz-hartenholm.de/', '12', NULL, '11');

COMMIT;

-- -----------------------------------------------------
-- Data for table `cinemap_languages`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO cinemap_languages (`id`, `tag`) VALUES ('1', 'en');
INSERT INTO cinemap_languages (`id`, `tag`) VALUES ('2', 'de');

COMMIT;

-- -----------------------------------------------------
-- Data for table `cinemap_texts`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('1', '1', 'title', 'The Bourne Supremacy');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('1', '1', 'description', 'A movie with Matt Damon.');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('2', '1', 'title', 'Æon Flux');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('3', '1', 'title', 'The Shopping Mall');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('3', '2', 'title', 'Der Supermarkt');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('3', '1', 'description', 'The shopping mall at the beginning of the movie.\\\\ The original building is a shopping mall in Berlin, called //Reichelt//. In order to simulate wintertime, artificial snow was put around the mall. The scene was shot in May.');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('4', '1', 'title', 'Headquarter Hall');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('4', '1', 'description', 'The headquarter hall where e.g. the exploding balls are rolling around.\\\\ The building is an old wind tunnel in Berlin Adlershof. It is a historical monument now.');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('4', '2', 'description', 'Die Halle des Hauptquartiers, in dem z.B. die Explosivbälle herumrollen.\\\\ Das Gebäude ist der alte Windkanal in Berlin Adlershof. Heute ist es ein Denkmal.');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('6', '1', 'source', 'Wikipedia');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('7', '1', 'source', 'IMDB');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('7', '1', 'title', 'Charlize Theron');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('1', '2', 'description', 'Ein Film mit Matt Damon.');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('8', '1', 'title', 'V for Vendetta');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('9', '1', 'title', 'Regents balcony');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('9', '2', 'title', 'Balkon des Herrschers');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('9', '1', 'description', 'The balcony, from which the regent (John Hurt) delivers his speeches.\\\\ This is the \"Schauspielhaus\" at Gendarmenmarkt, a house for plays, operas and such.');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('9', '2', 'description', 'Der Balkon, von dem aus der Herrscher (John Hurt) seine Reden hält.\\\\ Gedreht wurde am Schauspielhaus auf dem gendarmenmarkt, wo sonst klassiche Konzerte, Opern etc. stattfinden.');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('8', '2', 'title', 'V wie Vendetta');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('10', '1', 'title', 'Timm Thaler');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('11', '1', 'title', 'Airfield Hartenholm');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('11', '2', 'title', 'Flugplatz Hartenholm');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('11', '1', 'description', 'Several scenes were filmed here in 1978.');
INSERT INTO cinemap_texts (`entry_id`, `language_id`, `key`, `value`) VALUES ('11', '2', 'description', 'Einige Szenen wurde 1978 hier gedreht.');

COMMIT;
