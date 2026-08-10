/*
===================================================================================================
Topic      : Subqueries
Database   : Employee Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Find employees earning more than the average salary.
SELECT employee_id,name,department,city FROM Employee 
WHERE salary > (SELECT AVG(SALARY) FROM Employee);
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Find the employee with the highest salary.
SELECT * FROM Employee 
WHERE salary = (SELECT MAX(SALARY) FROM Employee);

-- TOP METHOD
SELECT TOP 1 employee_id,name,salary
FROM employee
ORDER BY salary DESC;

-- IF TIES
SELECT TOP 1 WITH TIES employee_id,name,salary
FROM employee
ORDER BY salary DESC;
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Find employees earning more than the minimum salary.
SELECT employee_id,name,department,salary
FROM Employee
WHERE salary > (SELECT MIN(salary) FROM Employee);
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Find employees who earn more than the average salary of the IT department.
SELECT employee_id,name,department,salary 
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee WHERE department = 'IT');

-- If we also want column of IT's average salary. 
SELECT employee_id, name, department, salary,
       (SELECT AVG(salary) FROM Employee WHERE department = 'IT') AS IT_average_salary
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee WHERE department = 'IT');

---------------------------------------------------------------------------------------------------

-- Question 5.
-- Find the second-highest salary.
SELECT MAX(salary) AS second_highest 
FROM Employee 
WHERE salary < (SELECT MAX(salary) FROM Employee);

-- For specific or entire column. 
SELECT * FROM Employee
WHERE salary = (SELECT MAX(salary) FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee));
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Find employees who joined before the average joining date.
SELECT employee_id, name, joindate 
FROM Employee
WHERE joindate < (SELECT DATEADD(DAY, AVG(DATEDIFF(DAY, '1900-01-01', joindate)), '1900-01-01') 
FROM Employee);
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Find third highest salary.
SELECT MAX(salary) AS Third_highest_salary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee));

-- For entire row
SELECT * FROM Employee
WHERE salary = (SELECT MAX(salary) FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee)));
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Find the fourth highest salary.
SELECT MAX(salary) AS fourth_highest
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee)));
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Employees earning more than the average salary of their department.
SELECT e1.employee_id, e1.name, e1.department, e1.salary
FROM Employee e1
WHERE e1.salary > (SELECT AVG(e2.salary) FROM Employee e2 
WHERE e2.department = e1.department);
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Employee with the same department as Rahul Kumar.
SELECT employee_id, name, department, salary
FROM Employee
WHERE department IN (SELECT department FROM Employee WHERE name = 'rahul Kumar');
--( Used IN instead of = for multiple same name)
---------------------------------------------------------------------------------------------------

-- Question 11.
-- Employees whose salary is greater than the salary of a particular employee.
SELECT * FROM Employee WHERE salary > (SELECT salary FROM Employee
WHERE employee_id = 106);

-- If we want reference column also
SELECT employee_id,name,department,salary, (SELECT salary FROM Employee WHERE employee_id = 106) AS target_salary
FROM Employee
WHERE salary >(SELECT salary FROM Employee WHERE employee_id = 106);
---------------------------------------------------------------------------------------------------

-- Question 12.
-- Find employeees whose department has atleast one employee earning above 80000.
SELECT employee_id,name,department,salary
FROM Employee
WHERE department IN(SELECT DISTINCT department FROM Employee WHERE salary > 80000);
---------------------------------------------------------------------------------------------------
