/*
===================================================================================================
Topic      : Top Clause
Database   : Employee Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Display the top 5 highest paid employees.
SELECT TOP 5 *
FROM Employee
ORDER BY Salary desc;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Display the top 5 employee with lowest salary.
SELECT TOP 5 *
FROM Employee
ORDER BY salary ASC;
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Display the top 10 oldest employee based on Join Date.
SELECT TOP 10 *
FROM Employee
ORDER BY JoinDate ASC;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Display the top 1 newest employee.
SELECT TOP 1 *
FROM Employee
ORDER BY JoinDate DESC;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Find the top 3 highest paid employees from IT department.
SELECT TOP 3 *
FROM Employee
WHERE department = 'IT'
ORDER BY salary DESC;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Display the top 4 highest paid female employee.
SELECT TOP 4 *
FROM Employee
WHERE gender = 'female'
ORDER BY salary DESC;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Display the top 5 employees who joined after 2013.
SELECT TOP 5 *
FROM Employee
WHERE YEAR(JoinDate) > 2013
ORDER BY JoinDate ASC
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Display the top 5 highest paid employees who joined after 2018.
SELECT TOP 5 *
FROM Employee
WHERE YEAR(JoinDate) > 2018 AND JoinDate IS NOT NULL
ORDER BY salary DESC;
----------------------------------------------------------------------------------------------------



