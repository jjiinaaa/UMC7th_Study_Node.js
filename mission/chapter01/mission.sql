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
-- Table `mydb`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`area` (
  `id` BIGINT UNSIGNED NOT NULL,
  `areaName` VARCHAR(45) NULL,
  `areaAddress` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shop` (
  `id` BIGINT UNSIGNED NOT NULL,
  `area_id` BIGINT UNSIGNED NOT NULL,
  `shopName` VARCHAR(255) NOT NULL,
  `rating` DOUBLE NOT NULL DEFAULT 0.0,
  `review_id` BIGINT UNSIGNED NOT NULL,
  `prefer_food_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `area_id_idx1` (`area_id` ASC) VISIBLE,
  UNIQUE INDEX `review_id_UNIQUE` (`review_id` ASC) VISIBLE,
  UNIQUE INDEX `prefer_food_id_UNIQUE` (`prefer_food_id` ASC) VISIBLE,
  CONSTRAINT `area_id`
    FOREIGN KEY (`area_id`)
    REFERENCES `mydb`.`area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mission` (
  `id` BIGINT UNSIGNED NOT NULL,
  `area_id` BIGINT UNSIGNED NOT NULL,
  `shop_id` BIGINT UNSIGNED NOT NULL,
  `point` INT NOT NULL DEFAULT 0,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `area_id_idx` (`area_id` ASC) VISIBLE,
  INDEX `shop_id_idx` (`shop_id` ASC) VISIBLE,
  CONSTRAINT `area_id`
    FOREIGN KEY (`area_id`)
    REFERENCES `mydb`.`area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `shop_id`
    FOREIGN KEY (`shop_id`)
    REFERENCES `mydb`.`shop` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_mission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_mission` (
  `id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `mission_id` BIGINT UNSIGNED NOT NULL,
  `area_id` BIGINT UNSIGNED NOT NULL,
  `area_mission_id` BIGINT UNSIGNED NOT NULL,
  `status` BIGINT NOT NULL DEFAULT 0,
  `missionPoint` INT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `status_UNIQUE` (`status` ASC) VISIBLE,
  UNIQUE INDEX `area_id_UNIQUE` (`area_id` ASC) VISIBLE,
  INDEX `mission_id_idx` (`mission_id` ASC, `area_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `area_id_UNIQUE` (`area_mission_id` ASC) VISIBLE,
  CONSTRAINT `id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `mission_id`
    FOREIGN KEY (`mission_id` , `area_id`)
    REFERENCES `mydb`.`mission` (`id` , `area_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `area_mission_id`
    FOREIGN KEY (`area_mission_id`)
    REFERENCES `mydb`.`area_mission` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`area_mission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`area_mission` (
  `id` BIGINT UNSIGNED NULL,
  `user_mission_id` BIGINT UNSIGNED NOT NULL,
  `area_id` BIGINT UNSIGNED NOT NULL,
  `point` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `user_mission_count` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  UNIQUE INDEX `area_id_UNIQUE` (`user_mission_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `point_UNIQUE` (`point` ASC) VISIBLE,
  UNIQUE INDEX `user_mission_count_UNIQUE` (`user_mission_count` ASC) VISIBLE,
  UNIQUE INDEX `area_id_UNIQUE` (`area_id` ASC) VISIBLE,
  CONSTRAINT `area_id`
    FOREIGN KEY (`area_id`)
    REFERENCES `mydb`.`user_mission` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` BIGINT UNSIGNED NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `birthData` DATE NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `prefer_food_id` BIGINT UNSIGNED NOT NULL,
  `point` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `user_mission_count` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `area_mission_id` BIGINT UNSIGNED NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `point_UNIQUE` (`point` ASC) VISIBLE,
  UNIQUE INDEX `user_mission_count_UNIQUE` (`user_mission_count` ASC) VISIBLE,
  UNIQUE INDEX `area_mission_id_UNIQUE` (`area_mission_id` ASC) VISIBLE,
  INDEX `count_idx` (`area_mission_id` ASC, `user_mission_count` ASC, `point` ASC) VISIBLE,
  CONSTRAINT `count`
    FOREIGN KEY (`area_mission_id` , `user_mission_count` , `point`)
    REFERENCES `mydb`.`area_mission` (`user_mission_id` , `user_mission_count` , `point`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prefer_food`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prefer_food` (
  `id` BIGINT UNSIGNED NULL,
  `foodName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `food_name_UNIQUE` (`foodName` ASC) VISIBLE,
  CONSTRAINT `prefer_food_id`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`user` (`prefer_food_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `prefer_food_id2`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`shop` (`prefer_food_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`review` (
  `id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rating` DOUBLE NOT NULL DEFAULT 0.0,
  `user_mission_status` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `user_mission_status_UNIQUE` (`user_mission_status` ASC) VISIBLE,
  CONSTRAINT `revie_id`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`shop` (`review_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_mission_status`
    FOREIGN KEY (`user_mission_status`)
    REFERENCES `mydb`.`user_mission` (`status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table2` (
)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
