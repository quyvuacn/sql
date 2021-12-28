SELECT TOP 5 SUM(SalesYTD) AS TotalSalesYTD, Name FROM Sales.SalesTerritory
GROUP BY Name