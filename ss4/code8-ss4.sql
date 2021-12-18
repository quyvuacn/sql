USE AdventureWorks2019
GO
SELECT ProductID
FROM Production.Product
INTERSECT
SELECT ProductID
FROM Production.Workorder
                             