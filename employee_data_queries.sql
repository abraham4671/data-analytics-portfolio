CREATE DATABASE hr_attrition;

USE hr_attrition;

CREATE TABLE employees (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 CHAR(1),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

SHOW VARIABLES LIKE 'secure_file_priv';

ALTER TABLE employees ADD COLUMN ExtraCol VARCHAR(100);

SHOW WARNINGS;

DESCRIBE employees;

-- Total rows
SELECT COUNT(*) FROM employees;

-- Peek first 5 rows
SELECT * FROM employees LIMIT 5;

-- Check unique values in categorical columns
SELECT DISTINCT Attrition FROM employees;
SELECT DISTINCT BusinessTravel FROM employees;
SELECT DISTINCT Department FROM employees;
SELECT DISTINCT OverTime FROM employees;

-- Example: Trim spaces if needed
UPDATE employees SET Attrition = TRIM(Attrition);

-- Attrition rate
SELECT Attrition, COUNT(*) 
FROM employees 
GROUP BY Attrition;

-- Average income by department
SELECT Department, AVG(MonthlyIncome) AS avg_income
FROM employees 
GROUP BY Department;

-- Attrition by JobRole
SELECT JobRole, Attrition, COUNT(*) 
FROM employees 
GROUP BY JobRole, Attrition 
ORDER BY JobRole;

-- Average years at company by attrition
SELECT Attrition, AVG(YearsAtCompany) AS avg_years
FROM employees
GROUP BY Attrition;

-- Overtime vs Attrition
SELECT OverTime, Attrition, COUNT(*) 
FROM employees
GROUP BY OverTime, Attrition;

-- EducationField distribution
SELECT EducationField, COUNT(*) 
FROM employees
GROUP BY EducationField;

-- Example: Export attrition summary
SELECT Department, Attrition, COUNT(*) AS count
FROM employees
GROUP BY Department, Attrition
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/attrition_summary.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';
