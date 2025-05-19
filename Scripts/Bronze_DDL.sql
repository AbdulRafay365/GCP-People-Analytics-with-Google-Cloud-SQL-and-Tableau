-- Table: Staff
DROP TABLE IF EXISTS bronze.staff;
CREATE TABLE bronze.staff (
	Employee_Name VARCHAR(50),
	Gender VARCHAR(10),
	Department VARCHAR(100), 
	Branch VARCHAR(100), 
	Date_of_Joining DATE, 
	Designation VARCHAR(100)
);

-- Table: Attrition
DROP TABLE IF EXISTS bronze.attrition;
CREATE TABLE bronze.attrition (
	Employee_Name VARCHAR(50),
	Gender VARCHAR(10),
	Department VARCHAR(100), 
	Branch VARCHAR(100), 
	Date_of_Leaving DATE, 
	Designation VARCHAR(100)
);

-- Bulk Load 

-- a) Staff
TRUNCATE bronze.staff;
COPY bronze.staff
FROM 'C:\Program Files\PostgreSQL\17\Project Data\Source_Staff.csv'
	DELIMITER ',' 
	CSV HEADER;

-- b) Attrition
TRUNCATE bronze.attrition;
COPY bronze.staff
FROM 'C:\Program Files\PostgreSQL\17\Project Data\Source_Attrition.csv'
	DELIMITER ',' 
	CSV HEADER;

