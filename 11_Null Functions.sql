/*
===================================================================================================
Topic      : Null Functions
Database   : Employee Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Display employees whose age is NULL.
SELECT * FROM Employee
WHERE age IS NULL;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Display employees whose age is NOT NULL.
SELECT * FROM Employee
WHERE age IS NOT NULL;
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Replace NULL age with 37 using ISNULL().
-- To just view
SELECT employee_id, name,age, ISNULL(age, 37) AS finalized_age 
FROM Employee;

-- For parmanent UPDATE
UPDATE Employee
SET age = ISNULL(age, 37)
WHERE age IS NULL;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Display employee name with replace NULL age with 'not available'.
SELECT name, ISNULL(CAST(age AS VARCHAR(15)), 'not available') AS age_status
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Calculate total salary including employees with null bonus.
SELECT employee_id,name,salary,bonus,
salary + ISNULL(bonus, 0) AS total_salary
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Calculate total salary of employees whose bonus is NULL
SELECT SUM(Salary)AS total_salary FROM Employee
where bonus IS NULL;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Calculate the average bonus after replacing NULL bonus with 0.
SELECT AVG(ISNULL(bonus,0)) AS avg_bonus
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Display employees whose bonus is either NULL or greater then 7000.
SELECT * FROM Employee
WHERE bonus IS NULL OR bonus > 7000;
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Count employees whose bonus is NULL.
SELECT COUNT(*) FROM Employee
WHERE bonus IS NULL;
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Display employee name and bonus, showing 0 instead of NULL.
SELECT name, ISNULL(bonus,0) AS bonus
FROM Employee
---------------------------------------------------------------------------------------------------
