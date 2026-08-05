/*
===================================================================================================
Topic      : Aggregate Function
Database   : Employee Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Count total employees.
SELECT COUNT(*) AS Total_Employees
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Count female employees
SELECT COUNT(*) AS Total_female_employee
FROM Employee
WHERE gender = 'Female';
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Count employees in the IT department.
SELECT COUNT(*) AS Total_It_employees
FROM Employee
WHERE Department = 'IT';
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Count employess who joined in 2023.
SELECT COUNT(*) AS Joined_2023
FROM Employee
WHERE YEAR(JoinDate) = 2023;
---------------------------------------------------------------------------------------------------

-- Question 5.
--Count employees with salary greater than 50000.
SELECT COUNT(salary) AS Salary_greater_50K
FROM Employee
WHERE salary > 50000;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Find total salary.
SELECT SUM(Salary) AS Total_Salary
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Calculate total salary of employees in the IT department.
SELECT SUM(salary) AS Total_It_Salary
FROM Employee
WHERE Department = 'IT';
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Calculate total salary of female employees.
SELECT SUM(salary) AS Total_female_salary
FROM Employee
WHERE gender = 'Female';
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Calculate total salary of employees who joined after 2022-12-31.
SELECT SUM(salary) AS Joined_after_2022
FROM Employee
WHERE JoinDate > '2022-12-31';
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Find average salary.
SELECT AVG(salary) AS Average_salary
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 11.
-- Find the average salary in the HR department.
SELECT AVG(salary) AS HR_Average_Salary
FROM Employee
WHERE department = 'HR';
---------------------------------------------------------------------------------------------------

-- Question 12.
-- Find average age of employees.
SELECT AVG(age) AS Average_Age
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 13.
-- Find highest salary.
SELECT MAX(salary) AS Maximum_Salary
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 14.
-- Find the latest joining date.
SELECT MAX(JoinDate) AS Latest_joining
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 15.
-- Find lowest salary.
SELECT MIN(salary) AS Lowest_Salary
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 16.
-- Find the earliest joining date.
SELECT MIN(JoinDate) AS Oldest_joining
FROM Employee;
---------------------------------------------------------------------------------------------------



