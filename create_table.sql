CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`clients` (
  `client_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `address` VARCHAR(100) NULL,
  `postal_code` INT NULL,
  `locality` VARCHAR(45) NULL,
  `province` VARCHAR(45) NULL,
  `phone_number` INT NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`products` (
  `product_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(200) NULL,
  `image` BLOB NULL,
  `price` DECIMAL(9,2) NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`delivery_type` (
  `delivery_type_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`delivery_type_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`store` (
  `store_id` INT NOT NULL,
  `address` VARCHAR(100) NULL,
  `postal_code` INT NULL,
  `province` VARCHAR(45) NULL,
  PRIMARY KEY (`store_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`employees` (
  `employee_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `phone_number` INT NULL,
  `nif` VARCHAR(45) NULL,
  `working_in` INT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `working_in_idx` (`working_in` ASC) VISIBLE,
  CONSTRAINT `working_in`
    FOREIGN KEY (`working_in`)
    REFERENCES `pizzeria`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`commands` (
  `command_id` INT NOT NULL,
  `date_time` DATETIME NULL,
  `delivery_type` INT NULL,
  `product_item` INT NULL,
  `product_quantity` INT NULL,
  `total_price` DECIMAL(9,2) NULL,
  `store_name` INT NULL,
  `commandscol` VARCHAR(45) NULL,
  `cooked_by` INT NULL,
  `delivered_by` INT NULL,
  PRIMARY KEY (`command_id`),
  INDEX `delivery_type_idx` (`delivery_type` ASC) VISIBLE,
  INDEX `product_type_idx` (`product_item` ASC) VISIBLE,
  INDEX `store_name_idx` (`store_name` ASC) VISIBLE,
  INDEX `cooked_by_idx` (`cooked_by` ASC) VISIBLE,
  INDEX `delivered_by_idx` (`delivered_by` ASC) VISIBLE,
  CONSTRAINT `delivery_type`
    FOREIGN KEY (`delivery_type`)
    REFERENCES `pizzeria`.`delivery_type` (`delivery_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_type`
    FOREIGN KEY (`product_item`)
    REFERENCES `pizzeria`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `store_name`
    FOREIGN KEY (`store_name`)
    REFERENCES `pizzeria`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cooked_by`
    FOREIGN KEY (`cooked_by`)
    REFERENCES `pizzeria`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `delivered_by`
    FOREIGN KEY (`delivered_by`)
    REFERENCES `pizzeria`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;