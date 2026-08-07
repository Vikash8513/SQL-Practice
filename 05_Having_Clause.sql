/*
===================================================================================================
Topic      : Having Clause
Database   : Employee Management System
SQL Server : Microsoft SQl Server
===================================================================================================
*/

-- Question 1.
-- Display department having more than 2 employees.
SELECT department, COUNT(*) AS Total_Employee
FROM Employee
GROUP BY department
HAVING COUNT(*) > 2;

-- If we want only name of department.
SELECT department
FROM employee
GROUP BY department
HAVING COUNT(*) > 2;

---------------------------------------------------------------------------------------------------

-- Question 2.
-- Display cities having less than 3 employee.
SELECT city, COUNT(*) AS Total_Employee
FROM Employee
GROUP BY city
HAVING COUNT(*) < 3; 
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Display department having exactly 3 employees.
SELECT department, COUNT(*) AS Exactly_Three_Employees
FROM Employee
GROUP BY department
HAVING COUNT(*) = 3;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Display department whose total salary is greater than 200000.
SELECT department, SUM(salary) AS Department_Salary
FROM Employee
GROUP BY department
HAVING SUM(salary) > 200000;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Display city whose total salary is less then 300000.
SELECT city, SUM(salary) AS City_Salary
FROM Employee
GROUP BY city
HAVING SUM(salary) < 300000;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Display department whose average salary is greater than 50000.
SELECT department, AVG(salary) AS Department_avg_salary
FROM Employee
GROUP BY department
HAVING AVG(salary) > 50000;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Display cities where the highest salary is greater than 60000.
SELECT city, MAX(salary) AS Salary_Greater_Than_60k
FROM Employee
GROUP BY city
HAVING MAX(salary) > 60000;
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Display department with its newest employee joining date exclude departments where the join date
-- is missing.(NULL)
SELECT department, MAX(joindate) AS Newest_join
FROM Employee
GROUP BY department
HAVING MAX(joindate) IS NOT NULL;

-- Where Method
SELECT department, MAX(joindate) As Newest_join
FROM Employee
WHERE joindate IS NOT NULL
GROUP BY department;
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Display department with its earliest employee join date, exclud departments where the join date 
-- is missing (NULL).
SELECT department, MIN(Joindate) AS Earliest_join
FROM Employee
GROUP BY department
HAVING MIN(JoinDate) IS NOT NULL;

-- Where Method
SELECT department, MAX(joindate) AS Earliest_join
FROM Employee
WHERE joindate IS NOT NULL
GROUP BY department;
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Display department where the minimum salary is greater than 30000.
SELECT department, MIN(salary) AS Minimum_Salary
FROM Employee
GROUP BY department
HAVING MIN(salary) > 30000;
---------------------------------------------------------------------------------------------------

-- Question 11.
-- Display department having more than 2 employees and an average salary greater than 50000.
SELECT department,COUNT(*) AS Total_Employee,AVG(salary) AS Average_Salary
FROM Employee
GROUP BY department
HAVING COUNT(*) > 2 AND AVG(salary) >50000;
---------------------------------------------------------------------------------------------------

-- Question 12.
-- Display department where the average salary is between 40000 and 70000.
SELECT department, Avg(salary) AS Average_Salary
FROM Employee
GROUP BY department
HAVING AVG(salary) BETWEEN 40000 AND 70000;
---------------------------------------------------------------------------------------------------










