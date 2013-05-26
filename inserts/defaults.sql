-- -----------------------------------------------------
-- Data for table `cinemap_user_roles`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `cinemap_user_roles` (`id`, `sid`) VALUES (1, 'reporter');
INSERT INTO `cinemap_user_roles` (`id`, `sid`) VALUES (2, 'moderator');
INSERT INTO `cinemap_user_roles` (`id`, `sid`) VALUES (3, 'administrator');

COMMIT;

-- -----------------------------------------------------
-- Data for table `cinemap_text_types`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `cinemap_text_types` (`id`, `title`) VALUES (1, 'other');
INSERT INTO `cinemap_text_types` (`id`, `title`) VALUES (2, 'title');
INSERT INTO `cinemap_text_types` (`id`, `title`) VALUES (3, 'description');
INSERT INTO `cinemap_text_types` (`id`, `title`) VALUES (4, 'wikipedia');

COMMIT;

-- -----------------------------------------------------
-- Data for table `cinemap_reference_roles`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `cinemap_reference_roles` (`id`, `title`) VALUES (1, 'movie');
INSERT INTO `cinemap_reference_roles` (`id`, `title`) VALUES (2, 'reporter');

COMMIT;
