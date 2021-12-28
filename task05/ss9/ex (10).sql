SELECT Name, CountryRegionCode,SUM (SalesYTD) AS TotalSales FROM
Sales.SalesTerritory
WHERE Name<> 'Australia' AND Name<> 'Canada' GROUP BY
Name,CountryRegionCode
WITH ROLLUP