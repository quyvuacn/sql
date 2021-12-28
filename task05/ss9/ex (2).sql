-- Pivot table with one row and sixcolumns
SELECT TOP 5 'TotalSalesYTD'AS GrandTotal,
[Northwest], [Northeast], [Central], [Southwest], [Southeast] FROM
(SELECT TOP 5 Name, SalesYTD FROM Sales.SalesTerritory) AS SourceTable PIVOT
(SUM(SalesYTD) FOR Name IN ([Northwest], [Northeast], [Central], [Southwest],
[Southeast]) ) AS PivotTable;