SELECT AVG ([UnitPrice]) AS AvgUnitPrice, MIN ([OrderQty])AS MinQty,
MAX([UnitPriceDiscount]) AS MaxDiscount
FROM Sales.SalesOrderDetail;