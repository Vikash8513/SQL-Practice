/*
===================================================================================================
Topic      : Case
Database   : Employee Management System
SQl Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Display employee name and classify salary as 'High' if salary is greater than 60000, otherwise 'Low'.
SELECT name, salary,
CASE 
WHEN salary > 60000 THEN 'High' 
ELSE 'Low'
END AS salary_class
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Categorize employees based on salary:
-- Above 70000 = Hgh, 40000 - 70000 = Medium, Below 40000 = Low.
SELECT *,
CASE
    WHEN salary > 70000 THEN 'High'
    WHEN salary >= 40000 THEN 'Medium'
    ELSE 'Low'
    END AS salary_class
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Display employee name and classify age:
-- 18-25 = young, 26-40 = adult, above 40 = Senior.
SELECT name,age, 
CASE
    WHEN age > 40 THEN 'senior'
    WHEN age >= 26 THEN 'adult'
    WHEN age >= 18 THEN 'young'
    ELSE 'data not available' --(ELSE OR NULL)
    END AS age_class
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Display employee name and classify employees as 'Recent joiner' if they joined after 2023,
-- otherwise 'Existing Employee'.
SELECT employee_id,name,joindate,
CASE
    WHEN joindate > '2023-12-31' THEN 'Recent joiner'
    ELSE 'Existing Employee'
    END AS join_category
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Display department and assign a priority:
-- IT = A, Finance = B, HR = C, Other = D
SELECT DISTINCT department,
CASE
    WHEN department IS NULL THEN 'not assigned'
    WHEN department = 'IT' THEN 'A'
    WHEN department = 'Finance' THEN 'B'
    WHEN department = 'HR' THEN 'C'
    ELSE 'D'
    END AS department_Priority 
FROM Employee
ORDER BY department_Priority;
---------------------------------------------------------------------------------------------------
