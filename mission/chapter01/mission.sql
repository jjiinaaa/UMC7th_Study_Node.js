-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema umc7th_week1_mission
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema umc7th_week1_mission
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `umc7th_week1_mission` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `umc7th_week1_mission` ;

-- -----------------------------------------------------
-- Table `umc7th_week1_mission`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umc7th_week1_mission`.`area` (
  `id` BIGINT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `umc7th_week1_mission`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umc7th_week1_mission`.`shop` (
  `id` BIGINT UNSIGNED NOT NULL,
  `area_id` BIGINT UNSIGNED NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `rating` DOUBLE NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `fk_area_id_idx` (`area_id` ASC) VISIBLE,
  CONSTRAINT `fk_area_id`
    FOREIGN KEY (`area_id`)
    REFERENCES `umc7th_week1_mission`.`area` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `umc7th_week1_mission`.`mission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umc7th_week1_mission`.`mission` (
  `id` BIGINT UNSIGNED NOT NULL,
  `shop_id` BIGINT UNSIGNED NOT NULL,
  `point` INT NOT NULL DEFAULT '0',
  `deadline` DATETIME NULL DEFAULT NULL,
  `missionText` TEXT NULL DEFAULT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `shop_id_UNIQUE` (`shop_id` ASC) VISIBLE,
  CONSTRAINT `fk_shop_idx2`
    FOREIGN KEY (`shop_id`)
    REFERENCES `umc7th_week1_mission`.`shop` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `umc7th_week1_mission`.`prefer_food`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umc7th_week1_mission`.`prefer_food` (
  `id` BIGINT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `umc7th_week1_mission`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umc7th_week1_mission`.`user` (
  `id` BIGINT UNSIGNED NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `birthData` DATE NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `point` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `point_UNIQUE` (`point` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `umc7th_week1_mission`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umc7th_week1_mission`.`review` (
  `id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `shop_id` BIGINT UNSIGNED NOT NULL,
  `content` TEXT NULL DEFAULT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rating` DOUBLE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `shop_id_UNIQUE` (`shop_id` ASC) VISIBLE,
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_shop_idx1`
    FOREIGN KEY (`shop_id`)
    REFERENCES `umc7th_week1_mission`.`shop` (`id`),
  CONSTRAINT `fk_user_idx3`
    FOREIGN KEY (`user_id`)
    REFERENCES `umc7th_week1_mission`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `umc7th_week1_mission`.`user_mission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umc7th_week1_mission`.`user_mission` (
  `id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `mission_id` BIGINT UNSIGNED NOT NULL,
  `status` VARCHAR(15) NOT NULL,
  `createdAt` DATETIME(6) NOT NULL,
  `updatedAt` DATETIME(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `mission_id_UNIQUE` (`mission_id` ASC) VISIBLE,
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_mission_id`
    FOREIGN KEY (`mission_id`)
    REFERENCES `umc7th_week1_mission`.`mission` (`id`),
  CONSTRAINT `fk_user_idx1`
    FOREIGN KEY (`user_id`)
    REFERENCES `umc7th_week1_mission`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `umc7th_week1_mission`.`user_prefer_food`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `umc7th_week1_mission`.`user_prefer_food` (
  `id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `prefer_food_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `prefer_food_id_UNIQUE` (`prefer_food_id` ASC) VISIBLE,
  CONSTRAINT `fk_prefer_food_id`
    FOREIGN KEY (`prefer_food_id`)
    REFERENCES `umc7th_week1_mission`.`prefer_food` (`id`),
  CONSTRAINT `fk_user_idx2`
    FOREIGN KEY (`user_id`)
    REFERENCES `umc7th_week1_mission`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
