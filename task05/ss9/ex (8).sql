SELECT [Group],SUM(SalesYTD) AS 'TotalSales' FROM Sales.SalesTerritory WHERE
[Group] LIKE 'P%' GROUP BY ALL [Group] HAVING SUM(SalesYTD) < 6000000