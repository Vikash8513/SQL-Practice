/*
===================================================================================================
Topic       : String Functions
Database    : Employee Management System
SQL Server  : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Display the lenght of each employees's name.
SELECT name, LEN(name)Total_Lenght FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Display employees whose name lenght is greater than 10.
SELECT name, LEN(name) AS Name_Lenght
FROM Employee
WHERE LEN(name) > 10;
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Display employee names in uppercase.
SELECT UPPER(name) AS Upper_Case
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Display First 3 characters of Employee Name.
SELECT Name,      
       LEFT(Name, 3) AS FirstThreeCharacters
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Display Last 3 characters of Employee Name.
SELECT Name,
       RIGHT(Name, 3) AS LastThreeCharacters
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Display name and department in uppercase.
SELECT UPPER(name) Upper_Case, UPPER(department) AS Upper_case
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Display employee email in lowercase.
SELECT LOWER(email) AS Lower_case 
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Display the domain name from the email address.
SELECT email,
SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS domain_name
FROM employee;
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Display the first name using substring.
SELECT name,
SUBSTRING(name, 1, CHARINDEX(' ', name + ' ') - 1) AS first_name
FROM employee;
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Display employee name and department together.
SELECT employee_id,
CONCAT(name, ' - ', department) AS name_and_department
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 11.
-- Display city and country together.
SELECT employee_id,name,
CONCAT(city, '-', country) AS city_and_country
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 12.
-- Replace "gmail.com" with "company.com" in the email.
SELECT employee_id,name,email AS original_email,
REPLACE(email, 'gmail.com', 'company.com') AS updated_email
FROM Employee;

-- For Permanent Change
UPDATE Employee
SET email = REPLACE(email, 'gmail.com', 'company.com')
WHERE email LIKE '%@gmail.com';
---------------------------------------------------------------------------------------------------

-- Question 13.
-- Rename 'IT' with 'Information Technology' in the department name.
SELECT employee_id,name,department AS original_department,
REPLACE(department, 'IT', 'INFORMATION TECHNOLOGY')AS updated_department
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 14.
-- Remove leading spaces from employee names.
SELECT employee_id,name AS original_name,
LTRIM(name) AS cleaned_name
FROM Employee;

-- For parmanetly change
UPDATE Employee
SET name = RTRIM(name)
WHERE name LIKE '% ';
---------------------------------------------------------------------------------------------------

-- Question 15.
-- Remove trailing spaces from employee names.
SELECT employee_id,name AS original_name,
RTRIM(name) AS cleaned_name
FROM Employee;

-- For parmanently change
UPDATE Employee
SET name = RTRIM(name)
WHERE name LIKE '% '; 
---------------------------------------------------------------------------------------------------

-- Question 16.
-- Remove both leading and trailing spaces.
SELECT employee_id,
TRIM(name) AS cleaned_name 
FROM Employee;

-- For parmanently change
UPDATE Employee
SET name = TRIM(name)
WHERE name LIKE ' %' OR name LIKE '% ';
---------------------------------------------------------------------------------------------------

-- Question 17.
-- Find the position of '@' in each email address.
SELECT employee_id,email,
CHARINDEX('@', email) AS at_symbol_position
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 18.
-- Display First 5 characters of employee name.
SELECT Name,
       SUBSTRING(Name, 1, 5) AS FirstFiveCharacters
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 19.
-- First character of each name.
SELECT Name,
       LEFT(Name, 1) AS FirstCharacter
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 20.
-- Create a customer address using multiple columns.
SELECT  CONCAT_WS(', ',
        Name,
        Department,
        City
    ) AS EmployeeAddress
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 21.
-- Create an employee description.
SELECT CONCAT(Name, ' works in ', Department, ' department. ') AS EmployeeDescription
FROM Employee;
---------------------------------------------------------------------------------------------------

