use AdventureWorks2014
SELECT WorkOrderID, SUM (ActualResourceHrs) AS TotalHoursPerWorkOrder FROM
Production.WorkOrderRouting GROUP BY WorkOrderID