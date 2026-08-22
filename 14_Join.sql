/*
===================================================================================================
Topic      : Join
Database   : Customer Management System
SQL Server : Microsoft SQL Server
===================================================================================================
*/

-- Question 1.
-- Display the CustomerName and OrderID for every order.
SELECT c.customerid,
       c.customername,
       o.orderid       
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;
---------------------------------------------------------------------------------------------------

-- Question 2.
-- Display the OrderID, CustomerName, City, OrderDate.
SELECT o.orderid,
       c.customername,
       c.city,
       o.orderdate
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;
---------------------------------------------------------------------------------------------------

-- Question 3.
-- Display OrderID, CustomerName, ProductName, Quantity.
SELECT o.orderid,
       c.customername,
       p.productname,
       o.quantity
FROM Orders o
INNER JOIN Customers c
ON c.CustomerID = o.CustomerID
INNER JOIN Products p
ON o.ProductID = p.ProductID;
---------------------------------------------------------------------------------------------------

-- Question 4.
-- Display OrderID, ProductName, UnitPrice, Quantity, TotalAmount.
SELECT o.orderid,
       p.productName,
       o.unitprice,
       o.quantity,
       o.unitprice * o.quantity AS Total_Amount
FROM Orders o
INNER JOIN Products p
ON o.ProductID = p.ProductID;
---------------------------------------------------------------------------------------------------

-- Question 5.
-- Display Paid orders with Customername, Productname and orderStatus.
SELECT o.orderid,
       c.CustomerName,
       p.ProductName,
       o.OrderStatus
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Products p
ON o.ProductID = p.ProductID
WHERE o.OrderStatus = 'Paid';
---------------------------------------------------------------------------------------------------

-- Question 6.
-- Display OrderID, Customerid, CustomerName, Productid, ProductName, Category, Quantity, UnitPrice, Discount, Total Amount after Discount.
SELECT o.orderid,
       c.CustomerID,
       c.CustomerName,
       p.ProductID,
       p.ProductName,
       p.Category,
       o.ProductID,
       o.UnitPrice,
       o.Discount,
       o.UnitPrice * o.Quantity * (1-o.Discount/100) AS Total_Amount
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Products p
ON o.ProductID = p.ProductID;
---------------------------------------------------------------------------------------------------

-- Question 7.
-- Display Total spending of each customer.
SELECT c.CustomerID,
       c.CustomerName,
       SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_spending
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY Total_spending DESC;
---------------------------------------------------------------------------------------------------

-- Question 8.
-- Display Total quantity sold for each product.
SELECT p.productid,
       p.ProductName,
       SUM(o.quantity) AS Total_Quantity
FROM Products p
INNER JOIN Orders o
ON p.ProductID = o.ProductID
GROUP BY p.ProductID,
         p.ProductName
ORDER BY Total_Quantity DESC;
---------------------------------------------------------------------------------------------------

-- Question 9.
-- Display Total sales for each product after discount.
SELECT p.ProductID,
       p.ProductName,
       SUM(o.UnitPrice * o.Quantity * (1-o.Discount/100)) AS Total_Sales
FROM Products p
INNER JOIN Orders o
ON p.ProductID = o.ProductID
GROUP BY p.ProductID, 
         p.ProductName
ORDER BY Total_Sales DESC;
---------------------------------------------------------------------------------------------------

-- Question 10.
-- Display all customers, including customers who have never placed an order.
SELECT c.CustomerID,
       c.CustomerName,
       o.OrderID
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;
---------------------------------------------------------------------------------------------------

-- Question 11.
-- Find customers who have never placed an order.
SELECT c.CustomerID,
       c.CustomerName
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
---------------------------------------------------------------------------------------------------

-- Question 12.
-- Display all products, including products that have never been ordered.
SELECT p.ProductID,
       p.ProductName,
       o.OrderID
FROM Products p
LEFT JOIN Orders o
ON p.ProductID = o.ProductID
ORDER BY p.ProductID;
---------------------------------------------------------------------------------------------------

-- Question 13.
-- Find products that have never been ordered.
SELECT p.ProductID,
       p.ProductName
FROM Products p
LEFT JOIN Orders o
ON P.ProductID = o.ProductID
WHERE o.OrderID IS NULL;
---------------------------------------------------------------------------------------------------

-- Question 14.
-- Top 5 customers based on total spending.
SELECT TOP 5 c.customerid,
             c.customername,
             SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_Spending
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.CustomerName
ORDER BY Total_Spending DESC;
---------------------------------------------------------------------------------------------------

-- Question 15.
-- Product with the highest total quantity sold.
SELECT TOP 1 p.ProductID,
             P.ProductName,
             SUM(o.quantity) AS Total_Quantity
FROM Products p
JOIN Orders o
ON P.ProductID = O.ProductID
GROUP BY p.ProductID,
         p.ProductName
ORDER BY Total_Quantity DESC;
---------------------------------------------------------------------------------------------------

-- Question 16.
-- Total sales for each CustomerSegment.
SELECT c.CustomerSegment,
       SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_sales
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerSegment
ORDER BY Total_sales DESC;
---------------------------------------------------------------------------------------------------

-- Question 17.
-- Total sales for each SalesChannel
SELECT o.SalesChannel,
       SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_sales
