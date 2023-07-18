-- -- MySQL Workbench Forward Engineering

-- SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -- -----------------------------------------------------
-- -- Schema tartetempsion
-- -- -----------------------------------------------------

-- -- -----------------------------------------------------
-- -- Schema tartetempsion
-- -- -----------------------------------------------------
-- CREATE SCHEMA IF NOT EXISTS `tartetempsion` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
-- USE `tartetempsion` ;

-- -- -----------------------------------------------------
-- -- Table `tartetempsion`.`categorieprojet`
-- -- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `tartetempsion`.`categorieprojet` (
--   `id` INT NOT NULL AUTO_INCREMENT,
--   `nomcategorie` VARCHAR(50) NOT NULL,
--   PRIMARY KEY (`ID`))
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8mb4
-- COLLATE = utf8mb4_unicode_ci;


-- -- -----------------------------------------------------
-- -- Table `tartetempsion`.`emploi`
-- -- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `tartetempsion`.`emploi` (
--   `id` INT NOT NULL AUTO_INCREMENT,
--   `titreemploi` VARCHAR(50) NOT NULL,
--   `descriptionemploi` TEXT NULL DEFAULT NULL,
--   PRIMARY KEY (`ID`))
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8mb4
-- COLLATE = utf8mb4_unicode_ci;


-- -- -----------------------------------------------------
-- -- Table `tartetempsion`.`employe`
-- -- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `tartetempsion`.`employe` (
--   `id` INT NOT NULL AUTO_INCREMENT,
--   `nom` VARCHAR(50) NOT NULL,
--   `prenom` VARCHAR(50) NOT NULL,
--   `numeroagrement` VARCHAR(50) NOT NULL,
--   `idemploi` INT NULL DEFAULT NULL,
--   PRIMARY KEY (`ID`),
--   UNIQUE INDEX `numeroAgrement` (`numeroAgrement` ASC),
--   INDEX `idemploi` (`idemploi` ASC),
--   CONSTRAINT `employe_ibfk_1`
--     FOREIGN KEY (`idemploi`)
--     REFERENCES `tartetempsion`.`emploi` (`ID`))
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8mb4
-- COLLATE = utf8mb4_unicode_ci;



-- -- -----------------------------------------------------
-- -- Table `tartetempsion`.`entite`
-- -- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `tartetempsion`.`entite` (
--   `id` INT NOT NULL AUTO_INCREMENT,
--   `nom` VARCHAR(50) NOT NULL,
--   `adresse` VARCHAR(100) NOT NULL,
--   `ville` VARCHAR(50) NOT NULL,
--   `codepostal` VARCHAR(20) NOT NULL,
--   PRIMARY KEY (`ID`))
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8mb4
-- COLLATE = utf8mb4_unicode_ci;


-- -- -----------------------------------------------------
-- -- Table `tartetempsion`.`etatprojet`
-- -- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `tartetempsion`.`etatprojet` (
--   `id` INT NOT NULL AUTO_INCREMENT,
--   `etat` ENUM('signature attendu','pas encore démarrer', 'en cours', 'terminé') NULL DEFAULT NULL,
--   PRIMARY KEY (`ID`))
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8mb4
-- COLLATE = utf8mb4_unicode_ci;


-- -- -----------------------------------------------------
-- -- Table `tartetempsion`.`service`
-- -- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `tartetempsion`.`service` (
--   `id` INT NOT NULL AUTO_INCREMENT,
--   `nom` VARCHAR(50) NOT NULL,
--   `descriptionservice` TEXT NULL DEFAULT NULL,
--   `identite` INT NULL DEFAULT NULL,
--   PRIMARY KEY (`ID`),
--   INDEX `identite` (`identite` ASC),
--   CONSTRAINT `service_ibfk_1`
--     FOREIGN KEY (`identite`)
--     REFERENCES `tartetempsion`.`entite` (`ID`))
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8mb4
-- COLLATE = utf8mb4_unicode_ci;



