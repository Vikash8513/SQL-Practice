/*
===================================================================================================
Topic      : Group By Clause
Database   : Employee Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Count employees in each department.
SELECT department, COUNT(*) AS Department_wise_Count 
FROM Employee
GROUP BY department;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Count employees by gender.
SELECT gender, COUNT(*) AS Gender_Wise_Count
FROM Employee
GROUP BY gender;
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Count employees who joined in each year.
SELECT YEAR(Joindate) AS join_year, 
       COUNT(employee_id) AS total_employees
FROM Employee
GROUP BY YEAR(Joindate);
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Calculate total salary for each department.
SELECT department, SUM(salary) AS Total_Salary_Department_wise
FROM Employee
GROUP BY department;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Calculate total salary for each city.
SELECT city, SUM(salary) AS Total_Salary_City_Wise
FROM Employee
GROUP BY city;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Find the average salary of each department.
SELECT department, AVG(salary) AS Average_salary_Department_Wise
FROM Employee
GROUP BY department;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Find the highest salary in each department.
SELECT department, MAX(salary) AS Highest_salary
FROM Employee
GROUP BY department;
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Find the lowest salry in each department.
SELECT department, MIN(salary) AS Lowest_salary
FROM Employee
GROUP BY department;
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Find the ealiest joining date in each department.
SELECT department, MIN(Joindate) AS Earliest_Join
FROM Employee
GROUP BY department;
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Find the latest joining date in each department.
SELECT department, MAX(Joindate) AS Latest_Join
FROM Employee
GROUP BY department;
---------------------------------------------------------------------------------------------------

-- Question 11.
-- Count employees in each department and city.
SELECT department, city, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY department, city;
---------------------------------------------------------------------------------------------------

-- Question 12.
-- Calculate the average salary by department and gender.
SELECT department, gender, AVG(salary) AS Average_salary
FROM Employee
GROUP BY department, gender;
---------------------------------------------------------------------------------------------------

-- Question 13.
-- Calculate the total salary for each department and country.
SELECT department, country, SUM(salary) AS Total_salary
FROM Employee
GROUP BY department, country;
---------------------------------------------------------------------------------------------------

