/*
===================================================================================================
Topic      : CTE
Database   : Customer Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Create a CTE that displays all customers from the Premium customer segment.
WITH Premium_customer_segment AS(
SELECT * FROM Customers
WHERE CustomerSegment = 'Corporate')
SELECT * FROM Premium_customer_segment;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Create a CTE that calculates the total amount of each order.
WITH Discounted_order AS(
SELECT * FROM Orders
WHERE Discount > 10)
SELECT * FROM Discounted_order;
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Create a CTE that calculates the total amount of each order.
WITH Total_amount AS(
SELECT OrderID,
       Customerid,
       productid,
       quantity,
       unitprice,
       discount,
       unitprice*quantity * (1-discount/100) AS Total
FROM Orders)
SELECT * FROM Total_amount;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Using a CTE, display all products with a price greater than the average product price.
WITH Avg_price AS (
SELECT AVG(unitprice)AS Product_avg_price FROM Products)
SELECT * FROM Products
WHERE UnitPrice > (SELECT Product_avg_price FROM Avg_price);

-- FOR SPECIFIC COLUMN
WITH Avg_price AS(
SELECT AVG(unitprice)AS Product_avg_price 
FROM Products)
SELECT productid,
       productname,
       unitprice
FROM Products
WHERE unitprice > (SELECT product_avg_price FROM Avg_price);
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Create a CTE to find all customers who have placed at least one order.
WITH CustomersWithOrders AS(
SELECT DISTINCT CustomerID
FROM Orders)
SELECT c.CustomerID,
       c.CustomerName
FROM Customers c
INNER JOIN CustomersWithOrders co
 ON c.CustomerID = co.CustomerID;
 --------------------------------------------------------------------------------------------------

-- Question 6.
-- Create a CTE to calculate total spending for each customer.
With Customers_spending AS(
SELECT c.customerid,
       c.customername,
       SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_spends
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.customername)
SELECT * FROM Customers_spending
ORDER BY Total_spends DESC;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Using a CTE, find customers whose total spending is greater than 50,000.
With Customers_spending AS(
SELECT c.customerid,
       c.customername,
       SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_spends
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.customername)
SELECT * FROM Customers_spending
WHERE Total_spends > 50000
ORDER BY Total_spends DESC;
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Create a CTE to calculate total sales for each product.
WITH Sales AS(
SELECT p.ProductID,
       p.productname,
       SUM(o.unitprice * o.quantity * (1-o.Discount/100)) AS Total_sales
FROM Orders o
INNER JOIN Products p
ON o.ProductID = p.ProductID
GROUP BY p.productid,
         p.productname)
SELECT * FROM Sales
ORDER BY Total_sales DESC;
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Using a CTE, find the top 5 products based on total sales.
WITH Sales AS(
SELECT p.productid,
       p.productname,
       SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_sales
FROM Products p
INNER JOIN Orders o
ON p.ProductID = o.ProductID
GROUP BY p.ProductID,
         p.ProductName)
SELECT TOP 5 * FROM Sales
ORDER BY Total_sales DESC;
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Create a CTE to calculate total sales for each city.
WITH Citywise_sale AS(
SELECT c.city,
       SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_sales
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.City)
SELECT * FROM Citywise_sale
ORDER BY Total_sales DESC;
---------------------------------------------------------------------------------------------------

-- Question 11.
-- Create a CTE containing: OrderID,CustomerName,ProductName,Quantity,TotalAmount.
WITH OrderDetails AS (
SELECT o.OrderID,
       c.CustomerName,
       p.ProductName,
       o.Quantity,
       o.UnitPrice,
       o.Discount,
       o.unitprice * o.quantity * (1-o.discount/100) AS Total_Amount
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Products p
ON o.ProductID = p.ProductID)
SELECT * FROM OrderDetails;
---------------------------------------------------------------------------------------------------

-- Question 12.
-- Using a CTE, find customers who purchased products from the Electronics category.
WITH Electronics_customers AS(
SELECT c.customerid,
       c.customername
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
INNER JOIN Products p
ON o.ProductID = p.ProductID
WHERE p.Category = 'Electronics')
SELECT * FROM Electronics_customers;
---------------------------------------------------------------------------------------------------

-- Question 13.
-- Create a CTE to calculate the total number of orders placed by each customer.
-- Then display customers who placed more than 3 orders
WITH CustomerOrders AS(
SELECT CustomerID,
       COUNT(OrderID) AS NumberOfOrders
FROM Orders
GROUP BY CustomerID)
SELECT c.CustomerID,
       c.CustomerName,
       co.NumberOfOrders
FROM CustomerOrders co
INNER JOIN Customers c
ON co.CustomerID = c.CustomerID
WHERE co.NumberOfOrders > 3
ORDER BY co.NumberOfOrders DESC;
---------------------------------------------------------------------------------------------------

-- Question 14.
-- Create a CTE to calculate the total quantity sold for each product.
-- Then find products with total quantity greater than 20.
WITH Product_quantity AS (
SELECT ProductID,
       SUM(quantity) AS Total_quantity
FROM Orders 
GROUP BY ProductID)
SELECT p.productID,
       p.productname,
       pq.Total_quantity
FROM Products p
INNER JOIN Product_quantity pq
ON p.ProductID = pq.ProductID
WHERE Total_quantity > 20;
---------------------------------------------------------------------------------------------------

-- Question 15.
-- Create a CTE to calculate total sales by SalesChannel.
-- Then display the sales channel with the highest sales.
WITH channel AS (
SELECT SalesChannel,
       SUM(unitprice * quantity * (1-discount/100)) AS Total_sales
FROM Orders
GROUP BY SalesChannel)
SELECT TOP 1 * FROM channel
ORDER BY Total_sales DESC;
---------------------------------------------------------------------------------------------------

-- Question 16.
-- Create two CTEs:
-- CustomerSpend → Total spending for each customer.
-- AverageSpend → Average customer spending.
-- Then find customers whose spending is greater than the average spending.
WITH Customer_spend AS (
SELECT c.CustomerID,
       c.CustomerName,
       SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_Spending
FROM Customers c
INNER JOIN Orders o
ON C.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.CustomerName),

Average_spending AS (
SELECT AVG(Total_Spending) AS Avg_spending
FROM Customer_spend)

SELECT cs.customerid,
       cs.customername,
       cs.Total_spending
FROM Customer_spend cs
CROSS JOIN Average_spending a
WHERE cs.Total_Spending > a.Avg_spending
ORDER BY Total_Spending DESC;
---------------------------------------------------------------------------------------------------

-- Question 17.
-- Create two CTEs:
-- ProductSales → Total sales for each product.
-- AverageProductSales → Average sales across products.
-- Find products with sales above average.
WITH Product_sales AS (
SELECT p.ProductID,
       p.ProductName,
       SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_sales
FROM Products p
INNER JOIN Orders o
ON p.ProductID = o.ProductID
GROUP BY p.ProductID,
         p.ProductName),

Average_product_sales AS (
SELECT AVG(Total_sales) AS Avg_sale
FROM Product_sales)
SELECT ps.ProductID,
       ps.ProductName,
       ps.Total_sales
FROM Product_sales ps
CROSS JOIN Average_product_sales A
WHERE Total_sales > Avg_sale
ORDER BY ps.Total_sales;
---------------------------------------------------------------------------------------------------

-- Question 18.
-- Create two CTEs:
-- CustomerOrders → Number of orders for each customer.
-- AverageOrders → Average number of orders.
-- Find customers who placed more orders than average.
WITH CustomerOrders AS (
SELECT CustomerID,
COUNT(OrderID) AS NumberOfOrders
FROM Orders
GROUP BY CustomerID),

AverageOrders AS(
SELECT AVG(NumberOfOrders) AS AvgOrders
FROM CustomerOrders)
 
SELECT
    c.CustomerID,
    c.CustomerName,
    co.NumberOfOrders
FROM CustomerOrders co
INNER JOIN Customers c
ON co.CustomerID = c.CustomerID
CROSS JOIN AverageOrders a
WHERE co.NumberOfOrders > a.AvgOrders
ORDER BY co.NumberOfOrders DESC;
---------------------------------------------------------------------------------------------------

-- Question 19.
-- Using a CTE, find the customer with the highest total spending.
WITH Customer_spending AS (
SELECT CustomerID,
       SUM(unitprice * quantity * (1-discount/100)) AS Total_spending
FROM Orders
GROUP BY CustomerID
)
SELECT TOP 1 c.CustomerID,
             c.CustomerName,
             cs.Total_spending
FROM Customers c
INNER JOIN Customer_spending cs
ON c.CustomerID = cs.CustomerID
ORDER BY Total_spending DESC;
---------------------------------------------------------------------------------------------------

-- Question 20.
-- Using a CTE, find the product with the highest total sales.
WITH Maximum_sale AS (
SELECT TOP 1 p.productid,
             p.ProductName,
             SUM(o.unitprice * o.quantity * (1-o.discount/100.0)) AS Total_sale
FROM Products p
INNER JOIN Orders o
ON p.ProductID = o.ProductID
GROUP BY p.ProductID , p.ProductName
ORDER BY Total_sale DESC
)
SELECT * FROM Maximum_sale;
---------------------------------------------------------------------------------------------------

-- Question 21.
-- Create a CTE containing all orders and their calculated TotalAmount.
-- Then find the order with the highest value.
WITH OrderValue AS(
SELECT  OrderID,
        CustomerID,
        ProductID,
        Quantity * UnitPrice * (1 - Discount / 100.0) AS TotalAmount
FROM Orders
)
SELECT TOP 1 *
FROM OrderValue
ORDER BY TotalAmount DESC;
---------------------------------------------------------------------------------------------------

-- Question 22.
-- Create a CTE that calculates total sales for each city.
-- Then find the city generating the highest sales.
WITH City_sales AS (
SELECT c.City,
       SUM(o.unitprice * o.quantity * (1-o.discount/100.0)) AS Total_sales
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.City
)
SELECT TOP 1 * FROM City_sales
ORDER BY Total_sales DESC;
---------------------------------------------------------------------------------------------------

-- Question 23.
-- Create a CTE to calculate total sales for each customer segment.
-- Then find the highest-performing customer segment.
WITH Segment_sale AS (
SELECT c.CustomerSegment,
       SUM(o.unitprice * o.quantity * (1-o.discount/100.0)) AS Total_sales
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerSegment
)
SELECT TOP 1 * FROM Segment_sale
ORDER BY Total_sales DESC;
---------------------------------------------------------------------------------------------------

-- Question 24.
-- Using a CTE, find customers who have spent more than the average customer spending.
WITH Customer_spend AS (
SELECT c.CustomerID,
       c.CustomerName,
       SUM(o.Quantity * o.Unitprice * (1-o.Discount/100.0)) AS Total_sales
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.CustomerName
)
SELECT * FROM Customer_spend
WHERE Total_sales > (SELECT AVG(Total_sales) AS Avg_sale FROM Customer_spend)
ORDER BY Total_sales DESC;
---------------------------------------------------------------------------------------------------

-- Question 25.
-- Create a CTE containing: CustomerID, CustomerName, NumberOfOrders, TotalQuantity, TotalSpend
-- Then display only customers whose: Number of Orders > 3, Total Spend > 50,000
WITH Customer_details AS (
SELECT c.CustomerID,
       c.CustomerName,
       COUNT(o.orderid) AS Order_count,
       SUM(o.quantity) AS Total_quantity,
       SUM(o.unitprice * o.quantity * (1-o.discount/100.0)) AS Total_spends
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.CustomerName
)
SELECT * FROM Customer_details
WHERE Order_count > 3
AND Total_spends > 50000
ORDER BY Total_spends DESC;
---------------------------------------------------------------------------------------------------

-- Question 26.
-- Display the employee hierarchy starting from top-level employees whose ManagerID IS NULL.
-- Output: EmployeeID | EmployeeName | ManagerID | HierarchyLevel
WITH EmployeeHierarchy AS(
SELECT  EmployeeID,
        CONCAT(FirstName, ' ', LastName) AS EmployeeName,
        ManagerID,
        1 AS HierarchyLevel
 FROM Employees
 WHERE ManagerID IS NULL

 UNION ALL

 SELECT e.EmployeeID,
        CONCAT(e.FirstName, ' ', e.LastName),
        e.ManagerID,
        eh.HierarchyLevel + 1
 FROM Employees e
 INNER JOIN EmployeeHierarchy eh
 ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy
ORDER BY HierarchyLevel, EmployeeID;
---------------------------------------------------------------------------------------------------
