/*
Run a sales data analysis on Superstore dataset.
Tasks:
	- Explore the data
	- Answer the questions
*/

USE SuperStoreOLTP2021;

/* DATA EXPLORATION */

-- Take a glimpse of the Orders table
SELECT *
FROM dbo.Orders;

-- Count Orders records
SELECT COUNT(1)
FROM dbo.Orders;

-- Take a glimpse of the People table
SELECT *
FROM dbo.People;

-- Count People records
SELECT COUNT(1)
FROM dbo.People;

-- Take a glimpse of the Returns table
SELECT *
FROM dbo.Returns;

-- Count Returns records
SELECT COUNT(1)
FROM dbo.Returns;

-- Join the tables
SELECT *
FROM dbo.Orders
LEFT JOIN dbo.People ON Orders.Region = People.Region
LEFT JOIN dbo.Returns ON Orders.[Order ID] = Returns.[Order ID];


/* DATA ANALYSIS */

-- What are the yearly sales and profits?
SELECT DATEPART(yyyy, [Order Date]) as OrderYear, SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit
FROM dbo.Orders
GROUP BY DATEPART(yyyy, [Order Date])
ORDER BY OrderYear ASC;

-- What are the quarterly sales and profits by year?
SELECT DATEPART(yyyy, [Order Date]) as OrderYear, 'Q' + TRIM(STR(DATEPART(qq, [Order Date]))) as OrderQuarter, SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit
FROM dbo.Orders
GROUP BY DATEPART(yyyy, [Order Date]), DATEPART(qq, [Order Date])
ORDER BY OrderYear ASC;

-- Which region generates the highest sales and profits?
SELECT Region as Region, SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit
FROM dbo.Orders
GROUP BY Region
ORDER BY TotalSales DESC;

-- Which region generates the highest profit margin?
SELECT Region as Region, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY Region
ORDER BY ProfitMargin DESC;

-- Which states bring in the highest sales and profits?
SELECT State, SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY State
ORDER BY TotalSales DESC;

-- Which cities bring in the highest sales and profits?
SELECT City, SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY City
ORDER BY TotalSales DESC;

-- What is the relationship between discount and average sales?
SELECT Discount, AVG(Sales) as AvgSales
FROM dbo.Orders
GROUP BY Discount
ORDER BY Discount ASC;

-- What are the most discounted product categories?
SELECT Category, ROUND(SUM(Sales * Discount), 2) as DiscountAmount
FROM dbo.Orders
GROUP BY Category
ORDER BY DiscountAmount DESC;

-- Which categories generate the highest sales and profits in each region and state?
SELECT Category, SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY Category
ORDER BY TotalSales DESC;

SELECT Region, Category, SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY Region, Category
ORDER BY TotalSales DESC;

SELECT State, Category, SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY State, Category
ORDER BY TotalSales DESC;

-- Which sub-categories generate the highest sales and profits in each region and state?
SELECT [Sub-Category], SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY [Sub-Category]
ORDER BY TotalSales DESC;

SELECT Region, [Sub-Category], SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY Region, [Sub-Category]
ORDER BY TotalSales DESC;

SELECT State, [Sub-Category], SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY State, [Sub-Category]
ORDER BY TotalSales DESC;

-- Which products are the most and least profitable to us?

-- Most profitable
SELECT TOP 5 [Product ID], SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY [Product ID]
ORDER BY TotalProfit DESC;

-- Least profitable
SELECT TOP 5 [Product ID], SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY [Product ID]
ORDER BY TotalProfit ASC;

-- How many customers do we have (unique customer IDs) in total and how many in each region and state?
SELECT COUNT (DISTINCT [Customer ID]) as NbCustomers
FROM dbo.Orders;

SELECT Region, COUNT (DISTINCT [Customer ID]) as NbCustomers
FROM dbo.Orders
GROUP BY Region
ORDER BY NbCustomers DESC;

SELECT State, COUNT (DISTINCT [Customer ID]) as NbCustomers
FROM dbo.Orders
GROUP BY State
ORDER BY NbCustomers DESC;

-- Who are our best customers?
SELECT TOP 5 [Customer ID], SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY [Customer ID]
ORDER BY TotalSales DESC;

-- Who are our worst customers?
SELECT TOP 5 [Customer ID], SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) as ProfitMargin
FROM dbo.Orders
GROUP BY [Customer ID]
ORDER BY TotalSales ASC;

--What is the average shipping time per shipping mode and in total
SELECT AVG(DATEDIFF(dd, [Order Date], [Ship Date])) as ShippingTime
FROM Orders;

SELECT [Ship Mode], AVG(DATEDIFF(dd, [Order Date], [Ship Date])) as ShippingTime
FROM Orders
GROUP BY [Ship Mode]
ORDER BY ShippingTime DESC;