FROM Orders O
Group BY o.SalesChannel
ORDER BY Total_sales DESC;
---------------------------------------------------------------------------------------------------

-- Question 18.
-- Find customers whose total spending is greater than ₹50,000.
SELECT c.customerid,
       c.customername,
       SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_spend
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.CustomerName
HAVING SUM(o.unitprice * o.quantity * (1-o.discount/100)) > 50000
ORDER BY Total_spend DESC;
---------------------------------------------------------------------------------------------------

-- Question 19.
-- Customers who have placed more than 3 orders.
SELECT c.customerid,
       c.customername,
       COUNT(o.orderid) AS Order_Count
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.customerid,
         c.customername
HAVING COUNT(o.orderid) > 3
ORDER BY Order_Count DESC;
---------------------------------------------------------------------------------------------------

-- Question 20.
-- Customers whose total spending is greater than the average customer spending.
WITH Customer_spending AS(
SELECT c.customerid,
       c.customername,
       SUM(o.unitprice * o.quantity * (1-o.discount/100)) AS Total_spends
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.CustomerName)

SELECT customerid,
       customername,
       Total_spends
FROM Customer_spending
WHERE Total_spends > (SELECT AVG(Total_spends) FROM Customer_spending)
ORDER BY Total_spends DESC;
---------------------------------------------------------------------------------------------------

-- Question 21.
-- Customers who purchased Electronics.
SELECT c.CustomerID,
       c.CustomerName
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
INNER JOIN Products p
ON o.ProductID = p.ProductID
WHERE p.Category = 'Electronics';
---------------------------------------------------------------------------------------------------

-- Question 22.
-- Customers who purchased more than one different product.
SELECT c.customerid,
       c.customername,
       COUNT(DISTINCT O.ProductID) As Diffrent_product
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.CustomerName
HAVING COUNT(DISTINCT O.ProductID) >1
---------------------------------------------------------------------------------------------------
 
 -- Question 23.
 -- Most frequently purchased product based on number of orders.
 SELECT TOP 1 p.productid,
              p.productname,
              COUNT(o.orderid) AS Number_of_orders
FROM Products p
INNER JOIN Orders o
ON p.ProductID = o.ProductID
GROUP BY p.productid,
         p.productname
ORDER BY Number_of_orders DESC;
---------------------------------------------------------------------------------------------------

-- Question 24.
-- Customer with the highest single-order value.
SELECT TOP 1 c.CustomerID,
       c.Customername,
       o.quantity * o.UnitPrice * (1-o.Discount/100) AS Highest_single_order
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
ORDER BY Highest_single_order DESC;
---------------------------------------------------------------------------------------------------

-- Question 25.
-- Complete Customer Sales Report.
SELECT
    c.CustomerID,
    c.CustomerName,
    c.City,
    c.CustomerSegment,
    COUNT(o.OrderID) AS NumberOfOrders,
    SUM(o.Quantity) AS TotalQuantity,
    SUM(o.Quantity * o.UnitPrice * (1 - o.Discount / 100.0)) AS TotalSpend
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,
         c.CustomerName,
         c.City,
         c.CustomerSegment
ORDER BY TotalSpend DESC;
---------------------------------------------------------------------------------------------------
-- Question 26.
-- Write a query to find the first order date for each customer, 
-- ordered from the oldest first order to the most recent.
SELECT
    c.CustomerID,
    c.CustomerName,
    MIN(o.OrderDate) AS First_Order_Date
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY First_Order_Date; 
---------------------------------------------------------------------------------------------------

-- Question 27.
-- Show me a list of all customers and all orders, even if they don't match up.
SELECT o.CustomerID,
       c.customername,
       o.orderid
FROM Customers c
FULL OUTER JOIN Orders o
ON c.customerid = o.customerid;
---------------------------------------------------------------------------------------------------

-- Question 28.
-- Display all customers and all orders, including unmatched records from both tables.
SELECT c.customerid,
       c.CustomerName,
       o.OrderID,
       o.OrderDate
FROM Customers c
FULL OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
ORDER BY c.CustomerID;
---------------------------------------------------------------------------------------------------

-- Question 29.
-- Find unmatched customers AND unmatched orders,
SELECT
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.CustomerID AS OrderCustomerID
FROM Customers c
FULL OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL
   OR o.CustomerID IS NULL;
---------------------------------------------------------------------------------------------------
 
 -- Question 30.
 -- Find all employees and the name of their manager.
 SELECT e.firstname AS Employee_name,
        e.managerid AS Manager_name
 FROM Employees e
 LEFT JOIN Employees m
 ON e.EmployeeID = e.ManagerID
 --------------------------------------------------------------------------------------------------

 -- Question 31.
 -- Find employees who have the same manager.
 SELECT 
    e1.FirstName AS Employee_1,
    e2.FirstName AS Employee_2,
    e1.ManagerID
FROM Employees e1
JOIN Employees e2
    ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID < e2.EmployeeID;
---------------------------------------------------------------------------------------------------

-- Question 32.
-- Find pairs of employees who work in the same city.
SELECT e1.Firstname AS Employee_1,
       e2.Firstname AS Employee_2,
       e1.city AS city_name
FROM Employees e1
LEFT JOIN Employees e2
ON e1.City = e2.City
WHERE e1.EmployeeID < e2.EmployeeID;
---------------------------------------------------------------------------------------------------
