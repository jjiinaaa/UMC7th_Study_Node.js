-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema umc7th_week1_mission
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` BIGINT UNSIGNED NOT NULL,
  `user_id` VARCHAR(255) NOT NULL,
  `user_password` VARCHAR(255) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `birth_data` DATE NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `prefer_food_id` BIGINT UNSIGNED NOT NULL,
  `my_point` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`area` (
  `area_id` BIGINT UNSIGNED NOT NULL,
  `area_name` VARCHAR(45) NULL,
  `area_address` VARCHAR(45) NULL,
  PRIMARY KEY (`area_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shop` (
  `shop_id` BIGINT UNSIGNED NOT NULL,
  `area_id` BIGINT UNSIGNED NOT NULL,
  `shop_name` VARCHAR(255) NOT NULL,
  `review_id` BIGINT UNSIGNED NOT NULL,
  `prefer_food_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`shop_id`),
  INDEX `area_id_idx1` (`area_id` ASC) VISIBLE,
  UNIQUE INDEX `review_id_UNIQUE` (`review_id` ASC) VISIBLE,
  UNIQUE INDEX `prefer_food_id_UNIQUE` (`prefer_food_id` ASC) VISIBLE,
  CONSTRAINT `area_id`
    FOREIGN KEY (`area_id`)
    REFERENCES `mydb`.`area` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mission` (
  `mission_id` BIGINT UNSIGNED NOT NULL,
  `area_id` BIGINT UNSIGNED NOT NULL,
  `shop_id` BIGINT UNSIGNED NOT NULL,
  `point` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mission_id`),
  INDEX `area_id_idx` (`area_id` ASC) VISIBLE,
  INDEX `shop_id_idx` (`shop_id` ASC) VISIBLE,
  CONSTRAINT `area_id`
    FOREIGN KEY (`area_id`)
    REFERENCES `mydb`.`area` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `shop_id`
    FOREIGN KEY (`shop_id`)
    REFERENCES `mydb`.`shop` (`shop_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_mission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_mission` (
  `id` BIGINT UNSIGNED NOT NULL,
  `mission_id` BIGINT UNSIGNED NOT NULL,
  `status` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `mission_id`),
  CONSTRAINT `id`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `mission_id`
    FOREIGN KEY (`mission_id`)
    REFERENCES `mydb`.`mission` (`mission_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prefer_food`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prefer_food` (
  `prefer_food_id` BIGINT UNSIGNED NULL,
  `food_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`prefer_food_id`),
  UNIQUE INDEX `food_name_UNIQUE` (`food_name` ASC) VISIBLE,
  CONSTRAINT `prefer_food_id`
    FOREIGN KEY (`prefer_food_id`)
    REFERENCES `mydb`.`user` (`prefer_food_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `prefer_food_id2`
    FOREIGN KEY (`prefer_food_id`)
    REFERENCES `mydb`.`shop` (`prefer_food_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`review` (
  `review_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rating` DOUBLE NOT NULL DEFAULT 0.0,
  PRIMARY KEY (`review_id`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `revie_id`
    FOREIGN KEY (`review_id`)
    REFERENCES `mydb`.`shop` (`review_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
