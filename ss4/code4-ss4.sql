USE AdventureWorks2019

SELECT SalesOrderID, CustomerID, SalesPersonID, TerritoryID, YEAR (OrderDate) AS
CurrentYear, YEAR (OrderDate) +1 AS NextYear
FROM Sales.SalesOrderHeader