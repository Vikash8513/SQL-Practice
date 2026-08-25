/*
===================================================================================================
Topic      : Temporary Tables
Database   : Customer Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Create a temporary table containing: CustomerID, CustomerName, City, CustomerSegment.
-- Name it: #CustomerTemp
SELECT CustomerID,
	   CustomerName,
	   City,
	   CustomerSegment
INTO #CustomerTemp
FROM Customers;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Create a temporary table containing all Premium customers.
-- Name: #PremiumCustomers
-- Use SELECT INTO
SELECT CustomerID,
	   CustomerName,
	   City,
	   CustomerSegment
INTO #PremiumCustomers
FROM Customers
WHERE CustomerSegment = 'Corporate'
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Create a temporary table manually using: CREATE TABLE #TempTable
-- Add these columns: EmployeeID, EmployeeName, Department, Salary
CREATE TABLE #TempTable (
EmployeeID INT,
EmployeeName VARCHAR (50),
Department VARCHAR (20),
Salary DECIMAL (10,2) );
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Create a temporary table containing order amounts.
-- Columns: OrderID, CustomerID, ProductID, OrderAmount
-- Name: #OrderAmount
SELECT OrderID,
	   CustomerID,
	   ProductID,
	   Quantity * UnitPrice * (1-Discount/100.0) AS OrderAmount
INTO #OrderAmount
FROM Orders;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Create a temporary table containing product sales.
-- Columns: ProductID, TotalQuantitySold, TotalSales
-- Name: #ProductSales
SELECT ProductID,
	   SUM(Quantity)AS TotalQuantity,
	   SUM(Quantity * UnitPrice * (1-Discount/100.0)) AS TotalSales
INTO #ProductSales
FROM Orders
GROUP BY ProductID;
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Create a temporary table containing the top 3 highest-priced products in each category.
WITH HighestPricesProduct AS (
SELECT ProductID,
       ProductName,
	   Category,
	   UnitPrice,	   
	   DENSE_RANK () OVER ( PARTITION BY Category ORDER BY UnitPrice DESC) AS PriceRank
FROM Products
)
SELECT ProductID,
       ProductName,
	   Category,
	   UnitPrice	   
INTO #Top3
FROM HighestPricesProduct
WHERE PriceRank <=3;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Create a temporary table containing each customer's:
-- CustomerID, TotalSpend, SpendingRank
WITH CustomerDetails AS (
SELECT CustomerID,
       SUM(Quantity * UnitPrice * (1-Discount/100.0)) AS TotalSpend
FROM Orders
GROUP BY CustomerID
)
SELECT CustomerID,
       TotalSpend,
	   DENSE_RANK () OVER (ORDER BY TotalSpend) AS SpendingRanking
INTO #CustomerRanking
FROM CustomerDetails;
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Create a temporary table containing each customer's:
-- CustomerID, CustomerName, TotalSpend, CustomerSegment
SELECT c.CustomerID,
       c.CustomerName,
	   c.CustomerSegment,
	   SUM(o.UnitPrice * o.Quantity * (1-o.Discount/100.0)) AS TotalSpend
INTO #CustomerSpending
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.CustomerName,
	     c.CustomerSegment ;

-- Then create a second temporary table containing only customers who spent more than 50,000.
SELECT CustomerID,
       CustomerName,
	   CustomerSegment,
	   TotalSpend
INTO #HighValue
FROM #CustomerSpending
WHERE TotalSpend > 50000;
---------------------------------------------------------------------------------------------------
