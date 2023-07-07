-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tartetempsion
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tartetempsion
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tartetempsion` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `tartetempsion` ;

-- -----------------------------------------------------
-- Table `tartetempsion`.`categorieprojet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tartetempsion`.`categorieprojet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nomcategorie` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tartetempsion`.`emploi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tartetempsion`.`emploi` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titreemploi` VARCHAR(50) NOT NULL,
  `descriptionemploi` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tartetempsion`.`employe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tartetempsion`.`employe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(50) NOT NULL,
  `prenom` VARCHAR(50) NOT NULL,
  `numeroagrement` VARCHAR(50) NOT NULL,
  `idemploi` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `numeroAgrement` (`numeroAgrement` ASC) VISIBLE,
  INDEX `idemploi` (`idemploi` ASC) VISIBLE,
  CONSTRAINT `employe_ibfk_1`
    FOREIGN KEY (`idemploi`)
    REFERENCES `tartetempsion`.`emploi` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tartetempsion`.`entite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tartetempsion`.`entite` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(50) NOT NULL,
  `adresse` VARCHAR(100) NOT NULL,
  `ville` VARCHAR(50) NOT NULL,
  `codepostal` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tartetempsion`.`etatprojet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tartetempsion`.`etatprojet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `etat` ENUM('signature attendu','pas encore démarrer', 'en cours', 'terminé') NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tartetempsion`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tartetempsion`.`service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(50) NOT NULL,
  `descriptionservice` TEXT NULL DEFAULT NULL,
  `identite` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `identite` (`identite` ASC) VISIBLE,
  CONSTRAINT `service_ibfk_1`
    FOREIGN KEY (`identite`)
    REFERENCES `tartetempsion`.`entite` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tartetempsion`.`projet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tartetempsion`.`projet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titre` VARCHAR(100) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `imageprojet` VARCHAR(100) NOT NULL,
  `clientprojet` VARCHAR(100) NOT NULL,
  `datedebut` DATE NOT NULL,
  `datefinprevue` DATE NOT NULL,
  `idservice` INT NULL DEFAULT NULL,
  `idcategorieprojet` INT NULL,
  `idetats` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `idservice` (`idservice` ASC) VISIBLE,
  INDEX `idcategorieprojet_idx` (`idcategorieprojet` ASC) VISIBLE,
  INDEX `idetats_idx` (`idetats` ASC) VISIBLE,
  CONSTRAINT `projet_ibfk_1`
    FOREIGN KEY (`idservice`)
    REFERENCES `tartetempsion`.`service` (`ID`),
  CONSTRAINT `idcategorieprojet`
    FOREIGN KEY (`idcategorieprojet`)
    REFERENCES `tartetempsion`.`categorieprojet` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idetats`
    FOREIGN KEY (`idetats`)
    REFERENCES `tartetempsion`.`etatprojet` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tartetempsion`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tartetempsion`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nomusers` VARCHAR(50) NOT NULL,
  `motdepasse` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `datecreationcompte` DATETIME NOT NULL,
  `derniereconnexion` DATETIME NOT NULL,
  `datesupressionsompte` DATETIME NOT NULL,
  `idemploye` INT NULL DEFAULT NULL,
  `idservice` INT NULL,
  `role` ENUM('superadmin', 'admin', 'user') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idemploye` (`idemploye` ASC) VISIBLE,
  INDEX `idservice_idx` (`idservice` ASC) VISIBLE,
  CONSTRAINT `users_ibfk_1`
    FOREIGN KEY (`idemploye`)
    REFERENCES `tartetempsion`.`employe` (`id`),
  CONSTRAINT `idservice`
    FOREIGN KEY (`idservice`)
    REFERENCES `tartetempsion`.`service` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


use tartetempsion;

