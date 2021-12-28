SELECT P.Name, S.SalesOrderID FROM Sales.SalesOrderDetail S
RIGHT OUTER JOIN
Production.Product P
ON P.ProductID=S.ProductID;