-- -- -----------------------------------------------------
-- -- Table `tartetempsion`.`projet`
-- -- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `tartetempsion`.`projet` (
--   `id` INT NOT NULL AUTO_INCREMENT,
--   `titre` VARCHAR(100) NOT NULL,
--   `description` TEXT NULL DEFAULT NULL,
--   `imageprojet` VARCHAR(100) NOT NULL,
--   `clientprojet` VARCHAR(100) NOT NULL,
--   `datedebut` DATE NOT NULL,
--   `datefinprevue` DATE NOT NULL,
--   `idservice` INT NULL DEFAULT NULL,
--   `idcategorieprojet` INT NULL,
--   `idetats` INT NULL,
--   PRIMARY KEY (`ID`),
--   INDEX `idservice` (`idservice` ASC) ,
--   INDEX `idcategorieprojet_idx` (`idcategorieprojet` ASC) ,
--   INDEX `idetats_idx` (`idetats` ASC) ,
--   CONSTRAINT `projet_ibfk_1`
--     FOREIGN KEY (`idservice`)
--     REFERENCES `tartetempsion`.`service` (`ID`),
--   CONSTRAINT `idcategorieprojet`
--     FOREIGN KEY (`idcategorieprojet`)
--     REFERENCES `tartetempsion`.`categorieprojet` (`ID`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION,
--   CONSTRAINT `idetats`
--     FOREIGN KEY (`idetats`)
--     REFERENCES `tartetempsion`.`etatprojet` (`ID`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION)
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8mb4
-- COLLATE = utf8mb4_unicode_ci;


-- -- -----------------------------------------------------
-- -- Table `tartetempsion`.`users`
-- -- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `tartetempsion`.`users` (
--   `id` INT NOT NULL AUTO_INCREMENT,
--   `nomusers` VARCHAR(50) NOT NULL,
--   `motdepasse` VARCHAR(100) NOT NULL,
--   `email` VARCHAR(100) NOT NULL,
--   `datecreationcompte` DATETIME NOT NULL,
--   `derniereconnexion` DATETIME NOT NULL,
--   `datesupressionsompte` DATETIME NOT NULL,
--   `idemploye` INT NULL DEFAULT NULL,
--   `idservice` INT NULL,
--   `role` ENUM('superadmin', 'admin', 'user') NOT NULL,
--   PRIMARY KEY (`id`),
--   INDEX `idemploye` (`idemploye` ASC) ,
--   INDEX `idservice_idx` (`idservice` ASC) ,
--   CONSTRAINT `users_ibfk_1`
--     FOREIGN KEY (`idemploye`)
--     REFERENCES `tartetempsion`.`employe` (`id`),
--   CONSTRAINT `idservice`
--     FOREIGN KEY (`idservice`)
--     REFERENCES `tartetempsion`.`service` (`id`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION)
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8mb4
-- COLLATE = utf8mb4_unicode_ci;


-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- use tartetempsion;


-- use tartetempsion;

-- INSERT INTO `tartetempsion`.`entite` (`nom`, `adresse`, `ville`, `codepostal`)
-- VALUES 
-- ('Maison Mère', '123 rue principale', 'Lyon', '69000'),
-- ('Filiale 1', '456 rue A', 'Paris', '75000'),
-- ('Filiale 2', '789 rue B', 'Marseille', '13000'),
-- ('Filiale 3', '012 rue C', 'Toulouse', '31000'),
-- ('Filiale 4', '345 rue D', 'Nice', '06000');


-- INSERT INTO `tartetempsion`.`service` (`nom`, `descriptionservice`, `identite`) VALUES 
-- ('Service Web', 'Ce service se concentre sur la création et la maintenance d applications web.', 1),
-- ('Service Mobile', 'Ce service travaille sur le développement d applications mobiles.', 1),
-- ('Service Bureautique', 'Ce service se concentrerait sur les applications bureautiques', 1),
-- ('Service d Automatisation', 'Ce service se concentrerait sur la création d outils et de systèmes pour automatiser les processus métier.', 1),
-- ('Service RH', 'Ce service gère les besoins en personnel de l entreprise.', 1),
-- ('Service Projets', 'Ce service serait responsable de la gestion de tous les projets de l entreprise.', 1),
-- ('Service Administratif', 'Ce service s occuperait de tous les aspects administratifs de l entreprise.', 1),

-- ('Service RH', 'Ce service gère les besoins en personnel de l entreprise.', 5),
-- ('Service Projets', 'Ce service serait responsable de la gestion de tous les projets de l entreprise.', 5),
-- ('Service Administratif', 'Ce service s occuperait de tous les aspects administratifs de l entreprise.', 5),

-- ('Service Web', 'Ce service se concentre sur la création et la maintenance d applications web.', 3),
-- ('Service Mobile', 'Ce service travaille sur le développement d applications mobiles.', 3),
-- ('Service RH', 'Ce service gère les besoins en personnel de l entreprise.', 3),


-- ('Service Bureautique', 'Ce service se concentrerait sur les applications bureautiques', 4),
-- ('Service d Automatisation', 'Ce service se concentrerait sur la création d outils et de systèmes pour automatiser les processus métier.', 4),
-- ('Service RH', 'Ce service gère les besoins en personnel de l entreprise.', 4),

-- ('Service Web', 'Ce service se concentre sur la création et la maintenance d applications web.', 2),
-- ('Service Mobile', 'Ce service travaille sur le développement d applications mobiles.', 2),
-- ('Service Bureautique', 'Ce service se concentrerait sur les applications bureautiques', 2),
-- ('Service d Automatisation', 'Ce service se concentrerait sur la création d outils et de systèmes pour automatiser les processus métier.', 2),
-- ('Service RH', 'Ce service gère les besoins en personnel de l entreprise.', 2),
-- ('Service Projets', 'Ce service serait responsable de la gestion de tous les projets de l entreprise.', 2),
-- ('Service Administratif', 'Ce service s occuperait de tous les aspects administratifs de l entreprise.', 2);


-- INSERT INTO `tartetempsion`.`etatprojet` (`etat`) VALUES 
-- ('signature attendu'),
-- ('pas encore démarrer'),
-- ('en cours'),
-- ('terminé');

-- INSERT INTO `tartetempsion`.`categorieprojet` (`nomcategorie`) VALUES 
-- ('Web'),
-- ('Logiciel'),
-- ('Automatisation'),
-- ('CLI'),
-- ('Mobile'),
-- ('RH');
-- select * from service;

-- INSERT INTO `tartetempsion`.`projet` (`titre`, `description`, `imageprojet`, `clientprojet`, `datedebut`, `datefinprevue`, `idservice`, `idcategorieprojet`, `idetats`) VALUES 
-- ('Refonte du site e-commerce', 'Projet de refonte totale du site e-commerce de notre client pour améliorer l\'UX et le SEO.', 'C:\Users\moham\OneDrive\Images\refonte.jpg', 'ClientA', '2023-01-01', '2023-12-31', 1, 1, 3),
-- ('Application Mobile E-Banking', 'Développement d\'une application mobile pour permettre aux clients de notre client BanqueB d\'accéder à leurs comptes bancaires.', 'C:\Users\moham\OneDrive\Images\banking.jpg', 'BanqueB', '2023-01-02', '2023-12-30', 2, 5, 2),
-- ('Outil de gestion interne', 'Création d\'un outil de gestion interne pour faciliter la gestion des ressources humaines pour l\'entreprise ClienteC.', 'C:\Users\moham\OneDrive\Images\gestion.jpg', 'ClientC', '2023-01-03', '2023-12-29', 3, 2, 1),
-- ('Projet d\'automatisation des tests', 'Projet pour automatiser les tests pour l\'application mobile de l\'entreprise D.', 'C:\Users\moham\OneDrive\Images\automatisation.jpg', 'EntrepriseD', '2023-01-04', '2023-12-28', 4, 3, 4),
-- ('Recrutement de développeurs', 'Un projet pour recruter une équipe de développeurs pour le nouveau bureau de l\'entreprise E.', 'C:\Users\moham\OneDrive\Images\rh.jpg', 'EntrepriseE', '2023-02-01', '2023-12-01', 5, 6, 2),
-- ('Gestion du projet de transition numérique', 'Gestion du projet de transition numérique de l\'entreprise F, comprenant la mise en œuvre de nouvelles technologies et la formation des employés.', 'C:\Users\moham\OneDrive\Images\transition.jpg', 'EntrepriseF', '2023-02-02', '2023-12-02', 6, 1, 3),
-- ('Digitalisation des opérations administratives', 'Un projet pour dématérialiser toutes les opérations administratives et documents de l\'entreprise G.', 'C:\Users\moham\OneDrive\Images\digit.jpg', 'EntrepriseG', '2023-02-03', '2023-12-03', 7, 2, 1);


-- INSERT INTO `tartetempsion`.`emploi` (`titreemploi`, `descriptionemploi`) VALUES 
-- ('Développeur Web', 'Construit et maintient des applications Web en utilisant des langages tels que HTML, CSS, JavaScript, etc.'),
-- ('Concepteur UI/UX', 'Responsable de la conception et de l''amélioration de l''interface utilisateur et de l''expérience utilisateur pour nos applications. Utilise des outils tels que Sketch, Figma, Adobe XD, etc.'),
-- ('Développeur Mobile', 'Conçoit et crée des applications pour les appareils mobiles en utilisant des langages tels que Java, Swift, etc.'),
-- ('Spécialiste Bureautique', 'Travaille sur des applications bureautiques et fournit un soutien aux utilisateurs pour les questions liées à la bureautique.'),
-- ('Ingénieur d\'Automatisation', 'Construit des outils et des systèmes pour automatiser les processus métier. Utilise des technologies comme Python, Bash, etc.'),
-- ('Spécialiste RH', 'Gère les besoins en personnel de l\'entreprise, y compris le recrutement, la formation et le développement des employés.'),
-- ('Gestionnaire de Projet', 'Responsable de la gestion de tous les projets de l\'entreprise. S\'assure que les projets sont livrés à temps et respectent le budget.'),
-- ('Assistant Administratif', 'Gère tous les aspects administratifs de l\'entreprise, y compris la gestion des documents, la correspondance et la planification.');

-- select * from emploi;

-- INSERT INTO `tartetempsion`.`employe` (`nom`, `prenom`, `numeroagrement`, `idemploi`) VALUES 
-- ('Dupont', 'Jean', 'Agrement001', 1),
-- ('Martin', 'Pierre', 'Agrement002', 1),
-- ('Leroy', 'Francois', 'Agrement003', 1),
-- ('Petit', 'Paul', 'Agrement004', 1),
-- ('Lemaire', 'Robert', 'Agrement005', 1),

-- ('Bernard', 'Nathalie', 'Agrement006', 2),
-- ('Lefevre', 'Isabelle', 'Agrement007', 2),
-- ('Thomas', 'Christine', 'Agrement008', 2),
-- ('Dubois', 'Sophie', 'Agrement009', 2),
-- ('Laurent', 'Chloe', 'Agrement010', 2),

-- ('Simon', 'David', 'Agrement011', 3),
-- ('Fournier', 'Daniel', 'Agrement012', 3),
-- ('Morel', 'Bruno', 'Agrement013', 3),
-- ('Rousseau', 'Alexandre', 'Agrement014', 3),
-- ('Payet', 'Eric', 'Agrement015', 3),

-- ('Lemoine', 'Michelle', 'Agrement016', 4),
-- ('Aubert', 'Sandrine', 'Agrement017', 4),
-- ('Giraud', 'Elodie', 'Agrement018', 4),
-- ('Humbert', 'Corinne', 'Agrement019', 4),
-- ('Blanc', 'Estelle', 'Agrement020', 4),

-- ('Roche', 'Christian', 'Agrement021', 5),
-- ('Renard', 'Vincent', 'Agrement022', 5),
-- ('Marchand', 'Gilles', 'Agrement023', 5),
-- ('Dumas', 'Laurent', 'Agrement024', 5),
-- ('Dufour', 'Olivier', 'Agrement025', 5),

-- ('Lambert', 'Stephanie', 'Agrement026', 6),
-- ('Fontaine', 'Valerie', 'Agrement027', 6),
-- ('Roux', 'Catherine', 'Agrement028', 6),
-- ('Vincent', 'Josiane', 'Agrement029', 6),
-- ('Boyer', 'Odile', 'Agrement030', 6),

-- ('Andre', 'Denis', 'Agrement031', 7),
-- ('Lefevre', 'Patrick', 'Agrement032', 7),
-- ('Perrot', 'Bruno', 'Agrement033', 7),
-- ('Boucher', 'Jacques', 'Agrement034', 7),
-- ('Gauthier', 'Jerome', 'Agrement035', 7),

-- ('Lecomte', 'Veronique', 'Agrement036', 8),
-- ('Guyot', 'Marie', 'Agrement037', 8),
-- ('Barbier', 'Nathalie', 'Agrement038', 8),
-- ('Perrin', 'Anne', 'Agrement039', 8),
-- ('Boulanger', 'Evelyne', 'Agrement040', 8);
-- select * from employe;

-- INSERT INTO `tartetempsion`.`users` (`nomusers`, `motdepasse`, `email`, `datecreationcompte`, `derniereconnexion`, `datesupressionsompte`, `idemploye`, `idservice`, `role`) VALUES
-- ('Jean Dupont', 'password', 'jean.dupont@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 1, 1, 'superadmin'),
-- ('Pierre Martin', 'password', 'pierre.martin@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 2, 1, 'admin'),
-- ('Francois Leroy', 'password', 'francois.leroy@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 3, 1, 'user'),
-- ('Paul Petit', 'password', 'paul.petit@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 4, 1, 'user'),
-- ('Robert Lemaire', 'password', 'robert.lemaire@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 5, 1, 'user'),
-- ('Nathalie Bernard', 'password', 'nathalie.bernard@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 6, 5, 'admin'),
-- ('Isabelle Lefevre', 'password', 'isabelle.lefevre@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 7, 5, 'user'),
-- ('Christine Thomas', 'password', 'christine.thomas@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 8, 5, 'user'),
-- ('Sophie Dubois', 'password', 'sophie.dubois@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 9, 5, 'user'),
-- ('Chloe Laurent', 'password', 'chloe.laurent@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 10, 5, 'user'),
-- ('David Simon', 'password', 'david.simon@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 11, 3, 'admin'),
-- ('Daniel Fournier', 'password', 'daniel.fournier@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 12, 3, 'user'),
-- ('Bruno Morel', 'password', 'bruno.morel@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 13, 3, 'user'),
-- ('Alexandre Rousseau', 'password', 'alexandre.rousseau@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 14, 3, 'user'),
-- ('Eric Payet', 'password', 'eric.payet@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 15, 3, 'user'),
-- ('Michelle Lemoine', 'password', 'michelle.lemoine@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 16, 4, 'admin'),
-- ('Sandrine Aubert', 'password', 'sandrine.aubert@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 17, 4, 'user'),
-- ('Elodie Giraud', 'password', 'elodie.giraud@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 18, 4, 'user'),
-- ('Corinne Humbert', 'password', 'corinne.humbert@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 19, 4, 'user'),
-- ('Estelle Blanc', 'password', 'estelle.blanc@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 20, 4, 'user'),
-- ('Christian Roche', 'password', 'christian.roche@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 21, 2, 'admin'),
-- ('Vincent Renard', 'password', 'vincent.renard@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 22, 2, 'user'),
-- ('Gilles Marchand', 'password', 'gilles.marchand@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 23, 2, 'user'),
-- ('Laurent Dumas', 'password', 'laurent.dumas@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 24, 2, 'user'),
-- ('Olivier Dufour', 'password', 'olivier.dufour@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 25, 2, 'user'),
-- ('Stephanie Lambert', 'password', 'stephanie.lambert@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 26, 6, 'admin'),
-- ('Valerie Fontaine', 'password', 'valerie.fontaine@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 27, 6, 'user'),
-- ('Catherine Roux', 'password', 'catherine.roux@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 28, 6, 'user'),
-- ('Josiane Vincent', 'password', 'josiane.vincent@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 29, 6, 'user'),
-- ('Odile Boyer', 'password', 'odile.boyer@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 30, 6, 'user'),
-- ('Denis Andre', 'password', 'denis.andre@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 31, 7, 'admin'),
-- ('Patrick Lefevre', 'password', 'patrick.lefevre@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 32, 7, 'user'),
-- ('Bruno Perrot', 'password', 'bruno.perrot@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 33, 7, 'user'),
-- ('Jacques Boucher', 'password', 'jacques.boucher@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 34, 7, 'user'),
-- ('Jerome Gauthier', 'password', 'jerome.gauthier@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 35, 7, 'user'),
-- ('Veronique Lecomte', 'password', 'veronique.lecomte@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 36, 8, 'admin'),
-- ('Marie Guyot', 'password', 'marie.guyot@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 37, 8, 'user'),
-- ('Nathalie Barbier', 'password', 'nathalie.barbier@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 38, 8, 'user'),
-- ('Anne Perrin', 'password', 'anne.perrin@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 39, 8, 'user'),
-- ('Evelyne Boulanger', 'password', 'evelyne.boulanger@email.com', '2023-01-01 00:00:00', '2023-07-12 00:00:00', '9999-12-31 00:00:00', 40, 8, 'user');

-- SELECT * FROM SERVICE;
-- DELETE FROM `tartetempsion`.`service`
-- WHERE (nom, descriptionservice, identite) NOT IN (
--     SELECT MIN(identite), nom, descriptionservice
--     FROM `tartetempsion`.`service`
--     GROUP BY nom, descriptionservice, identite
-- );

