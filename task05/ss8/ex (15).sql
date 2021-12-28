use AdventureWorks2014
select WorkOrderID, sum(ActualResourceHrs)
from Production.WorkOrderRouting
group by WorkOrderID
go