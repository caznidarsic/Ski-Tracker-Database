SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SKI_TRACKER_3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SKI_TRACKER_3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SKI_TRACKER_3` DEFAULT CHARACTER SET utf8 ;
USE `SKI_TRACKER_3` ;

-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`SKIER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`SKIER` (
  `Skier_Id` INT NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Password` BINARY(45) NOT NULL,
  PRIMARY KEY (`Skier_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`STATE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`STATE` (
  `State_Id` VARCHAR(2) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`State_Id`, `Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`CITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`CITY` (
  `City_Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `STATE_State_Id` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`City_Id`),
  INDEX `fk_CITY_STATE1_idx` (`STATE_State_Id` ASC) VISIBLE,
  CONSTRAINT `fk_CITY_STATE1`
    FOREIGN KEY (`STATE_State_Id`)
    REFERENCES `SKI_TRACKER_3`.`STATE` (`State_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`RESORT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`RESORT` (
  `Resort_Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `CITY_City_Id` INT NULL,
  PRIMARY KEY (`Resort_Id`),
  INDEX `fk_RESORT_CITY1_idx` (`CITY_City_Id` ASC) VISIBLE,
  CONSTRAINT `fk_RESORT_CITY1`
    FOREIGN KEY (`CITY_City_Id`)
    REFERENCES `SKI_TRACKER_3`.`CITY` (`City_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`TRAIL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`TRAIL` (
  `Trail_Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Rating` VARCHAR(45) NOT NULL,
  `Length` FLOAT(4,1) NOT NULL,
  `RESORT_Resort_Id` INT NOT NULL,
  PRIMARY KEY (`Trail_Id`),
  INDEX `fk_TRAIL_RESORT1_idx` (`RESORT_Resort_Id` ASC) VISIBLE,
  CONSTRAINT `fk_TRAIL_RESORT1`
    FOREIGN KEY (`RESORT_Resort_Id`)
    REFERENCES `SKI_TRACKER_3`.`RESORT` (`Resort_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`SKI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`SKI` (
  `Ski_Id` INT NOT NULL AUTO_INCREMENT,
  `Date_Time` DATETIME NOT NULL,
  `SKIER_Skier_Id` INT NOT NULL,
  `TRAIL_Trail_Id` INT NOT NULL,
  INDEX `fk_SKI_SKIER1_idx` (`SKIER_Skier_Id` ASC) VISIBLE,
  INDEX `fk_SKI_TRAIL1_idx` (`TRAIL_Trail_Id` ASC) VISIBLE,
  PRIMARY KEY (`Ski_Id`),
  CONSTRAINT `fk_SKI_SKIER1`
    FOREIGN KEY (`SKIER_Skier_Id`)
    REFERENCES `SKI_TRACKER_3`.`SKIER` (`Skier_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SKI_TRAIL1`
    FOREIGN KEY (`TRAIL_Trail_Id`)
    REFERENCES `SKI_TRACKER_3`.`TRAIL` (`Trail_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`SEASON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`SEASON` (
  `Season_Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Start_Date` DATE NOT NULL,
  `End_Date` DATE NOT NULL,
  `RESORT_Resort_Id` INT NOT NULL,
  PRIMARY KEY (`Season_Id`),
  INDEX `fk_SEASON_RESORT1_idx` (`RESORT_Resort_Id` ASC) VISIBLE,
  CONSTRAINT `fk_SEASON_RESORT1`
    FOREIGN KEY (`RESORT_Resort_Id`)
    REFERENCES `SKI_TRACKER_3`.`RESORT` (`Resort_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`AWARD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`AWARD` (
  `Award_Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `Number_Needed` INT NULL,
  `RESORT_Resort_Id` INT NOT NULL,
  PRIMARY KEY (`Award_Id`),
  INDEX `fk_AWARD_RESORT1_idx` (`RESORT_Resort_Id` ASC) VISIBLE,
  CONSTRAINT `fk_AWARD_RESORT1`
    FOREIGN KEY (`RESORT_Resort_Id`)
    REFERENCES `SKI_TRACKER_3`.`RESORT` (`Resort_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`EARN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`EARN` (
  `Earn_Id` INT NOT NULL AUTO_INCREMENT,
  `Progress` INT NULL,
  `Earned` TINYINT NOT NULL,
  `Date_Earned` DATE NULL,
  `SKIER_Skier_Id` INT NOT NULL,
  `AWARD_Award_Id` INT NOT NULL,
  INDEX `fk_EARN_SKIER1_idx` (`SKIER_Skier_Id` ASC) VISIBLE,
  INDEX `fk_EARN_AWARD1_idx` (`AWARD_Award_Id` ASC) VISIBLE,
  PRIMARY KEY (`Earn_Id`),
  CONSTRAINT `fk_EARN_SKIER1`
    FOREIGN KEY (`SKIER_Skier_Id`)
    REFERENCES `SKI_TRACKER_3`.`SKIER` (`Skier_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EARN_AWARD1`
    FOREIGN KEY (`AWARD_Award_Id`)
    REFERENCES `SKI_TRACKER_3`.`AWARD` (`Award_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`CHAIR_STATUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`CHAIR_STATUS` (
  `Status_Id` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Status_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`CHAIRLIFT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`CHAIRLIFT` (
  `Chairlift_Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `CHAIR_STATUS_Status_Id` INT NOT NULL,
  `RESORT_Resort_Id` INT NOT NULL,
  PRIMARY KEY (`Chairlift_Id`),
  INDEX `fk_CHAIRLIFT_CHAIR_STATUS1_idx` (`CHAIR_STATUS_Status_Id` ASC) VISIBLE,
  INDEX `fk_CHAIRLIFT_RESORT1_idx` (`RESORT_Resort_Id` ASC) VISIBLE,
  CONSTRAINT `fk_CHAIRLIFT_CHAIR_STATUS1`
    FOREIGN KEY (`CHAIR_STATUS_Status_Id`)
    REFERENCES `SKI_TRACKER_3`.`CHAIR_STATUS` (`Status_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CHAIRLIFT_RESORT1`
    FOREIGN KEY (`RESORT_Resort_Id`)
    REFERENCES `SKI_TRACKER_3`.`RESORT` (`Resort_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SKI_TRACKER_3`.`RIDE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKI_TRACKER_3`.`RIDE` (
  `Ride_Id` INT NOT NULL AUTO_INCREMENT,
  `Date_Time` DATETIME NOT NULL,
  `SKIER_Skier_Id` INT NOT NULL,
  `CHAIRLIFT_Chairlift_id` INT NOT NULL,
  INDEX `fk_RIDE_SKIER1_idx` (`SKIER_Skier_Id` ASC) VISIBLE,
  INDEX `fk_RIDE_CHAIRLIFT1_idx` (`CHAIRLIFT_Chairlift_id` ASC) VISIBLE,
  PRIMARY KEY (`Ride_Id`),
  CONSTRAINT `fk_RIDE_SKIER1`
    FOREIGN KEY (`SKIER_Skier_Id`)
    REFERENCES `SKI_TRACKER_3`.`SKIER` (`Skier_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RIDE_CHAIRLIFT1`
    FOREIGN KEY (`CHAIRLIFT_Chairlift_id`)
    REFERENCES `SKI_TRACKER_3`.`CHAIRLIFT` (`Chairlift_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
