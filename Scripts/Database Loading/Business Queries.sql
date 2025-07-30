-- Gender distribution across departments
SELECT
  d.department,
  COUNT(*) FILTER (
  WHERE
    f.gender = 'Male') AS male_count,
  COUNT(*) FILTER (
  WHERE
    f.gender = 'Female') AS female_count
FROM
  fact_employee f
JOIN
  dim_department d
ON
  f.dept_id = d.dept_id
GROUP BY
  d.department
ORDER BY
  d.department;
  -- Education level distribution by job title
SELECT
  j.job_title,
  COUNT(*) FILTER (
  WHERE
    e.education_level = 'High School') AS "High School",
  COUNT(*) FILTER (
  WHERE
    e.education_level = 'Bachelor') AS "Bachelor",
  COUNT(*) FILTER (
  WHERE
    e.education_level = 'Master') AS "Master",
  COUNT(*) FILTER (
  WHERE
    e.education_level = 'PhD') AS "PhD"
FROM
  fact_employee f
JOIN
  dim_job j
ON
  f.job_id = j.job_id
JOIN
  dim_education e
ON
  f.education_id = e.education_id
GROUP BY
  j.job_title
ORDER BY
  j.job_title;
  -- Average age of employees by location
SELECT
  l.city,
  ROUND(AVG(EXTRACT(YEAR
      FROM
        AGE(CURRENT_DATE,
          f.birthdate))), 1) AS avg_age
FROM
  fact_employee f
JOIN
  dim_location l
ON
  f.location_id = l.location_id
GROUP BY
  l.city
ORDER BY
  avg_age;
  -- Average salary by performance rating
SELECT
  p.performance_rating,
  ROUND(AVG(f.salary)) AS avg_salary
FROM
  fact_employee f
JOIN
  dim_performance p
ON
  f.perf_id = p.perf_id
GROUP BY
  p.performance_rating
ORDER BY
  p.performance_rating;
  -- Do high-performing employees receive higher salaries across departments?
SELECT
  d.department,
  p.performance_rating,
  ROUND(AVG(f.salary)) AS avg_salary
FROM
  fact_employee f
JOIN
  dim_department d
ON
  f.dept_id = d.dept_id
JOIN
  dim_performance p
ON
  f.perf_id = p.perf_id
GROUP BY
  d.department,
  p.performance_rating
ORDER BY
  d.department,
  p.performance_rating;
  -- Performance distribution by education level
SELECT
  p.performance_rating,
  e.education_level,
  COUNT(*) AS employee_count
FROM
  fact_employee f
JOIN
  dim_performance p
ON
  f.perf_id = p.perf_id
JOIN
  dim_education e
ON
  f.education_id = e.education_id
GROUP BY
  p.performance_rating,
  e.education_level
ORDER BY
  e.education_level,
  p.performance_rating;
  -- Hiring trend over the years
SELECT
  EXTRACT(YEAR
  FROM
    termdate) AS term_year,
  COUNT(*) AS total_attrited
FROM
  fact_employee
WHERE
  termdate IS NOT NULL
GROUP BY
  term_year
ORDER BY
  term_year;
  -- Hiring trend over time (monthly)
SELECT
  TO_CHAR(termdate,
    'YYYY-MM') AS term_month,
  COUNT(*) AS total_attrited
FROM
  fact_employee
WHERE
  termdate IS NOT NULL
GROUP BY
  term_month
ORDER BY
  term_month;
  -- Attrition rate by department
SELECT
  d.department,
  COUNT(*) FILTER (
  WHERE
    f.termdate IS NOT NULL) AS attrited,
  COUNT(*) AS total,
  ROUND(100.0 * COUNT(*) FILTER (
    WHERE
      f.termdate IS NOT NULL) / COUNT(*), 2) AS attrition_rate_percent
FROM
  fact_employee f
JOIN
  dim_department d
ON
  f.dept_id = d.dept_id
GROUP BY
  d.department
ORDER BY
  attrition_rate_percent DESC;
  -- Average employee tenure by department
SELECT
  d.department,
  ROUND(AVG(DATE_PART('day',
        COALESCE(f.termdate, CURRENT_DATE) - f.hiredate))/365.0, 2) AS avg_years_tenure
FROM
  fact_employee f
JOIN
  dim_department d
ON
  f.dept_id = d.dept_id
GROUP BY
  d.department
ORDER BY
  avg_years_tenure DESC;
  -- Departments with highest number of employees
SELECT
  d.department,
  COUNT (*) AS employee_count
FROM
  fact_employee f
JOIN
  dim_department d
ON
  f. dept_id = d. dept_id
GROUP BY
  d.department
ORDER BY
  employee_count DESC;
  -- Job titles with highest/lowest salaries
SELECT
  j.job_title,
  ROUND(AVG(f.salary)) AS avg_salary
FROM
  fact_employee f
JOIN
  dim_job j
ON
  f.job_id = j.job_id
GROUP BY
  j.job_title
ORDER BY
  avg_salary DESC; -- Chande to ASC fo y west
  -- Departments with highest average performance rating
SELECT
  d.department,
  COUNT(*) FILTER(
  WHERE
    p.performance_rating = 'Excellent') AS "Highest Rating"
FROM
  fact_employee f
JOIN
  dim_department d
ON
  f.dept_id = d.dept_id
JOIN
  dim_performance p
ON
  f.perf_id = p.perf_id
GROUP BY
  d.department
ORDER BY
  "Highest Rating" DESC;