SELECT *
FROM employee_attrition_staging2;

SELECT DISTINCT Department
FROM employee_attrition_staging2;


SELECT *
FROM employee_attrition_staging2
WHERE YearsWithCurrManager >= 14.5
;

SELECT ROUND(AVG(age),2),
ROUND(STDDEV(age),2)
FROM employee_attrition;

SELECT DISTINCT StandardHours
From employee_attrition;

SELECT YearsWithCurrManager
FROM employee_attrition
WHERE YearsWithCurrManager IS NULL
		OR YearsWithCurrManager = "";
        
SELECT EmployeeNumber, COUNT(EmployeeNumber) AS appearance
FROM employee_attrition
GROUP BY EmployeeNumber;

SELECT *
FROM employee_attrition
WHERE NumCompaniesWorked = 1;

SELECT age, TotalWorkingYears, (age - TotalWorkingYears) AS ageStartedWork
FROM employee_attrition
WHERE age > TotalWorkingYears;

WITH table_cte AS
(
SELECT age, TotalWorkingYears, (age - TotalWorkingYears) AS ageStartedWork
FROM employee_attrition
WHERE age > TotalWorkingYears
)
SELECT Avg(ageStartedWork)
FROM table_cte;


-- Possible outliers with Z-Score
SELECT age, (age - 36.92)/9.13 AS z_score
FROM employee_attrition_staging2;



SELECT DISTINCT age
FROM employee_attrition_staging2
ORDER BY age;

WITH percentile_table AS
(
SELECT age,
PERCENT_RANK() OVER(ORDER BY age ASC) AS percentile
FROM employee_attrition_staging2
ORDER BY age ASC
)
SELECT MIN(CASE WHEN percentile >= 0.75 THEN age END) -
	   MIN(CASE WHEN percentile >=.25 THEN age END) AS IQR
FROM percentile_table;

-- Outliers with Interquartile Range
WITH percentile_table AS
(
SELECT age,
PERCENT_RANK() OVER(ORDER BY age ASC) AS percentile
FROM employee_attrition_staging2
ORDER BY age
)
SELECT *
FROM percentile_table
WHERE 
	age < 
	(SELECT MIN(CASE WHEN percentile >= 0.25 THEN age END) - (1.5)*(5)
    FROM percentile_table)
    OR
    age > 
    (SELECT MIN(CASE WHEN percentile >= 0.75 THEN yearswithcurrmanager END) + (1.5)*(5)
    FROM percentile_table);


WITH percentile_table AS
(
SELECT Yearswithcurrmanager,
PERCENT_RANK() OVER(ORDER BY yearswithcurrmanager ASC) AS percentile
FROM employee_attrition_staging2
ORDER BY yearswithcurrmanager
)
SELECT MIN(CASE WHEN percentile >= 0.75 THEN yearswithcurrmanager END) + (1.5)*(5),
	   MIN(CASE WHEN percentile >=.25 THEN yearswithcurrmanager END) - 1.5*(5)
FROM percentile_table;

