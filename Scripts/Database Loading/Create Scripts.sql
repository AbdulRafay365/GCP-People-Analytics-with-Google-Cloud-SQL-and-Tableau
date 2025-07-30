DROP TABLE IF EXISTS fact_employee;
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
