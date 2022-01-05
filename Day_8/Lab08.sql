CREATE DATABASE Lab08
GO

USE AdventureWorks2019
GO

SELECT * INTO Lab08.dbo.WorkOrder FROM Production.WorkOrder

USE Lab08
GO

SELECT * INTO WorkOrderIX FROM Production.WorkOrder
