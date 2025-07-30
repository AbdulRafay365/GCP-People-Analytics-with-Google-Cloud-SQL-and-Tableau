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


