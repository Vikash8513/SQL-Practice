/*
===================================================================================================
Topic      : View
Database   : Employee and Customer Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Create a view that displays all customers.
-- Output: CustomerID, CustomerName, City, CustomerSegment.
CREATE VIEW V_Customer AS
SELECT 
       CustomerID,
       CustomerName,
       City,
       CustomerSegment
FROM Customers;
GO
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Create a view and display Premium Customers
-- Output: CustomerID, CustomerName, City, CustomerSegment
CREATE VIEW V_PremiumCustomers AS 
SELECT
       CustomerID,
       CustomerName,
       City,
       CustomerSegment
FROM Customers
WHERE CustomerSegment = 'Corporate';
GO
---------------------------------------------------------------------------------------------------
-- Question 3.
-- Create a view containing products with a price greater than the average product price.
CREATE VIEW V_AboveAverageProducts AS
SELECT
    ProductID,
    ProductName,
    Category,
    UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);
GO
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Create a view containing order details.
-- Output: OrderID, OrderDate, CustomerName, ProductName, Quantity, UnitPrice, Discount.
CREATE VIEW OrderDetails AS
SELECT o.OrderID,
       o.OrderDate,
       c.CustomerName,
       p.ProductName,
       o.Quantity,
       o.UnitPrice,
       o.Discount
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Products p
ON o.ProductID = p.ProductID
GO
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Create a view showing each customer and their total spending.
-- Output: CustomerID, CustomerName, TotalSpend.
CREATE VIEW CustomerSpending AS
SELECT c.CustomerID,
       c.CustomerName,
       o.Quantity * o.UnitPrice * (1-o.Discount/100.0) AS TotalSpends
FROM Customers c
INNER JOIN Orders O
ON c.CustomerID = o.CustomerID;
GO
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Create a view showing employee details with annual salary.
-- Output: EmployeeID, EmployeeName, Department, Salary, AnnualSalary.
CREATE VIEW EmployeeDetails AS
SELECT EmployeeID,
       CONCAT(FirstName,' ',LastName) AS EmployeeName,
       Department,
       Salary,
       Salary * 12 AS AnnualSalary
FROM Employees
GO
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Create a view showing products with a price category:
-- Price < 1000        → Low
-- 1000 to 5000        → Medium
-- Price > 5000        → High
-- Use CASE.
CREATE VIEW ProductPriceCategory AS
SELECT ProductID,
       ProductName,
       Category,
       UnitPrice,
CASE
    WHEN UnitPrice < 1000 THEN 'Low'
    WHEN UnitPrice < 5000 THEN 'Medium'
    ELSE 'High'
    END AS PriceCategoty
FROM Products;
GO
---------------------------------------------------------------------------------------------------      

-- Question 8.
-- Create a view showing customers who spent more than the average customer spending.
CREATE VIEW V_AboveAverageCustomers AS
WITH CustomerSpending AS (
SELECT c.CustomerID,
       c.CustomerName,
       SUM(o.UnitPrice * o.Quantity * (1-o.Discount/100.0)) AS TotalSpend
FROM Customers c
INNER JOIN Orders o
ON c.customerID = o.customerID
GROUP BY c.CustomerID,
         c.CustomerName
)
SELECT * FROM CustomerSpending
WHERE TotalSpend > (SELECT AVG(TotalSpend) FROM CustomerSpending);
GO
---------------------------------------------------------------------------------------------------           

-- Question 9.
-- Create a view showing the top 5 products based on total sales.
CREATE VIEW ProductSales AS
WITH TotalProductSales AS (
SELECT p.ProductID,
       p.ProductName,
       SUM(o.UnitPrice * o.Quantity * (1-o.Discount/100.0)) AS TotalSales
FROM Orders o
INNER JOIN Products p
ON o.ProductID = p.ProductID
GROUP BY p.ProductID,
         p.ProductName
)
SELECT TOP 5 * FROM TotalProductSales
ORDER BY TotalSales DESC;
GO
---------------------------------------------------------------------------------------------------           

-- Question 10.
-- Create a view showing each customer's most recent order.
-- Output: CustomerID, CustomerName, OrderID, OrderDate.
CREATE VIEW MostRecentOrder AS
WITH CustomerOrders AS (
SELECT c.CustomerID,
       c.CustomerName,
       o.OrderID,
       o.OrderDate,
       ROW_NUMBER() OVER(PARTITION BY c.CustomerID ORDER BY o.OrderDate DESC) AS ROWNUM
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
)
SELECT * FROM CustomerOrders
WHERE ROWNUM = 1;
GO
---------------------------------------------------------------------------------------------------                      

-- Question 11.
-- Create a view called vw_CustomerAnalysis containing:
-- CustomerID, CustomerName, CustomerSegment, NumberOfOrders, TotalQuantity, TotalSpend
CREATE VIEW V_CustomerAnalysis AS
SELECT c.CustomerID,
       c.CustomerName,
       c.CustomerSegment,
       COUNT(o.orderID)AS NumberOfOrders,
       SUM(o.Quantity) AS TotalQuantity, 
       SUM(o.UnitPrice * o.Quantity * (1-o.Discount/100.0)) AS TotalSpends
FROM Customers c
INNER JOIN Orders o
ON c.customerID = o.customerID
GROUP BY c.CustomerID,
         c.CustomerName,
         c.CustomerSegment;
GO
---------------------------------------------------------------------------------------------------           

-- Question 12.
-- Create a view called vw_EmployeeSalaryAnalysis containing:
-- EmployeeID, EmployeeName, Department, Salary, DepartmentAverageSalary, SalaryDifference
-- Use: AVG(Salary) OVER(PARTITION BY Department)
CREATE VIEW EmployeeSalaryAnalysis AS
WITH SalaryAnalysis AS (
SELECT EmployeeID,
       CONCAT(FirstName,' ',LastName) AS EmployeeName,
       Department,
       Salary,
       AVG(Salary)
       OVER(PARTITION BY Department) AS DeptAvgSalary
FROM Employees
)
SELECT EmployeeID,
       EmployeeName,
       Department,
       Salary,
       DeptAvgSalary,
       Salary - DeptAvgSalary AS SalaryDifference
FROM SalaryAnalysis;       
GO
---------------------------------------------------------------------------------------------------           

-- Question 13.
-- Create a comprehensive sales view:
-- contain: OrderID, OrderDate, CustomerID, CustomerName, CustomerSegment, ProductID, ProductName
-- Category, Quantity, UnitPrice, Discount, OrderAmount, CustomerTotalSpend, ProductTotalSales
-- Use: JOIN, Calculated columns, SUM() OVER(), PARTITION BY
CREATE VIEW V_ComprehensiveSales As
WITH SalesData AS(
SELECT o.OrderID,
       o.OrderDate,
       c.CustomerID,
       c.CustomerName,
       c.CustomerSegment,
       p.ProductID,
       p.ProductName,
       p.Category,
       o.Quantity,
       o.UnitPrice,
       o.Discount,
       o.UnitPrice * o.Quantity * (1-o.Discount/100.0) AS OrderValue
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Products p
ON o.productID = p.ProductID
)
SELECT OrderID,
       OrderDate,
       CustomerID,
       CustomerName,
       CustomerSegment,
       ProductID,
       ProductName,
       Category,
       Quantity,
       UnitPrice,
       Discount,
       OrderValue,
       SUM(OrderValue) OVER(PARTITION BY CustomerID) AS CustomerTotalSpend,
       SUM(OrderValue) OVER(PARTITION BY ProductID) AS ProductTotalSales
FROM SalesData;
GO
---------------------------------------------------------------------------------------------------           

-- Question 14.
-- Use ALTER VIEW to modify vw_PremiumCustomers so it displays:
-- CustomerID, CustomerName, City, CustomerSegment, Status
ALTER VIEW V_PremiumCustomers AS
SELECT
    CustomerID,
    CustomerName,
    City,
    CustomerSegment,
    Status
FROM Customers
WHERE CustomerSegment = 'Corporate';
---------------------------------------------------------------------------------------------------