/* 
===================================================================================================
Topic      : Windows
Database   : Customer Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Assign a unique row number to every customer based on CustomerID.
-- Output: CustomerID, CustomerName, RowNumber
SELECT CustomerID,
       CustomerName,
       ROW_NUMBER() OVER (ORDER BY CustomerID) AS RowNumber
FROM Customers;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Assign a row number to customers based on their total spending, from highest to lowest.
-- Output: CustomerID, CustomerName, TotalSpend, RowNumber (PARTION BY CUSTOMER SEGMENT)
WITH Customers_spending AS (
SELECT c.CustomerID,
       c.CustomerName,
       c.customersegment,
       SUM(o.unitprice * o.quantity * (1-o.discount/100.0)) AS Total_spends
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.CustomerName,
         c.customersegment
)
SELECT CustomerID,
       CustomerName,
       CustomerSegment,
       Total_spends,
ROW_NUMBER() OVER (PARTITION BY Customersegment ORDER BY Total_spends DESC, Customerid DESC) AS Row_num
FROM Customers_spending;


-- WITHOUT WTE
SELECT c.CustomerID,
       c.CustomerName,
       c.CustomerSegment,
       SUM(o.UnitPrice * o.Quantity * (1 - o.Discount/100.0)) AS Total_Spends,
       ROW_NUMBER() OVER (
           PARTITION BY c.CustomerSegment 
           ORDER BY SUM(o.UnitPrice * o.Quantity * (1 - o.Discount/100.0)) DESC) AS Row_Num
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.CustomerName,
         c.CustomerSegment;
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Rank products based on their price from highest to lowest.
-- Output: ProductID, ProductName, Price, ProductRank
SELECT ProductID,
       ProductName,
       UnitPrice,
       RANK () OVER (ORDER BY UnitPrice DESC) AS Product_Rank
FROM Products;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Assign a dense rank to employees based on salary from highest to lowest.
-- Output: EmployeeID, EmployeeName, Salary, SalaryRank
SELECT EmployeeID,
       CONCAT(firstname,' ',lastname) AS EmployeeName,
       Salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS Salary_Rank
FROM Employees;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Display employees with both RANK() and DENSE_RANK() based on salary.
-- Output: EmployeeName, Salary, Rank, DenseRank
SELECT CONCAT(FirstName,' ',LastName) AS Employee_Name,
       Salary,
       RANK() OVER (ORDER BY Salary DESC) AS Salary_Rank,
       DENSE_RANK () OVER (ORDER BY Salary DESC) AS Salary_DenseRank
FROM Employees;

-- For Partition BY Department
SELECT CONCAT(FirstName,' ',LastName) AS Employee_Name,
       Salary,
       Department,
       RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS Salary_Rank,
       DENSE_RANK () OVER (PARTITION BY Department ORDER BY Salary DESC) AS Salary_DenseRank
FROM Employees;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Assign a row number to employees within each department based on salary from highest to lowest.
-- Output: EmployeeName, Department, Salary, RowNumber
SELECT EmployeeID,
       CONCAT(FirstName,' ',LastName) AS FullName,
       Department,
       Salary,
       ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS Row_Num
FROM Employees;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Rank products within each category based on price from highest to lowest.
-- Output: ProductName, Category, Price, ProductRank
SELECT ProductName,
       Category,
       UnitPrice,
       RANK() OVER (ORDER BY UnitPrice DESC) AS ProductRank
FROM Products;
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Assign a row number to each order within each customer based on OrderDate.
-- Output: CustomerID, OrderID, OrderDate, OrderNumber
SELECT CustomerID,
       OrderID,
       OrderDate,
       ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS Order_num
FROM Orders;
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Rank employees within each department based on salary.
-- Use DENSE_RANK().
-- Output: EmployeeName, Department, Salary, SalaryRank
SELECT EmployeeID,
       CONCAT(FirstName,' ',LastName) AS FullName,
       Department,
       Salary,
       DENSE_RANK() OVER ( PARTITION BY Department ORDER BY Salary DESC) AS Salary_Rank
FROM Employees;
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Divide employees into salary groups using NTILE(4).
-- Output: EmployeeName, Salary, SalaryQuartile
SELECT CONCAT(FirstName,' ',LastName) AS FullName,
       Salary,
       NTILE (4) OVER(ORDER BY Salary) AS Salary_Quartile
FROM Employees;
---------------------------------------------------------------------------------------------------

-- Question 11.
-- Display each order along with the total sales of all orders.
-- Output: OrderID, OrderAmount, TotalSales
-- Use: SUM(), OVER()
WITH OrderAmount AS (
SELECT OrderID,
       UnitPrice * Quantity * (1-Discount/100.0) AS OrderValue
FROM Orders
)
SELECT OrderID,
       OrderValue,
       SUM(OrderValue) OVER() AS TotalSales
FROM OrderAmount;
---------------------------------------------------------------------------------------------------

-- Question 12.
-- Display each order along with the average order value.
-- Output: OrderID, OrderAmount, AverageOrderValue
WITH OrderValue AS (
SELECT OrderID,
       UnitPrice * Quantity * (1-Discount/100.0) AS OrderValue
FROM Orders
)
SELECT OrderID,
       OrderValue,
       AVG(OrderValue) OVER () AS AvgOrderValue
FROM OrderValue
GROUP BY OrderID,
         OrderValue;
---------------------------------------------------------------------------------------------------

-- Question 13.
-- Display each product along with the average product price.
-- Output: ProductID, ProductName, Price, AveragePrice
SELECT ProductID,
       ProductName,
       UnitPrice,
       AVG(UnitPrice) OVER () AS AvgPrice
FROM Products;
---------------------------------------------------------------------------------------------------

-- Question 14.
-- Display each employee along with the average salary of their department.
-- Output: EmployeeName, Department, Salary, DepartmentAverageSalary
SELECT CONCAT(FirstName,' ',LastName) AS FullName,
       Department,
       Salary,
       AVG(salary) OVER( PARTITION BY Department) AS Dept_Avg_salary
FROM Employees;
---------------------------------------------------------------------------------------------------

-- Question 15.
-- Display each customer order along with the total spending of that customer.
-- Output: CustomerID, OrderID, OrderAmount, CustomerTotalSpend
WITH OrderAmount AS (
SELECT CustomerID,
       OrderID,
       Quantity * UnitPrice * (1 - Discount/100.0) OrderValue
FROM Orders
)
SELECT CustomerID,
       OrderID,
       OrderValue,
       SUM(OrderValue) OVER(PARTITION BY CustomerID) AS CustomerTotalspend
FROM OrderAmount;
---------------------------------------------------------------------------------------------------

-- Question 16.
-- Calculate the running total of sales based on OrderDate.
-- Output: OrderID, OrderDate, OrderAmount, RunningTotal
WITH OrderAmount AS (
SELECT OrderID,
       OrderDate,
       Quantity * UnitPrice * (1 - Discount/100.0) AS OrderValue

FROM Orders
)
SELECT
    OrderID,
    OrderDate,
    OrderValue,
    SUM(OrderValue) 
    OVER(ORDER BY OrderDate, OrderID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM OrderAmount;
---------------------------------------------------------------------------------------------------

-- Question 17.
-- Calculate the running total of spending for each customer.
-- Use PARTITION BY CustomerID.
-- Output: CustomerID, OrderID, OrderDate, OrderAmount, RunningTotal
SELECT CustomerID,
       OrderID,
       OrderDate,
       Quantity * UnitPrice * (1 - ISNULL(Discount, 0) / 100) AS OrderAmount,
       SUM(Quantity * UnitPrice * (1 - ISNULL(Discount, 0) / 100))
       OVER (PARTITION BY CustomerID ORDER BY OrderDate, OrderID ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM Orders;
---------------------------------------------------------------------------------------------------

-- Question 18.
-- Calculate the running quantity sold for each product.
-- Output: ProductID, OrderID, Quantity, RunningQuantity
SELECT ProductID,
       OrderID,
       Quantity,
       SUM(Quantity) OVER( PARTITION BY ProductID ORDER BY OrderID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningQuantity
FROM Orders;
---------------------------------------------------------------------------------------------------

-- Question 19.
-- Display each order and the previous order amount.
-- Output: OrderID, OrderDate, OrderAmount, PreviousOrderAmount
WITH OrderAmount AS(
SELECT  OrderID,
        OrderDate,
        Quantity * UnitPrice * (1 - Discount / 100.0) AS OrderAmount
FROM Orders
)
SELECT
    OrderID,
    OrderDate,
    OrderAmount,
    LAG(OrderAmount) OVER(ORDER BY OrderDate, OrderID) AS PreviousOrderAmount
FROM OrderAmount;
---------------------------------------------------------------------------------------------------

-- Question 20.
-- Display each order and the next order amount.
-- Output: OrderID, OrderDate, OrderAmount, NextOrderAmount
WITH OrderAmount AS (
SELECT OrderID,
       OrderDate,
       UnitPrice * Quantity * (1-Discount/100) AS OrderValue
FROM Orders
)
SELECT OrderID,
       OrderDate,
       OrderValue,
       LEAD(OrderValue) OVER (ORDER BY OrderDate,OrderID) AS NextOrder
FROM OrderAmount;
---------------------------------------------------------------------------------------------------

-- Question 21.
-- Display each employee's salary along with the previous employee's salary.
-- Order employees by salary.
-- Output: EmployeeName, Salary, PreviousSalary
SELECT EmployeeID,
       CONCAT(FirstName,' ',LastName) AS FullName,
       Salary,
       LAG(salary,1,0) OVER(PARTITION BY Department ORDER BY Salary DESC) AS PreviousSalary
FROM Employees;
---------------------------------------------------------------------------------------------------

-- Question 22.
-- Compare each order's sales amount with the previous order.
-- Output: OrderID, OrderAmount, PreviousOrderAmount, Difference
WITH OrderAmount AS (
SELECT OrderID,
       UnitPrice * Quantity * (1-Discount/100.0) AS OrderValue
FROM Orders
),
PreviousOrder AS(
SELECT OrderID,
       OrderValue,
       LAG(OrderValue) OVER(ORDER BY OrderID) AS PreviousOrderValue
FROM OrderAmount
)
SELECT OrderID,
       OrderValue,
       PreviousOrderValue,
       OrderValue - PreviousOrderValue AS Difference
FROM PreviousOrder;
---------------------------------------------------------------------------------------------------

-- Question 23.
-- Find the difference between each employee's salary and the average salary of their department.
-- Use: AVG(Salary), OVER(PARTITION BY Department)
WITH EmployeeSalary AS (
SELECT EmployeeID,
       CONCAT(FirstName,' ',LastName) AS EmployeeName,
       Department,
       Salary,
       AVG(salary) OVER(PARTITION BY Department) AS DepartmentAvgSalary
FROM Employees
)
SELECT EmployeeID,
       EmployeeName,
       Department,
       Salary,
       DepartmentAvgSalary,
       Salary - DepartmentAvgSalary AS SalaryDifferences
FROM EmployeeSalary;
---------------------------------------------------------------------------------------------------

-- Question 24.
-- Find the top 3 highest-priced products in each category.
-- Use: DENSE_RANK(), OVER(PARTITION BY Category ORDER BY Price DESC)
WITH ProductRanking AS (
SELECT ProductID,
       ProductName,
       Category,
       UnitPrice,
       DENSE_RANK() OVER (PARTITION BY Category ORDER BY UnitPrice DESC) AS ProductRank
FROM Products
)
SELECT * FROM ProductRanking
WHERE ProductRank <= 3;
---------------------------------------------------------------------------------------------------

-- Question 25.
-- Find the top 2 highest-paid employees in each department.
-- Use RANK() or DENSE_RANK().
WITH EmployeeRanking AS (
SELECT EmployeeID,
       CONCAT(FirstName,' ',LastName) AS EmployeeName,
       Department,
       Salary,
       DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
FROM Employees
)
SELECT * FROM EmployeeRanking
WHERE SalaryRank <= 2;
---------------------------------------------------------------------------------------------------

-- Question 26.
-- Find each customer's most recent order.
-- Use: ROW_NUMBER(), OVER(PARTITION BY CustomerID ORDER BY OrderDate DESC)
WITH CustomerOrder AS (
SELECT CustomerID,
       OrderID,
       OrderDate,
       ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY OrderDate DESC, OrderID DESC) AS RecentOrder
FROM Orders
)
SELECT * FROM CustomerOrder
WHERE RecentOrder = 1;


---------------------------------------------------------------------------------------------------

-- Question 27.
-- Find each customer's first order.
-- Use ROW_NUMBER().
WITH CustomerOrder AS (
SELECT CustomerID,
       OrderID,
       OrderDate,
       ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY OrderDate ASC, OrderID ASC) AS OrderNumber
FROM Orders
)
SELECT * FROM CustomerOrder
WHERE OrderNumber = 1;
---------------------------------------------------------------------------------------------------

-- Question 28.
-- Find the second highest-paid employee in each department.
-- Use DENSE_RANK().
WITH EmployeeSalary AS (
SELECT EmployeeID,
       CONCAT(FirstName,' ',LastName) AS EmployeeName,
       Department,
       Salary,
       DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS SalaryRanking
FROM Employees
)
SELECT * FROM EmployeeSalary
WHERE SalaryRanking = 2;
---------------------------------------------------------------------------------------------------

-- Question 29.
-- For each product, find the order with the highest quantity.
-- Use: ROW_NUMBER(), OVER(PARTITION BY ProductID ORDER BY Quantity DESC)
WITH ProductQuantity AS (
SELECT ProductID,
       OrderID,
       Quantity,
       ROW_NUMBER() OVER( PARTITION BY ProductID ORDER BY Quantity DESC) AS RowNum
FROM Orders
)
SELECT ProductID,
       OrderID,
       Quantity
FROM ProductQuantity
WHERE RowNum = 1;
---------------------------------------------------------------------------------------------------

-- Question 30. 
-- Create a customer sales analysis showing:
-- CustomerID, CustomerName, OrderID, OrderAmount, CustomerTotalSpend, CustomerAverageOrder, OrderRank
WITH OrderAnalysis AS (
SELECT  c.CustomerID,
        c.CustomerName,
        o.OrderID,
        o.OrderDate,
        o.Quantity * o.UnitPrice * (1 - o.Discount / 100.0) AS OrderAmount
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
)

SELECT
    CustomerID,
    CustomerName,
    OrderID,
    OrderAmount,

    SUM(OrderAmount) OVER(PARTITION BY CustomerID) AS CustomerTotalSpend,

    AVG(OrderAmount) OVER(PARTITION BY CustomerID) AS CustomerAverageOrder,

    RANK() OVER(PARTITION BY CustomerID ORDER BY OrderAmount DESC) AS OrderRank
FROM OrderAnalysis
ORDER BY CustomerID, OrderRank;
---------------------------------------------------------------------------------------------------