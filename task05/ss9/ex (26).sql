SELECT A.CustomerID, B.DueDate,B.ShipDate FROM Sales.Customer A LEFT OUTER JOIN
Sales.SalesOrderHeader B
ON
A.CustomerID= B.CustomerID AND YEAR (B.DueDate)<2019;