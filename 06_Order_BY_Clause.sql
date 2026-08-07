/*
===================================================================================================
Topic      : Order By Clause
Database   : Employee Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Display employees order by Name (A-Z).
SELECT * FROM Employee
ORDER BY Name ASC;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Display employees order by salary (High to Low)
SELECT * FROM Employee
ORDER BY salary DESC;
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Display employees by joining date (Oldest to Newest).
SELECT * FROM Employee
ORDER BY joindate ASc;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Order employess by department (Ascending).
SELECT * FROM Employee
ORDER BY department ASC;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Order by department, then salary (Descending).
SELECT * FROM Employee
ORDER BY department DESC, salary DESC;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Order employees by Gender, then Name.
SELECT * FROM Employee
ORDER BY gender, Name;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Order by Name (A to Z), then city (Z to A)
SELECT * FROM Employee
ORDER BY Name ASC, City DESC;
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Display the top 5 highest paid employees.
SELECT TOP 5
          Name,
          Salary,
          Department
FROM Employee
ORDER BY salary DESC;
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Display the top 5 least paid employees.
SELECT TOP 5
            Name,
            Salary,
            Department
FROM Employee
ORDER BY salary ASC;
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Write a query to find the last 10 employees who were hired by the company. 
SELECT TOP 10 * 
FROM Employee
ORDER BY JoinDate DESC;
---------------------------------------------------------------------------------------------------
            

       





