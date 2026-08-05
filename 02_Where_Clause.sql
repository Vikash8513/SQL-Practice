/*
===================================================================================================
Topic      : WHERE Clause
Database   : Employee Management System
SQL Server : Microsoft SQL Server
===================================================================================================

-- Question 1.
-- Display employees from the IT department.
SELECT * FROM Employee
WHERE Department = 'IT';
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Display employees from Delhi.
SELECT * FROM Employee
WHERE City = 'Delhi';
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Display employees whose salary is greater than 50000.
SELECT * FROM Employee
WHERE Salary > 50000;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Display female employees.
SELECT * FROM Employee
WHERE Gender = 'Female';
---------------------------------------------------------------------------------------------------

--Question 5.
-- Display employees who joined in 2023. (Using Year)
SELECT * FROM Employee
WHERE YEAR(JoinDate) = 2023;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Display employees who joined in 2023. (Using Between)
SELECT * FROM Employee
WHERE JoinDate BETWEEN '2023-01-01' AND '2023-12-31';
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Display employees who joined after 2023-01-01.
SELECT * FROM Employee
WHERE JoinDate > '2023-01-01';
---------------------------------------------------------------------------------------------------

-- Question 8.
--Display employees from the HR department and who salary is greater than 50000.
SELECT * FROM Employee
WHERE department = 'HR' AND salary > 40000;
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Display employee who belong to Delhi or Bangalore.
SELECT * FROM employee
WHERE city = 'Delhi' OR city = 'Bangalore';
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Display employees whose country is India and gender is Female.
SELECT * FROM Employee 
WHERE country = 'India' AND gender = 'Female';
---------------------------------------------------------------------------------------------------





