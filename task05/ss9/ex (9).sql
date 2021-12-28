SELECT Name,CountryRegionCode,SUM(SalesYTD) ASTotalSales FROM Sales.
SalesTerritory WHERE Name <> 'Australia' AND Name<> 'Canada'GROUP BY
Name,CountryRegionCode WITH CUBE