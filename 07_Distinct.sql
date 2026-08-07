/*
===================================================================================================
Topic      : Distinct
Database   : Employee Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Display all distinct departments.
SELECT DISTINCT Department
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Display all distinct cities.
SELECT DISTINCT City
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Display all distinct gender.
SELECT DISTINCT Gender
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Display distinct country and city combination.
SELECT DISTINCT Country, City
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Display distinct department and city combination.
SELECT DISTINCT Department,City
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Display distinct joining years.
SELECT DISTINCT YEAR(JoinDate) AS Join_Year 
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Display distinct joining years. (NOT NUll)
SELECT DISTINCT YEAR(joindate) AS Joining_Year
FROM Employee
WHERE JoinDate IS NOT NULL;
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Display distinct cities in desending order.
SELECT DISTINCT City
FROM Employee
ORDER BY city DESC;
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Display distinct cities where employees earn more than 50000.
SELECT DISTINCT City
FROM Employee
WHERE salary > 50000;
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Display distinct joining months.
SELECT DISTINCT MONTH(JoinDate) AS Join_Month
FROM Employee;
---------------------------------------------------------------------------------------------------


