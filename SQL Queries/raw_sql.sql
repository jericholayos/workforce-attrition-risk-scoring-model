SET search_path TO public;

SELECT *
FROM hr_attrition
LIMIT 10;

-- Attrition Rate is 16.12% (237 employees)
SELECT
	attrition,
	COUNT(*) AS total_employees,
	ROUND((100.0 * COUNT(*)) / SUM(COUNT(*)) OVER(), 2) AS attrition_rate
FROM hr_attrition
GROUP BY 1;

-- min age is 18
-- max age is 60
SELECT 
	ROUND(AVG(age), 2),
	MAX(age), 
	MIN(age)
FROM hr_attrition;



-- 18-24 Age Group has high attrition rate at 39.1% (38 out of 97 employees)
-- 25-34 Age Group has 20.22% rate (112 out of 554 employees)
SELECT 
	age_group,
	COUNT(*) AS total_employees,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100.0, 2) AS attrition_rate
FROM hr_attrition
GROUP BY 1
ORDER BY 4 DESC;

-- high school graduates has high attrition rate at 18.24% (31 out of 170)
-- bachelors degree graduates has 17.31% attrition rate (99 out of 572)
-- associate degree and masters degree is near equal at 14.5% to 15.6% attrition rate
-- doctorate has the lowest attrition rate at 10.42% (5 out of 48)
SELECT 
	education,
	COUNT(*) AS total_employees,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100.0, 2) AS attrition_rate
FROM hr_attrition
GROUP BY 1
ORDER BY 4 DESC;


-- high school graduates has high attrition rate at 18.24% (31 out of 170)
-- WHY? 18 left those who did overtime and 13 left those who didn't. 
-- overtime is a huge driver for attrition at 33.33%
SELECT
	overtime,
	COUNT(*) AS employee_count,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100.0, 2) AS attrition_rate
FROM hr_attrition
WHERE education = 'High School'
GROUP BY 1;







-- those who travel frequently has a high attrition rate at 24.9% (69 out of 277)
-- travel rarely has 14.96% attrition rate (156 out of 1043)
-- and non-travel has 8% (12 out of 150)
SELECT
	business_travel,
	COUNT(*) AS total_employees,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS attrition_rate
FROM hr_attrition
GROUP BY 1
ORDER BY 4 DESC;

-- sales rep. has the highest attrition at 39.76%
-- research director has the lowest at 2.5% (2 out of 80)
-- lab tech. (23.9%) and sales exec. (17.4%) has high attrition count despite having 
	-- less attrition rate compared to sales rep.
SELECT
	job_role,
	COUNT(*) AS total_employees,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS attrition_rate
FROM hr_attrition
GROUP BY 1
ORDER BY 4 DESC;


-- sales department has 20.63% attrition rate (92 out of 446)
-- hr department has 19% attrition rate (12 out of 63)
-- and r&d has 13.84% attrition rate (133 out of 961)
SELECT
	department,
	COUNT(*) AS total_employees,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2) AS attrition_rate
FROM hr_attrition
GROUP BY 1
ORDER BY 4 DESC;


-- manager in sales has 17k avg income
-- sales rep has 2.6k avg income
-- and sales exec has 7k income
SELECT
	job_role,
	ROUND(AVG(monthly_income), 2) AS avg_income
FROM hr_attrition
WHERE department = 'Sales'
GROUP BY 1;




/* Compensation Queries */
SELECT
	DISTINCT percent_salary_hike
FROM hr_attrition
ORDER BY 1;

ALTER TABLE hr_attrition
ADD COLUMN salary_bucket VARCHAR;

UPDATE hr_attrition
SET salary_bucket = 
CASE
	WHEN percent_salary_hike BETWEEN 11 AND 14 THEN '11-14%'
	WHEN percent_salary_hike BETWEEN 15 AND 19 THEN '15-19%'
	WHEN percent_salary_hike BETWEEN 19 AND 22 THEN '19-22%'
	WHEN percent_salary_hike BETWEEN 23 AND 25 THEN '23-25%'
END;


-- 23-25% bucket has a high attrition rate at 19% but low sample size (13 out of 67)
-- 11-22% bucket has a attrition rate at 15-16%
-- this suggests that percent salary hike is not enough to be a driver for attrition
SELECT
	salary_bucket,
	COUNT(*) AS total_employees,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100.0, 2) AS attrition_rate
FROM hr_attrition
GROUP BY 1
ORDER BY 4 DESC;


-- Overtime is a huge driver for attrition. Regardless of salary bucket,
-- Employees doing overtime leave at a higher rate compared those who doesn't do overtime
SELECT
	salary_bucket,
	overtime,
	COUNT(*) AS total_employees,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100.0, 2) AS attrition_rate
FROM hr_attrition
GROUP BY 1, 2
ORDER BY 5 DESC;




-- stock option level 0 has 24.41% attrition rate (154 out of 631 employees)
-- stock level 3 has 17.65% attrition rate but low sample size (15 out of 85)
-- employees with no stock level tend to leave more compared to those who have, 
-- this means that stock option level is a effective driver for retaining employees
SELECT 
	stock_option_level,
	COUNT(*) AS total_employees,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100.0, 2) AS attrition_rate
FROM hr_attrition
GROUP BY 1
ORDER BY 4 DESC;


-- Job Level 1 is a high driver for attrition 26.34% (143 out of 543). 
-- Attrition also decreases as Job Level goes high, 
-- Job Level 3 is an anomaly and should be monitored more or HR should look into it.
SELECT
	job_level,
	COUNT(*) AS total_employees,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100.0, 2) AS attrition_rate
FROM hr_attrition
GROUP BY 1
ORDER BY 1 ASC;


SELECT
	attrition,
	ROUND(AVG(monthly_income), 2) AS avg_income
FROM hr_attrition
GROUP BY 1;

SELECT
	job_role,
	ROUND(AVG(monthly_income), 2) AS avg_income
FROM hr_attrition
GROUP BY 1
ORDER BY 2 DESC;


-- Roles with lower average monthly income such as Sales Representative and Laboratory Technician 
-- have significantly higher attrition, 
-- while high earning roles like Manager and Research Director have the lowest attrition
-- Sales Executive has 57 attrition count, mostly due to overtime
SELECT
	job_role,
	COUNT(*) AS employee_count,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(monthly_income), 2) AS avg_income,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100.0, 2) AS attrition_rate	
FROM hr_attrition
GROUP BY 1
ORDER BY 4 DESC;


SELECT
	job_role,
	business_travel,
	COUNT(*)
FROM hr_attrition
WHERE job_role = 'Sales Executive'
GROUP BY 1, 2
ORDER BY 3 DESC;

SELECT 
	department,
	overtime,
	COUNT(*) AS total_employees,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count,
	ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100.0, 2) AS attrition_rate	
FROM hr_attrition
GROUP BY 1, 2
ORDER BY 1 ASC;


SELECT
	department,
	job_role,
	COUNT(*) FILTER(WHERE attrition = 'Yes')
FROM hr_attrition
WHERE department = 'Sales'
GROUP BY 1, 2


















