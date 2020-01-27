-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`cruise_ships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cruise_ships` (
  `id_ships` INT NOT NULL AUTO_INCREMENT,
  `ship_name` VARCHAR(45) NOT NULL,
  `ship_capacity` VARCHAR(45) NULL,
  `ship_maintenance_cost` DECIMAL(7,2) NULL,
  PRIMARY KEY (`id_ships`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cruise_tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cruise_tickets` (
  `id_tickets` INT NOT NULL AUTO_INCREMENT,
  `purchase_date` DATE NOT NULL,
  `departure_date` DATE NULL,
  `arrival_date` DATE NULL,
  `ticket_price` DECIMAL(7,2) NULL,
  PRIMARY KEY (`id_tickets`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cruise_passengers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cruise_passengers` (
  `id_passengers` INT NOT NULL AUTO_INCREMENT,
  `passenger_name` VARCHAR(45) NOT NULL,
  `passenger_age` INT NULL,
  `passenger_gender` VARCHAR(45) NULL,
  `passenger_country` VARCHAR(45) NULL,
  PRIMARY KEY (`id_passengers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cruise_amenities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cruise_amenities` (
  `id_amenities` INT NOT NULL AUTO_INCREMENT,
  `amenities_name` VARCHAR(45) NULL,
  `amenities_type` VARCHAR(45) NULL,
  `amenities_price` DECIMAL(7,2) NULL,
  PRIMARY KEY (`id_amenities`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cruise_routes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cruise_routes` (
  `id_routes` INT NOT NULL AUTO_INCREMENT,
  `route_origin` VARCHAR(45) NULL,
  `route_destination` VARCHAR(45) NULL,
  `route_cost` INT NULL,
  PRIMARY KEY (`id_routes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cruise_crew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cruise_crew` (
  `id_crew` INT NOT NULL AUTO_INCREMENT,
  `crew_name` VARCHAR(45) NOT NULL,
  `crew_age` INT NULL,
  `crew_title` VARCHAR(45) NULL,
  `crew_salary` DECIMAL(7,2) NULL,
  PRIMARY KEY (`id_crew`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cruise_accomodation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cruise_accomodation` (
  `id_accomodation` INT NOT NULL AUTO_INCREMENT,
  `room_capacity` INT NULL,
  `room_type` VARCHAR(45) NULL,
  PRIMARY KEY (`id_accomodation`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cruise_supply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cruise_supply` (
  `id_supply` INT NOT NULL AUTO_INCREMENT,
  `supply_family` VARCHAR(45) NULL,
  `supply_name` VARCHAR(45) NULL,
  `supply_tonnes` INT NULL,
  `supply_cost` DECIMAL(7,2) NULL,
  PRIMARY KEY (`id_supply`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`luxury_cruise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`luxury_cruise` (
  `id_Luxury_Cruise` INT NOT NULL AUTO_INCREMENT,
  `id_ships` INT NULL,
  `id_tickets` INT NULL,
  `id_passengers` INT NULL,
  `id_amenities` INT NULL,
  `id_routes` INT NULL,
  `id_crew` INT NULL,
  `id_accomodation` INT NULL,
  `id_supply` INT NULL,
  PRIMARY KEY (`id_Luxury_Cruise`),
  INDEX `id_ships_idx` (`id_ships` ASC) VISIBLE,
  INDEX `id_tickets_idx` (`id_tickets` ASC) VISIBLE,
  INDEX `id_passengers_idx` (`id_passengers` ASC) VISIBLE,
  INDEX `id_amenities_idx` (`id_amenities` ASC) VISIBLE,
  INDEX `id_routes_idx` (`id_routes` ASC) VISIBLE,
  INDEX `id_crew_idx` (`id_crew` ASC) VISIBLE,
  INDEX `id_accomodation_idx` (`id_accomodation` ASC) VISIBLE,
  INDEX `id_supply_idx` (`id_supply` ASC) VISIBLE,
  CONSTRAINT `id_ships`
    FOREIGN KEY (`id_ships`)
    REFERENCES `mydb`.`cruise_ships` (`id_ships`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_tickets`
    FOREIGN KEY (`id_tickets`)
    REFERENCES `mydb`.`cruise_tickets` (`id_tickets`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_passengers`
    FOREIGN KEY (`id_passengers`)
    REFERENCES `mydb`.`cruise_passengers` (`id_passengers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_amenities`
    FOREIGN KEY (`id_amenities`)
    REFERENCES `mydb`.`cruise_amenities` (`id_amenities`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_routes`
    FOREIGN KEY (`id_routes`)
    REFERENCES `mydb`.`cruise_routes` (`id_routes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_crew`
    FOREIGN KEY (`id_crew`)
    REFERENCES `mydb`.`cruise_crew` (`id_crew`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_accomodation`
    FOREIGN KEY (`id_accomodation`)
    REFERENCES `mydb`.`cruise_accomodation` (`id_accomodation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_supply`
    FOREIGN KEY (`id_supply`)
    REFERENCES `mydb`.`cruise_supply` (`id_supply`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `mydb`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`view1`;
USE `mydb`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
