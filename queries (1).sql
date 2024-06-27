-- Insert sample data into blood_groups table
INSERT INTO `blood_groups` (`type`) VALUES
('O+'),
('O-'),
('A+'),
('A-'),
('B+'),
('B-'),
('AB+'),
('AB-')
;

-- Insert sample data into locations table
INSERT INTO `locations` (`city`, `state`, `pincode`) VALUES
('Mumbai', 'Maharashtra', '400001'),
('Delhi', 'Delhi', '110001'),
('Bangalore', 'Karnataka', '560001'),
('Hyderabad', 'Telangana', '500001'),
('Ahmedabad', 'Gujarat', '380001'),
('Chennai', 'Tamil Nadu', '600001'),
('Kolkata', 'West Bengal', '700001'),
('Pune', 'Maharashtra', '411001'),
('Jaipur', 'Rajasthan', '302001'),
('Lucknow', 'Uttar Pradesh', '226001'),
('Chandigarh', 'Punjab', '160001'),
('Patna', 'Bihar', '800001'),
('Bhopal', 'Madhya Pradesh', '462001'),
('Indore', 'Madhya Pradesh', '452001'),
('Gurgaon', 'Haryana', '122001')
;

-- Insert sample data into donors table
INSERT INTO `donors` (`first_name`, `last_name`, `DOB`, `gender`, `blood_type`, `phone`, `email`, `location`) VALUES
('Amit', 'Sharma', '1980-05-15', 'Male', 1, '9123456789', 'amit.sharma@example.com', 1),
('Sunita', 'Patel', '1990-11-25', 'Female', 2, '9123456790', 'sunita.patel@example.com', 2),
('Rajesh', 'Kumar', '1975-02-10', 'Male', 3, '9123456791', 'rajesh.kumar@example.com', 3),
('Anita', 'Singh', '1985-03-30', 'Female', 4, '9123456792', 'anita.singh@example.com', 4),
('Vikram', 'Rao', '1988-07-19', 'Male', 5, '9123456793', 'vikram.rao@example.com', 5),
('Priya', 'Desai', '1992-09-12', 'Female', 6, '9123456794', 'priya.desai@example.com', 6),
('Rohit', 'Verma', '1983-01-22', 'Male', 7, '9123456795', 'rohit.verma@example.com', 7),
('Sneha', 'Gupta', '1995-04-16', 'Female', 8, '9123456796', 'sneha.gupta@example.com', 8),
('Arjun', 'Mehta', '1981-06-14', 'Male', 1, '9123456797', 'arjun.mehta@example.com', 9),
('Kavita', 'Joshi', '1986-08-29', 'Female', 2, '9123456798', 'kavita.joshi@example.com', 10),
('Suresh', 'Reddy', '1978-12-03', 'Male', 3, '9123456799', 'suresh.reddy@example.com', 11),
('Pooja', 'Agarwal', '1993-02-20', 'Female', 4, '9123456800', 'pooja.agarwal@example.com', 12),
('Naveen', 'Saxena', '1984-11-11', 'Male', 5, '9123456801', 'naveen.saxena@example.com', 13),
('Meera', 'Chauhan', '1991-05-24', 'Female', 6, '9123456802', 'meera.chauhan@example.com', 14),
('Rakesh', 'Bhatia', '1989-03-05', 'Male', 7, '9123456803', 'rakesh.bhatia@example.com', 15)
;

-- Insert sample data into blood_banks table
INSERT INTO `blood_banks` (`name`, `location`, `phone`, `email`, `blood_type`, `availability`, `available_volume_in_mL`) VALUES
('Mumbai Blood Bank', 1, '9123456804', 'mumbai.bb@example.com', 1, 'Available', 5000),
('Delhi Blood Bank', 2, '9123456805', 'delhi.bb@example.com', 2, 'Available', 4000),
('Bangalore Blood Bank', 3, '9123456806', 'bangalore.bb@example.com', 3, 'Unavailable', 0),
('Hyderabad Blood Bank', 4, '9123456807', 'hyderabad.bb@example.com', 4, 'Available', 6000),
('Ahmedabad Blood Bank', 5, '9123456808', 'ahmedabad.bb@example.com', 5, 'Available', 3500),
('Chennai Blood Bank', 6, '9123456809', 'chennai.bb@example.com', 6, 'Unavailable', 0),
('Kolkata Blood Bank', 7, '9123456810', 'kolkata.bb@example.com', 7, 'Available', 4500),
('Pune Blood Bank', 8, '9123456811', 'pune.bb@example.com', 8, 'Unavailable', 0),
('Jaipur Blood Bank', 9, '9123456812', 'jaipur.bb@example.com', 1, 'Available', 3200),
('Lucknow Blood Bank', 10, '9123456813', 'lucknow.bb@example.com', 2, 'Available', 2900),
('Chandigarh Blood Bank', 11, '9123456814', 'chandigarh.bb@example.com', 3, 'Unavailable', 0),
('Patna Blood Bank', 12, '9123456815', 'patna.bb@example.com', 4, 'Available', 3700),
('Bhopal Blood Bank', 13, '9123456816', 'bhopal.bb@example.com', 5, 'Unavailable', 0),
('Indore Blood Bank', 14, '9123456817', 'indore.bb@example.com', 6, 'Available', 3100),
('Gurgaon Blood Bank', 15, '9123456818', 'gurgaon.bb@example.com', 7, 'Available', 2800)
;

SELECT * FROM `blood_banks`;

-- Insert sample data into donations table
INSERT INTO `donations` (`donor_id`, `blood_bank_blood_type_pair_id`, `blood_volume_in_mL`) VALUES
(1, 1, 500),
(2, 2, 450),
(3, 3, 500),
(4, 4, 250),
(5, 5, 350),
(6, 6, 330),
(7, 7, 500),
(8, 8, 480),
(9, 9, 420),
(10, 10, 500),
(11, 11, 500),
(12, 12, 480),
(13, 13, 460),
(14, 14, 440),
(15, 15, 390)
;

-- Update data in donors table
UPDATE `donors`
SET `phone` = '9111111111', `email` = 'updated.email@example.com'
WHERE `id` = 1;

-- Update data in blood_banks table
UPDATE `blood_banks`
SET `availability` = 'Unavailable', `available_volume_in_mL` = 0
WHERE `id` = 2;

-- Delete data from donors table
DELETE FROM `donors`
WHERE `id` = 15;

-- Delete data from blood_banks table
DELETE FROM `blood_banks`
WHERE `id` = 15;

-- Frequently performed queries
-- See all the data in all tables
SELECT * FROM `blood_groups`;
SELECT * FROM `locations`;
SELECT * FROM `donors`;
SELECT * FROM `blood_banks`;
SELECT * FROM `donations`;

-- Query 1: Get all donors with a specific blood type
SELECT * FROM `donor_details`
WHERE `blood_type` = 'O+';

-- Query 2: Get the total available volume of each blood type across all blood banks
SELECT * FROM `available_blood`;

-- Query 3: Get all donations made by a specific donor
SELECT * FROM `donations_details`
WHERE `donor_first_name` = 'Amit' AND `donor_last_name` = 'Sharma';

-- Query 4: Get all blood banks in a specific city
SELECT * FROM `blood_bank_inventory`
WHERE `city` = 'Mumbai';

-- Query 5: Get the details of all donations made to a specific blood bank
SELECT * FROM `donations_details`
WHERE `blood_bank_name` = 'Mumbai Blood Bank';
