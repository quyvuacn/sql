Use AdventureWorks2014
select ProductID, StandardCost, StandardCost * 0.15 as Discount
from Production.ProductCostHistory
go