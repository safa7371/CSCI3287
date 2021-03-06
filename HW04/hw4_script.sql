-- MySQL Script generated by MySQL Workbench
-- Wed Oct 28 19:24:44 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`neuteredspayed_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`neuteredspayed_info` ;

CREATE TABLE IF NOT EXISTS `mydb`.`neuteredspayed_info` (
  `Gender` VARCHAR(45) NOT NULL,
  `NeuterSpay` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Gender`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`petowner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`petowner` ;

CREATE TABLE IF NOT EXISTS `mydb`.`petowner` (
  `PetID` INT NOT NULL AUTO_INCREMENT,
  `OwnerName` VARCHAR(45) NOT NULL,
  `PhoneNumber` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PetID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`petrecord`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`petrecord` ;

CREATE TABLE IF NOT EXISTS `mydb`.`petrecord` (
  `PetID` INT NOT NULL AUTO_INCREMENT,
  `OwnerName` VARCHAR(45) NOT NULL,
  `PetName` VARCHAR(45) NOT NULL,
  `Breed` VARCHAR(45) NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  `Markings` VARCHAR(45) NULL DEFAULT NULL,
  `Age` INT NOT NULL,
  `Gender` VARCHAR(45) NOT NULL,
  `NeuteredSpayed_Info_Gender` VARCHAR(45) NOT NULL,
  `PetOwner_PetID` INT NOT NULL,
  `PetOwner_OwnerName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PetID`),
  CONSTRAINT `fk_PetRecord_NeuteredSpayed_Info1`
    FOREIGN KEY (`NeuteredSpayed_Info_Gender`)
    REFERENCES `mydb`.`neuteredspayed_info` (`Gender`),
  CONSTRAINT `fk_PetRecord_PetOwner1`
    FOREIGN KEY (`PetOwner_PetID`)
    REFERENCES `mydb`.`petowner` (`PetID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_PetRecord_NeuteredSpayed_Info1_idx` ON `mydb`.`petrecord` (`NeuteredSpayed_Info_Gender` ASC);

CREATE INDEX `fk_PetRecord_PetOwner1_idx` ON `mydb`.`petrecord` (`PetOwner_PetID` ASC, `PetOwner_OwnerName` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`trainingschedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`trainingschedule` ;

CREATE TABLE IF NOT EXISTS `mydb`.`trainingschedule` (
  `PetID` INT NOT NULL AUTO_INCREMENT,
  `RegistrationID` INT NOT NULL,
  `Trainers` VARCHAR(45) NOT NULL,
  `Classes` VARCHAR(45) NOT NULL,
  `TrainingDate` DATETIME NOT NULL,
  `PetRecord_PetID` INT NOT NULL,
  `PetRecord_PetOwner_PetID` INT NOT NULL,
  `PetRecord_PetOwner_OwnerName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PetID`, `RegistrationID`),
  CONSTRAINT `fk_TrainingSchedule_PetRecord1`
    FOREIGN KEY (`PetRecord_PetID`)
    REFERENCES `mydb`.`petrecord` (`PetID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_TrainingSchedule_PetRecord1_idx` ON `mydb`.`trainingschedule` (`PetRecord_PetID` ASC, `PetRecord_PetOwner_PetID` ASC, `PetRecord_PetOwner_OwnerName` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`classes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`classes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`classes` (
  `TrainingScheduleID` INT NOT NULL,
  `BasicSkills` VARCHAR(45) NOT NULL,
  `WalkIn` VARCHAR(45) NOT NULL,
  `OffLeash` VARCHAR(45) NOT NULL,
  `TrainingSchedule_PetID` INT NOT NULL,
  `TrainingSchedule_TrainingScheduleID` INT NOT NULL,
  PRIMARY KEY (`TrainingScheduleID`, `TrainingSchedule_PetID`, `TrainingSchedule_TrainingScheduleID`),
  CONSTRAINT `fk_Classes_TrainingSchedule1`
    FOREIGN KEY (`TrainingSchedule_PetID` , `TrainingSchedule_TrainingScheduleID`)
    REFERENCES `mydb`.`trainingschedule` (`PetID` , `RegistrationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Classes_TrainingSchedule1_idx` ON `mydb`.`classes` (`TrainingSchedule_PetID` ASC, `TrainingSchedule_TrainingScheduleID` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
