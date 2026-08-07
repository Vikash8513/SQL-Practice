/*
===================================================================================================
Topic       : Between, IN, Like 
Database    : Employee Management System
SQL Server  : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Display employees whose salary is between 40000 and 70000.
SELECT * FROM Employee
WHERE salary BETWEEN 40000 AND 70000;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Display employees who joined between 2023-01-01 and 2023-12-31.
SELECT * FROM Employee
WHERE JoinDate BETWEEN '2023-01-01' AND '2023-12-31'; 
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Display employees whose salry is not between 40000 and 70000.
SELECT * FROM Employee
WHERE salary NOT BETWEEN 40000 AND 70000;
---------------------------------------------------------------------------------------------------

-- Questionn 4.
-- Display employees from the IT and HR department.
SELECT * FROM Employee
WHERE department IN ('IT', 'HR');

-- OR Method
SELECT * FROM Employee
WHERE department = 'IT' OR department = 'HR';
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Display employees from Delhi, Mumbai and Bangalore.
SELECT * FROM Employee
WHERE city = 'delhi' OR city = 'Mumbai' OR city = 'Bangalore';

-- IN Method
SELECT * FROM Employee
WHERE City IN ('delhi', 'mumbai', 'bangalore');
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Display employees whose country is India or USA.
SELECT * FROM Employee
WHERE country IN('India', 'USA');
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Display employees whose department is not IT or HR.
SELECT * FROM Employee
WHERE department NOT IN ('IT', 'HR');

-- AND Method
SELECT * FROM Employee
WHERE department <> 'IT' AND department <> 'HR';
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Display female employees from Delhi or Mumbai.
SELECT * FROM Employee
WHERE gender = 'female' AND city IN ('delhi', 'mumbai');

-- Second Method
SELECT * FROM Employee
WHERE gender = 'female' AND(City = 'delhi' OR city = 'mumbai');
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Display employees whose cityis in a given list. (Ranchi, Delhi, Mumbai, Bangalore)
SELECT * FROM Employee
WHERE city IN ('Ranchi', 'Delhi', 'Mumbai', 'Bangalore');
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Display employees whose name starts with 'A'.
SELECT * FROM Employee
WHERE name LIKE 'A%';
---------------------------------------------------------------------------------------------------

-- Question 11.
-- Dispaly employees whose name ends with 'A'.
SELECT * FROM Employee
WHERE name LIKE '%A';
---------------------------------------------------------------------------------------------------

-- Question 12.
-- Display employees whose email starts with hr.
SELECT * FROM Employee
WHERE email LIKE 'hr%';
---------------------------------------------------------------------------------------------------

-- Question 13.
-- Display employees whose name contains 'an'.
SELECT * FROM Employee
WHERE name LIKE '%an%';
---------------------------------------------------------------------------------------------------

-- Question 14.
-- Display employees whose second letter of his name is 'a'.
SELECT * FROM Employee
WHERE name LIKE '_A%';
---------------------------------------------------------------------------------------------------

-- Question 15.
-- Display employees whose name starts with 'a' and ends with 'a';
SELECT * FROM Employee
WHERE name LIKE 'a%a';
---------------------------------------------------------------------------------------------------

-- Question 16.
-- Display employees whose department contains 'fin',
SELECT * FROM Employee
WHERE department LIKE '%fin%';
---------------------------------------------------------------------------------------------------

-- Question 17.
-- Display employees whose name has exactly 10 characters.
SELECT * FROM Employee
WHERE name LIKE '__________';
---------------------------------------------------------------------------------------------------




