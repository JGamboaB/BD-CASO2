-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Strava
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Strava
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Strava` DEFAULT CHARACTER SET utf8 ;
USE `Strava` ;

-- -----------------------------------------------------
-- Table `Strava`.`Genders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`Genders` (
  `idGender` TINYINT(100) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGender`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`People`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`People` (
  `idPerson` BIGINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname1` VARCHAR(45) NOT NULL,
  `surname2` VARCHAR(45) NULL,
  `birthDate` DATE NOT NULL,
  `gender` BIT NOT NULL,
  `height` DOUBLE NOT NULL,
  `weight` DOUBLE NOT NULL,
  `password` BINARY(300) NOT NULL,
  PRIMARY KEY (`idPerson`),
  CONSTRAINT `idGender`
    FOREIGN KEY ()
    REFERENCES `Strava`.`Genders` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`Pictures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`Pictures` (
  `idPicture` BIGINT NOT NULL,
  `url` VARCHAR(800) NULL,
  PRIMARY KEY (`idPicture`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`PicturesPerPerson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`PicturesPerPerson` (
  `idPicturesPerPerson` BIGINT NOT NULL,
  `idPicture` BIGINT NOT NULL,
  `idPeople` BIGINT NOT NULL,
  `default` BIT NOT NULL,
  `postingTime` DATE NOT NULL,
  PRIMARY KEY (`idPicturesPerPerson`),
  INDEX `fk_PicturesPerPerson_Pictures_idx` (`idPicture` ASC) VISIBLE,
  INDEX `fk_PicturesPerPerson_People1_idx` (`idPeople` ASC) VISIBLE,
  CONSTRAINT `fk_PicturesPerPerson_Pictures`
    FOREIGN KEY (`idPicture`)
    REFERENCES `Strava`.`Pictures` (`idPicture`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PicturesPerPerson_People1`
    FOREIGN KEY (`idPeople`)
    REFERENCES `Strava`.`People` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`Sports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`Sports` (
  `idSport` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSport`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`Variables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`Variables` (
  `idVariable` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idVariable`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`SportVariables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`SportVariables` (
  `idSportVariable` INT NOT NULL,
  `minSpeed` DOUBLE NOT NULL,
  `maxSpeed` DOUBLE NOT NULL,
  `timeFrame` DOUBLE NULL,
  `idSport` INT NOT NULL,
  `idVariable` INT NOT NULL,
  PRIMARY KEY (`idSportVariable`),
  INDEX `fk_SportVariables_Sports1_idx` (`idSport` ASC) VISIBLE,
  INDEX `fk_SportVariables_Variables1_idx` (`idVariable` ASC) VISIBLE,
  CONSTRAINT `fk_SportVariables_Sports1`
    FOREIGN KEY (`idSport`)
    REFERENCES `Strava`.`Sports` (`idSport`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SportVariables_Variables1`
    FOREIGN KEY (`idVariable`)
    REFERENCES `Strava`.`Variables` (`idVariable`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`SportSessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`SportSessions` (
  `idSportSession` BIGINT NOT NULL,
  `startTime` DATE NOT NULL,
  `endTime` DATE NULL,
  `postingTime` DATE NOT NULL,
  `Deleted` BIT NOT NULL,
  `idPerson` BIGINT NOT NULL,
  `idSport` INT NOT NULL,
  PRIMARY KEY (`idSportSession`),
  INDEX `fk_SportSessions_People1_idx` (`idPerson` ASC) VISIBLE,
  INDEX `fk_SportSessions_Sports1_idx` (`idSport` ASC) VISIBLE,
  CONSTRAINT `fk_SportSessions_People1`
    FOREIGN KEY (`idPerson`)
    REFERENCES `Strava`.`People` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SportSessions_Sports1`
    FOREIGN KEY (`idSport`)
    REFERENCES `Strava`.`Sports` (`idSport`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`TrackEventTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`TrackEventTypes` (
  `idTrackEventType` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idTrackEventType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`SportLogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`SportLogs` (
  `idSportLog` BIGINT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `latitud` DOUBLE NOT NULL,
  `longitud` DOUBLE NOT NULL,
  `giroscopio` DOUBLE NULL,
  `idTrackEventType` INT NOT NULL,
  `idSportSession` INT NOT NULL,
  PRIMARY KEY (`idSportLog`),
  INDEX `fk_SportLogs_TrackEventTypes1_idx` (`idTrackEventType` ASC) VISIBLE,
  INDEX `fk_SportLogs_SportSessions1_idx` (`idSportSession` ASC) VISIBLE,
  CONSTRAINT `fk_SportLogs_TrackEventTypes1`
    FOREIGN KEY (`idTrackEventType`)
    REFERENCES `Strava`.`TrackEventTypes` (`idTrackEventType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SportLogs_SportSessions1`
    FOREIGN KEY (`idSportSession`)
    REFERENCES `Strava`.`SportSessions` (`idSportSession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`Rankings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`Rankings` (
  `value` DOUBLE NOT NULL,
  `postTime` DATETIME NOT NULL,
  `processed` BIT NULL,
  `idRanking` INT NOT NULL,
  `idPerson` BIGINT NOT NULL,
  `idSport` INT NOT NULL,
  `idVariable` INT NOT NULL,
  PRIMARY KEY (`idRanking`),
  INDEX `fk_Rankings_People1_idx` (`idPerson` ASC) VISIBLE,
  INDEX `fk_Rankings_Sports1_idx` (`idSport` ASC) VISIBLE,
  INDEX `fk_Rankings_Variables1_idx` (`idVariable` ASC) VISIBLE,
  CONSTRAINT `fk_Rankings_People1`
    FOREIGN KEY (`idPerson`)
    REFERENCES `Strava`.`People` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rankings_Sports1`
    FOREIGN KEY (`idSport`)
    REFERENCES `Strava`.`Sports` (`idSport`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rankings_Variables1`
    FOREIGN KEY (`idVariable`)
    REFERENCES `Strava`.`Variables` (`idVariable`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`Prizes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`Prizes` (
  `idPrize` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` NVARCHAR(8000) NULL,
  `Sports_idSport` INT NOT NULL,
  PRIMARY KEY (`idPrize`),
  INDEX `fk_Prizes_Sports1_idx` (`Sports_idSport` ASC) VISIBLE,
  CONSTRAINT `fk_Prizes_Sports1`
    FOREIGN KEY (`Sports_idSport`)
    REFERENCES `Strava`.`Sports` (`idSport`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`PrizesxRankings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`PrizesxRankings` (
  `Rankings_idRanking` INT NOT NULL,
  `Prizes_idPrize` INT NOT NULL,
  INDEX `fk_PrizesxRankings_Rankings1_idx` (`Rankings_idRanking` ASC) VISIBLE,
  INDEX `fk_PrizesxRankings_Prizes1_idx` (`Prizes_idPrize` ASC) VISIBLE,
  CONSTRAINT `fk_PrizesxRankings_Rankings1`
    FOREIGN KEY (`Rankings_idRanking`)
    REFERENCES `Strava`.`Rankings` (`idRanking`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PrizesxRankings_Prizes1`
    FOREIGN KEY (`Prizes_idPrize`)
    REFERENCES `Strava`.`Prizes` (`idPrize`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`PicturesPerSessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`PicturesPerSessions` (
  `idPicturesPerSession` BIGINT NOT NULL,
  `idPicture` BIGINT NOT NULL,
  `idSportSession` BIGINT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `default` BIT NOT NULL,
  PRIMARY KEY (`idPicturesPerSession`),
  INDEX `fk_PicturesPerSessions_Pictures1_idx` (`idPicture` ASC) VISIBLE,
  INDEX `fk_PicturesPerSessions_SportSessions1_idx` (`idSportSession` ASC) VISIBLE,
  CONSTRAINT `fk_PicturesPerSessions_Pictures1`
    FOREIGN KEY (`idPicture`)
    REFERENCES `Strava`.`Pictures` (`idPicture`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PicturesPerSessions_SportSessions1`
    FOREIGN KEY (`idSportSession`)
    REFERENCES `Strava`.`SportSessions` (`idSportSession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`Merchants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`Merchants` (
  `idMerchant` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `url` VARCHAR(800) NOT NULL,
  `enabled` BIT NOT NULL,
  `iconURL` VARCHAR(800) NOT NULL,
  PRIMARY KEY (`idMerchant`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`PaymentStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`PaymentStatus` (
  `idPaymentStatus` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPaymentStatus`))
ENGINE = InnoDB
COMMENT = '\n';


-- -----------------------------------------------------
-- Table `Strava`.`PaymentAttempts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`PaymentAttempts` (
  `idPaymentAttempts` BIGINT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `currencySymbol` NVARCHAR(3) NOT NULL,
  `referenceNumber` BIGINT NOT NULL,
  `errorNumber` BIGINT NULL,
  `merchantTransNumber` BIGINT NOT NULL,
  `description` NVARCHAR(200) NOT NULL,
  `paymentTimeStamp` DATETIME NOT NULL,
  `computerName` VARCHAR(100) NOT NULL,
  `userName` NVARCHAR(100) NOT NULL,
  `ipAdress` VARBINARY(16) NOT NULL,
  `checkSum` INT NOT NULL,
  `idMerchant` INT NOT NULL,
  `idPaymentStatus` INT NOT NULL,
  `idPerson` BIGINT NOT NULL,
  PRIMARY KEY (`idPaymentAttempts`),
  INDEX `fk_PaymentAttempts_Merchants1_idx` (`idMerchant` ASC) VISIBLE,
  INDEX `fk_PaymentAttempts_PaymentStatus1_idx` (`idPaymentStatus` ASC) VISIBLE,
  INDEX `fk_PaymentAttempts_People1_idx` (`idPerson` ASC) VISIBLE,
  CONSTRAINT `fk_PaymentAttempts_Merchants1`
    FOREIGN KEY (`idMerchant`)
    REFERENCES `Strava`.`Merchants` (`idMerchant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PaymentAttempts_PaymentStatus1`
    FOREIGN KEY (`idPaymentStatus`)
    REFERENCES `Strava`.`PaymentStatus` (`idPaymentStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PaymentAttempts_People1`
    FOREIGN KEY (`idPerson`)
    REFERENCES `Strava`.`People` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`RecurrenceTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`RecurrenceTypes` (
  `idRecurrenceTypes` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `valueToAdd` INT NOT NULL,
  `datepart` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`idRecurrenceTypes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`Plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`Plans` (
  `idPlans` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descriptionHTML` NVARCHAR(8000) NOT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `starTime` DATETIME NOT NULL,
  `endTIme` DATETIME NOT NULL,
  `enabled` BIT NOT NULL,
  `iconURL` VARCHAR(800) NOT NULL,
  `idRecurrenceTypes` INT NOT NULL,
  PRIMARY KEY (`idPlans`),
  INDEX `fk_Plans_RecurrenceTypes1_idx` (`idRecurrenceTypes` ASC) VISIBLE,
  CONSTRAINT `fk_Plans_RecurrenceTypes1`
    FOREIGN KEY (`idRecurrenceTypes`)
    REFERENCES `Strava`.`RecurrenceTypes` (`idRecurrenceTypes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Strava`.`PlansPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Strava`.`PlansPerUser` (
  `idPlansPerUser` INT NOT NULL,
  `nextTime` DATE NOT NULL,
  `idPerson` BIGINT NOT NULL,
  `idPlans` INT NOT NULL,
  PRIMARY KEY (`idPlansPerUser`),
  INDEX `fk_PlansPerUser_People1_idx` (`idPerson` ASC) VISIBLE,
  INDEX `fk_PlansPerUser_Plans1_idx` (`idPlans` ASC) VISIBLE,
  CONSTRAINT `fk_PlansPerUser_People1`
    FOREIGN KEY (`idPerson`)
    REFERENCES `Strava`.`People` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlansPerUser_Plans1`
    FOREIGN KEY (`idPlans`)
    REFERENCES `Strava`.`Plans` (`idPlans`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
