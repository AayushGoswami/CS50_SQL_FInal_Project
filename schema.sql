-- Create the required database named `blood_donors_org`
CREATE DATABASE `blood_donors_org`;

-- Use the database
USE `blood_donors_org`;


-- Create the Blood Group table
CREATE TABLE `blood_groups` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `type` ENUM('O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-') UNIQUE NOT NULL
);

-- Create the Locations table
CREATE TABLE `locations` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `city` VARCHAR(50) NOT NULL,
    `state` VARCHAR(50) NOT NULL,
    `pincode` CHAR(6) NOT NULL
);

-- Create the Donors table
CREATE TABLE `donors` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    `DOB` DATE NOT NULL,
    `gender` ENUM('Male', 'Female', 'Other') NOT NULL,
    `blood_type` INT NOT NULL,
    `phone` VARCHAR(12) NOT NULL,
    `email` VARCHAR(100),
    `location` INT NOT NULL,
    FOREIGN KEY (`blood_type`) REFERENCES `blood_groups`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`location`) REFERENCES `locations`(`id`) ON DELETE CASCADE
);

-- Create Blood Bank table
CREATE TABLE `blood_banks` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(128) NOT NULL,
    `location`INT NOT NULL,
    `phone` VARCHAR(12) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `blood_type` INT NOT NULL,
    `availability` ENUM('Available', 'Unavailable') NOT NULL,
    `available_volume_in_mL` INT DEFAULT 0,
    FOREIGN KEY (`location`) REFERENCES `locations`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`blood_type`) REFERENCES `blood_groups`(`id`) ON DELETE CASCADE
);

-- Create Donations table
CREATE TABLE `donations` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `date_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `donor_id` INT NOT NULL,
    `blood_bank_blood_type_pair_id` INT NOT NULL,
    `blood_volume_in_mL` INT NOT NULL,
     FOREIGN KEY (`donor_id`) REFERENCES `donors`(`id`) ON DELETE CASCADE,
     FOREIGN KEY (`blood_bank_blood_type_pair_id`) REFERENCES `blood_banks`(`id`) ON DELETE CASCADE
);

-- Create View for Donor Details
CREATE VIEW `donor_details` AS
SELECT
    `d`.`id` AS `donor_id`,
    `d`.`first_name`,
    `d`.`last_name`,
    `d`.`DOB`,
    `d`.`gender`,
    `bg`.`type` AS `blood_type`,
    `d`.`phone`,
    `d`.`email`,
    `l`.`city`,
    `l`.`state`,
    `l`.`pincode`
FROM
    `donors` `d`
JOIN
    `blood_groups` `bg` ON `d`.`blood_type` = `bg`.`id`
JOIN
    `locations` `l` ON `d`.`location` = `l`.`id`;

-- Create View for Blood Bank Inventory
CREATE VIEW `blood_bank_inventory` AS
SELECT
    `bb`.`id` AS `blood_bank_blood_type_pair_id`,
    `bb`.`name` AS `blood_bank_name`,
    `l`.`city`,
    `l`.`state`,
    `l`.`pincode`,
    `bb`.`phone`,
    `bb`.`email`,
    `bg`.`type` AS `blood_type`,
    `bb`.`availability`,
    `bb`.`available_volume_in_mL`
FROM
    `blood_banks` `bb`
JOIN
    `locations` `l` ON `bb`.`location` = `l`.`id`
JOIN
    `blood_groups` `bg` ON `bb`.`blood_type` = `bg`.`id`;

-- Create View for Donations Details
CREATE VIEW `donations_details` AS
SELECT
    `dn`.`id` AS `donation_id`,
    `dn`.`date_time`,
    `d`.`first_name` AS `donor_first_name`,
    `d`.`last_name` AS `donor_last_name`,
    `bg`.`type` AS `blood_type`,
    `bb`.`name` AS `blood_bank_name`,
    `bb`.`phone` AS `blood_bank_phone`,
    `bb`.`email` AS `blood_bank_email`,
    `bb`.`available_volume_in_mL`
FROM
    `donations` `dn`
JOIN
    `donors` `d` ON `dn`.`donor_id` = `d`.`id`
JOIN
    `blood_groups` `bg` ON `d`.`blood_type` = `bg`.`id`
JOIN
    `blood_banks` `bb` ON `dn`.`blood_bank_blood_type_pair_id` = `bb`.`id`;

-- Create View for Available Blood
CREATE VIEW `available_blood` AS
SELECT
    `bg`.`type` AS `blood_type`,
    SUM(`bb`.`available_volume_in_mL`) AS `total_volume_in_mL`
FROM
    `blood_banks` `bb`
JOIN
    `blood_groups` `bg` ON `bb`.`blood_type` = `bg`.`id`
WHERE
    `bb`.`availability` = 'Available'
GROUP BY
    `bg`.`type`;


-- Create index for the blood_groups table
CREATE INDEX `idx_blood_type` ON `blood_groups` (`type`);

-- Create index for the locations table
CREATE INDEX `idx_location` ON `locations` (`city`, `state`, `pincode`);

-- Create index for the donors table
CREATE INDEX `idx_donor_blood_location` ON `donors` (`blood_type`, `location`);

-- Create index for the blood_banks table
CREATE INDEX `idx_blood_bank_location_blood` ON `blood_banks` (`name`,`location`, `blood_type`);

-- Create index for the donations table
CREATE INDEX `idx_donations_donor_blood_bank` ON `donations` (`donor_id`, `blood_bank_blood_type_pair_id`);


-- Create trigger that updates the blood_banks table on data insertion on the donations table

DELIMITER //

CREATE TRIGGER `after_donation_insert`
AFTER INSERT ON `donations`
FOR EACH ROW
BEGIN
    UPDATE `blood_banks`
    SET `available_volume_in_mL` = `available_volume_in_mL` + NEW.`blood_volume_in_mL`,
        `availability` = 'Available'
    WHERE `id` = NEW.`blood_bank_blood_type_pair_id`;
END //

DELIMITER ;



-- Create a new user "public"
CREATE USER 'public'@'172.17.0.1';

-- Grant access to the views of the table to the user 'public'

GRANT SELECT ON `blood_donors_org`.`donor_details` TO 'public'@'172.17.0.1';
GRANT SELECT ON `blood_donors_org`.`blood_bank_inventory` TO 'public'@'172.17.0.1';
GRANT SELECT ON `blood_donors_org`.`donations_details` TO 'public'@'172.17.0.1';
GRANT SELECT ON `blood_donors_org`.`available_blood` TO 'public'@'172.17.0.1';

