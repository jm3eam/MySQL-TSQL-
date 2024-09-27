-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Mortgage_Lending
-- -----------------------------------------------------
-- DB for the purpose of track and service mortgage loan customers

-- -----------------------------------------------------
-- Schema Mortgage_Lending
--
-- DB for the purpose of track and service mortgage loan customers
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Mortgage_Lending` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `Mortgage_Lending` ;

-- -----------------------------------------------------
-- Table `Mortgage_Lending`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mortgage_Lending`.`Customers` (
  `Customer_ID` MEDIUMINT(10) NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NOT NULL,
  `Middle_Name` VARCHAR(45) NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(2) NOT NULL,
  `ZipCode` VARCHAR(10) NOT NULL,
  `Phone` VARCHAR(12) NOT NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`Customer_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mortgage_Lending`.`Loan_Officers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mortgage_Lending`.`Loan_Officers` (
  `Employee_ID` MEDIUMINT(10) NOT NULL,
  `Emp_FName` VARCHAR(45) NOT NULL,
  `Emp_MName` VARCHAR(45) NULL,
  `Emp_LName` VARCHAR(45) NOT NULL,
  `Emp_Phone` VARCHAR(12) NOT NULL,
  `Emp_Email` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Employee_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mortgage_Lending`.`Banking_Branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mortgage_Lending`.`Banking_Branch` (
  `Branch_ID` INT NOT NULL,
  `Branch_Name` VARCHAR(45) NOT NULL,
  `Branch_Level` TINYINT(1) NOT NULL,
  `Branch_District` VARCHAR(25) NOT NULL,
  `Branch_Region` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Branch_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mortgage_Lending`.`Loan_Applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mortgage_Lending`.`Loan_Applications` (
  `Loan_ID` INT NOT NULL AUTO_INCREMENT,
  `Loan_Amount` DECIMAL(10) NOT NULL,
  `Loan_Approved` VARCHAR(1) NOT NULL,
  `Loan_Term` INT NOT NULL,
  `Loan_Type` VARCHAR(15) NOT NULL,
  `Loan_Rate` DECIMAL(7,3) NOT NULL,
  `Application_Date` DATE NOT NULL,
  `Customer_ID` MEDIUMINT(10) NOT NULL,
  `Branch_ID` INT NOT NULL,
  `Employee_ID` MEDIUMINT(10) NOT NULL,
  PRIMARY KEY (`Loan_ID`),
  INDEX `fk_loans_customers_idx` (`Customer_ID` ASC) VISIBLE,
  INDEX `fk_loans_branch_idx` (`Branch_ID` ASC) VISIBLE,
  INDEX `fk_Loans_Loan_Officers1_idx` (`Employee_ID` ASC) VISIBLE,
  CONSTRAINT `fk_loans_customers`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `Mortgage_Lending`.`Customers` (`Customer_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_loans_branch`
    FOREIGN KEY (`Branch_ID`)
    REFERENCES `Mortgage_Lending`.`Banking_Branch` (`Branch_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Loans_Loan_Officers1`
    FOREIGN KEY (`Employee_ID`)
    REFERENCES `Mortgage_Lending`.`Loan_Officers` (`Employee_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
