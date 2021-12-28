SELECT [Group],SUM(SalesYTD) AS 'TotalSales' FROM Sales. SalesTerritory WHERE
[Group] LIKE 'N%'OR [Group] LIKE'E%' GROUP BY ALL [Group]