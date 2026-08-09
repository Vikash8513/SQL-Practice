/*
===================================================================================================
Topic      : Date Functions
Database   : Employee Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Display the current date and time.
SElECT GETDATE() AS Current_Date_And_Time;

-- OR
SELECT CURRENT_TIMESTAMP AS Current_Date_Time;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Display the current date only.
SELECT CAST(GETDATE() AS DATE) 
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Display the year from each employee's join date.
SELECT employee_id, YEAR(joindate) AS joining_year FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Display the month from each employees's join date.
SELECT employee_id, name, MONTH(joindate) AS joining_month FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Display the day from each employees's join date.
SELECT *, DAY(joindate) AS joining_day FROM Employee;

-- Better 
SELECT E.*, DAY(E.joindate) AS join_day FROM Employee E;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Display employees who joined in 2023.
SELECT employee_id,name,department, YEAR(joindate) AS joining_year
FROM Employee
WHERE YEAR(JoinDate) = 2023;

-- Alternate good method for large dataset
SELECT employee_id,name,department, YEAR(joindate) AS joined_in_2023
FROM Employee
WHERE joindate >= '2023-01-01' AND joindate < '2024-01-01';
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Display employees who joined in january.
SELECT employee_id,name,department, MONTH(joindate) AS joining_month
FROM Employee
WHERE MONTH(joindate) = 1;
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Calculate the number of years each employee has worked.
SELECT employee_id,name,department,gender, DATEDIFF(YEAR, joindate, GETDATE()) AS years_worked 
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Calculate the number of months each employees has worked.
SELECT employee_id,name, DATEDIFF(MONTH, joindate, GETDATE()) AS Months_worked 
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Calculate the number of days each employees has worked.
SELECT employee_id,name,gender, DATEDIFF(DAY, joindate, GETDATE()) AS total_Days
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 11.
-- Display the joining date after adding 1 year.
SELECT employee_id,name,department,joindate, DATEADD(YEAR,1,joindate)AS after_1_year
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 12.
-- Display the joining date after adding 6 months.
SELECT employee_id,name,joindate, DATEADD(MONTH,6,joindate) AS after_6_month
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 13.
-- Display the joining date after adding 30 days.
SELECT employee_id,name,joindate, DATEADD(DAY,30,joindate)AS after_30_days
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 14.
-- Display the joining date 1 year earlier.
SELECT employee_id, name, joindate, DATEADD(YEAR,-1,joindate)AS before_1_year
FROM Employee;
---------------------------------------------------------------------------------------------------
 
-- Question 15.
-- Display employees who joined more than 5 years ago.
SELECT employee_id,name,joindate
FROM Employee
WHERE joindate < DATEADD(YEAR,-5,GETDATE());
---------------------------------------------------------------------------------------------------

-- Question 16.
-- Display employees who joined in the last 2 years.
SELECT employee_id,joindate
FROM Employee
WHERE joindate >= DATEADD(YEAR,-2,GETDATE());
---------------------------------------------------------------------------------------------------

-- Question 17.
-- Display the day name of each employee's joindate.
SELECT employee_id,name,joindate, DATENAME(WEEKDAY, joindate) AS joining_day
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 18.
-- Display the month name of each employee's joindate.
SELECT employee_id,name,department,joindate, DATENAME(MONTH, joindate) AS month_joined
FROM Employee;
---------------------------------------------------------------------------------------------------

-- Question 19.
-- Display employees who joined on a weekend.
SELECT employee_id,name,department,joindate
FROM Employee
WHERE DATENAME(WEEKDAY, joindate) IN('SATURDAY','SUNDAY');
---------------------------------------------------------------------------------------------------

-- Question 20.
-- Calculate the number of days between each employee's joindate and today.
SELECT employee_id,name,joindate, DATEDIFF(DAY, joindate, GETDATE()) AS days_worked
FROM Employee;

---------------------------------------------------------------------------------------------------

