use AdventureWorks2019

--Session 11

create table Production.parts(
part_id int not null,
part_name nvarchar(100)
)
go


create clustered index ix_parts on Production.parts (part_id);
exec sp_rename 
	N'Production.parts.ix_parts_id',
	N'index_part_id',
N'INDEX';

alter index ix_parts
on Production.parts
disable;


alter index all on Production.parts
disable;


drop index if exists
ix_parts on Production.parts;


create nonclustered index index_customer_storeid
on Sales.Customer(StoreID);


create unique index AK_Customer_rowguid
on Sales.Customer(rowguid);


create index index_cust_personId on
Sales.Customer(PersonID)
where PersonID is not null;


select CustomerID, PersonId, StoreID from Sales.Customer where PersonID = 1700;


create partition function partition_function (int)
range left for values (20200630, 20200731, 20200831);


(select 20200613 date, $partition.partition_function()20200613)PartitionNumber)
union
(select 20200713 date, $partition.partition_function()20200713)PartitionNumber)
union
(select 20200813 date, $partition.partition_function()20200813)PartitionNumber)
union
(select 20200913 date, $partition.partition_function()20200913)PartitionNumber);


create primary xml index pxml_ProductModel_CatalogDescription
on Production.ProductModel (CatalogDescription);


create xml index ixml_ProductModel_CatalogDescription_Path
on Production.ProductModel (CatalogDescription)
using xml index pxml_ProductModel_CatalogDescription
for Path;


create columnstore index IX_SalesOrderDetails_ProductIDOrderQty_columnstore on Sales.SalesOrderDetail (ProductID, OrderQty);


select ProductID, SUM(OrderQty)
from Sales.SalesOrderDetail
group by ProductID;

--Session 12 

create table Locations (LocationID int, LocName varchar(100));
create table LocationHistory (LocationID int, ModifiedDate datetime);


create trigger trigger_insert_Locations on Locations
for insert 
not for replication
as
	begin 
		insert into LocationHistory
		select LocationID 
		,getdate()
		from inserted 
	end;


insert into dbo.Locations (LocationID, LocName) values (443101, 'Alaska'


create trigger trigger_upadte_Locations on Locations
for update 
not for replication
as 
	begin 
	insert into LocationHistory
	select LocationID
	,getdate()
	from inserted
end;


update dbo.Locations set LocName='Alatka'
where LocationID = '443101';


create trigger trigger_delete_Locations on Locations 
for delete
not for replication
as 
	begin
	insert into LocationHistory
	select LocationID ,getdate()
	from deleted
end;


delete from dbo.Locations 
where LocationID= '443101'


create trigger alter_insert_Locations on Locations 
after insert 
as 
	begin 
	insert into LocationHistory
	select LocationID
	, getdate()
	from inserted
end;


insert into dbo.Locations (LocationID, LocName) values (443101, 'SAN ROMAN')


create trigger insteadof_delete_Locations on Locations
instead of delete 
as 
	begin 
	select 'Sample Instead of trigger' as 'Khanh sieu dep trai'
end;


delete from dbo.Locations
where LocationID = 443101


exec sp_settriggerorder @triggername = 'trigger_delete_Locations', @order = 'first', @stmttype = 'delete' 


sp_helptext trigger_delete_Locations


alter trigger trigger_update_Locations on Locations 
with excryption for insert 
as	
	if '443101' in (select LocationID from inserted)
	begin 
		print 'Location cannot be updated'
		rollback transaction
end;


drop trigger trigger_update_Locations


create trigger secure on database 
for drop_table, alter_table as 
print 'You must disable Trigger "Secure" to drop or alter tables !'
rollback;


create trigger Employee_deletion on HumanResources.Employee
after delete
as
	begin
	print 'Deletion will be affect EmployeePayHistory table'
delete from EmployeePayHistory where BusinessEntityID in (select BusinessEntityID from deleted)
end;

create trigger deletion_Confirmation
on HumanResources.EmployeePayHistory after delete
as 
	begin 
	print 'Employee details succesfully deleted from EmployeePayHistory table'
end;
delete from EmployeePayHistory where EmpID = 1


create trigger Accounting on Production.TransactionHistory after update 
as 
if (update (TransactionID) or update (ProductID) ) begin
raiserror (5009, 16, 10) end;
go


use AdventureWorks2019
go
create trigger PODetails
on Purchasing.PurchaseOrderDetail after insert as
update PurchaseOrderHeader
set SubTotal = SubTotal + LineTotal from inserted
where PurchaseOrderHeader.PurchaseOrderID = inserted.PurchaseOrderID;


create trigger PODetailsMultiple
on Purchasing.PurchaseOrderDetail after insert as 
update Purchasing.PurchaseOrderHeader set SubTotal = SubTotal + (select sum(LineTotal) from inserted
where PurchaseOrderHeader.PurchaseOrderID = inserted.PurchaseOrderID)
where PurchaseOrderHeader.PurchaseOrderID in (select PurchaseOrderID from inserted);


create trigger track_login on ALL SEVER
for logon as
	begin 
		insert into LoginActivity
		select EVENTDATA()
		,GETDATE()
end;