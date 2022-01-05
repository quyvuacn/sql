CREATE DATABASE Lab08
GO

USE AdventureWorks2019
GO

SELECT * INTO Lab08.dbo.WorkOrder FROM Production.WorkOrder

USE Lab08
GO


SELECT * INTO WorkOrderIX FROM WorkOrder

SELECT*FROM WorkOrder
SELECT*FROM WorkOrderIX

CREATE INDEX IX_WorkOrderID ON WorkOrderIX (WorkOrderID)

SELECT * FROM WorkOrder WHERE WorkOrderID=72000
SELECT * FROM WorkOrderIX WHERE WorkOrderID=72000


