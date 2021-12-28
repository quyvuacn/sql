SELECT DueDate, ShipDate FROM Sales.SalesOrderHeader WHERE
Sales.SalesOrderHeader.OrderDate= (SELECT MAX(OrderDate)
FROM Sales.SalesOrderHeader)