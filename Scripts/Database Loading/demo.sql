DROP TABLE IF EXISTS fact_employee;
SET DATESTYLE = 'DMY';
CREATE TABLE fact_employee (
	employee_id INT GENERATED ALWAYS AS IDENTITY (START WITH 10101 INCREMENT BY 1) PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	gender VARCHAR(10),
	location_id INT,
	education_id INT,
	birthdate DATE,
	hiredate DATE,
	termdate DATE,
	dept_id INT,
	job_id INT,
	perf_id INT,
	salary FLOAT,
-- Foreign Keys
	FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
	FOREIGN KEY (education_id) REFERENCES dim_education(education_id),
	FOREIGN KEY (dept_id) REFERENCES dim_department(dept_id),
	FOREIGN KEY (job_id) REFERENCES dim_job(job_id),
	FOREIGN KEY (perf_id) REFERENCES dim_performance(perf_id)
);

CREATE TABLE dim_location (
	location_id INT GENERATED ALWAYS AS IDENTITY (START WITH 90909 INCREMENT BY 1) PRIMARY KEY,
	city VARCHAR(50),
	state VARCHAR(50)
);

DROP TABLE IF EXISTS dim_education;
CREATE TABLE dim_education (
	education_id INT GENERATED ALWAYS AS IDENTITY (START WITH 20202 INCREMENT BY 1) PRIMARY KEY,
	education_level VARCHAR(50)
);

DROP TABLE IF EXISTS dim_performance;
CREATE TABLE dim_performance (
	perf_id INT GENERATED ALWAYS AS IDENTITY (START WITH 50505 INCREMENT BY 1) PRIMARY KEY,
	performance_rating VARCHAR(50)
);

DROP TABLE IF EXISTS dim_job;
CREATE TABLE dim_job (
	job_id INT GENERATED ALWAYS AS IDENTITY (START WITH 30303 INCREMENT BY 1) PRIMARY KEY,
	job_title VARCHAR(50)
);

DROP TABLE IF EXISTS dim_department;
CREATE TABLE dim_department (
	dept_id INT GENERATED ALWAYS AS IDENTITY (START WITH 40404 INCREMENT BY 1) PRIMARY KEY,
	department VARCHAR(50)
);



-- Staging Table
DROP TABLE IF EXISTS StagingEmployee;
CREATE TABLE StagingEmployee (
	Employee_ID VARCHAR(20), --TEMP
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Gender VARCHAR(20),
    State VARCHAR(50),
    City VARCHAR(50),
    Education_Level VARCHAR(50),
    Birthdate DATE,
    Hiredate DATE,
    Termdate DATE,
    Department VARCHAR(50),
    Job_Title VARCHAR(100),
    Salary FLOAT,
    Performance_Rating VARCHAR(50)
);


SELECT * FROM fact_employee;

SELECT * FROM StagingEmployee;

-- Loading data as is in staging
TRUNCATE StagingEmployee;
SET datestyle = 'DMY';
COPY StagingEmployee
FROM '/Library/PostgreSQL/17/Datasets/HR Analytics Dashboard/dataset.csv'
DELIMITER ';' 
CSV HEADER
NULL AS '';

-- Inserting Data into DB

-- dim_location

INSERT INTO dim_location (city, state)
SELECT DISTINCT City, State 
FROM StagingEmployee
WHERE (City, State) NOT IN (
    SELECT city, state FROM dim_location
);

SELECT * FROM dim_Location;

-- dim_education

INSERT INTO dim_education (education_level)
SELECT DISTINCT Education_Level
FROM StagingEmployee
WHERE (Education_Level) NOT IN (
	SELECT education_level FROM dim_education
);

SELECT * FROM dim_education;


-- dim_department

INSERT INTO dim_department (department)
SELECT DISTINCT Department
FROM StagingEmployee
WHERE (Department) NOT IN (
	SELECT department FROM dim_department
);

SELECT * FROM dim_department;


-- dim_performance

INSERT INTO dim_performance (performance_rating)
SELECT DISTINCT PerformancE_Rating 
FROM StagingEmployee
WHERE (PerformancE_Rating) NOT IN (
	SELECT performance_rating FROM dim_performance
);

SELECT * FROM dim_performance;

-- dim_job

INSERT INTO dim_Job (job_title)
SELECT DISTINCT Job_Title 
FROM StagingEmployee
WHERE (Job_Title) NOT IN (
	SELECT job_title FROM dim_job
);

SELECT * FROM dim_job;

-- fact_employee
TRUNCATE TABLE fact_employee;
INSERT INTO fact_employee (
    first_name,
    last_name,
    gender,
    location_id,
    education_id,
    birthdate,
    hiredate,
    termdate,
    dept_id,
    job_id,
    perf_id,
    salary
)
SELECT
    s.First_Name,
    s.Last_Name,
    s.Gender,
    l.location_id,
    e.education_id,
    s.Birthdate,
    s.Hiredate,
    s.Termdate,
    d.dept_id,
    j.job_id,
    p.perf_id,
    s.Salary
FROM StagingEmployee s
JOIN dim_location l
    ON LOWER(TRIM(s.City)) = LOWER(TRIM(l.city))
   AND LOWER(TRIM(s.State)) = LOWER(TRIM(l.state))
JOIN dim_education e
    ON LOWER(TRIM(s.Education_Level)) = LOWER(TRIM(e.education_level))
JOIN dim_department d
    ON LOWER(TRIM(s.Department)) = LOWER(TRIM(d.department))
JOIN dim_job j
    ON LOWER(TRIM(s.Job_Title)) = LOWER(TRIM(j.job_title))
JOIN dim_performance p
    ON LOWER(TRIM(s.Performance_Rating)) = LOWER(TRIM(p.performance_rating));

SELECT * FROM fact_employee;

SELECT DISTINCT termdate FROM StagingEmployee;
UPDATE StagingEmployee
SET termdate = NULL
WHERE termdate IN ('', 'N/A', 'NULL');


SELECT *
FROM StagingEmployee
WHERE termdate IS NOT NULL;

SELECT *
FROM fact_employee
WHERE termdate IS NOT NULL;


SELECT COUNT(*) FROM StagingEmployee WHERE termdate IS NULL;
SELECT COUNT(*) FROM fact_employee WHERE termdate IS NULL;

SELECT
  employee_id,
  first_name,
  last_name,
  termdate,
  CASE
    WHEN termdate IS NULL THEN 'Active'
    ELSE 'Terminated'
  END AS employment_status
FROM fact_employee;

-- Update

ALTER TABLE fact_employee
ADD COLUMN employment_status VARCHAR(20);

UPDATE fact_employee
SET employment_status = 
  CASE 
    WHEN termdate IS NULL THEN 'Active'
    ELSE 'Terminated'
  END;

SELECT * FROM fact_employee;



