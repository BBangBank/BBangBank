-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;

SET
    @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS,
    FOREIGN_KEY_CHECKS = 0;

SET
    @OLD_SQL_MODE = @@SQL_MODE,
    SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bbang_bank
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bbang_bank
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bbang_bank` DEFAULT CHARACTER SET utf8;

USE `bbang_bank`;

-- -----------------------------------------------------
-- Table `bbang_bank`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bbang_bank`.`user` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(50) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT now(),
    PRIMARY KEY (`id`),
    UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) VISIBLE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bbang_bank`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bbang_bank`.`account` (
    `account_id` INT NOT NULL,
    `user_id` INT NOT NULL,
    `bank` VARCHAR(25) NOT NULL DEFAULT 'BBang',
    `account_number` VARCHAR(25) NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT now(),
    `is_deleted` TINYINT NOT NULL DEFAULT 0,
    PRIMARY KEY (`account_id`),
    INDEX `userId_fk_idx` (`user_id` ASC) VISIBLE,
    CONSTRAINT `userId_fk` FOREIGN KEY (`user_id`) REFERENCES `bbang_bank`.`user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bbang_bank`.`transaction_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bbang_bank`.`transaction_detail` (
    `detail_number` INT NOT NULL AUTO_INCREMENT,
    `account_id` INT NOT NULL,
    `amount` BIGINT NOT NULL,
    `create_at` DATETIME NOT NULL,
    `target` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`detail_number`),
    INDEX `account_number_fk_idx` (`account_id` ASC) VISIBLE,
    CONSTRAINT `account_number_fk` FOREIGN KEY (`account_id`) REFERENCES `bbang_bank`.`account` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

SET SQL_MODE = @OLD_SQL_MODE;

SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;