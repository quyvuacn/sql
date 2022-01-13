-- Session 14 - Transactions

use AdventureWorks2019
go
declare @TranName varchar(30);
select @TranName = 'FirstTransaction';
begin transaction @TranName;
delete from HumanResources.JobCandidate where JobCandidateID = 13;


begin transaction;
go
delete from HumanResources.JobCandidate where JobCandidateID = 11;
go
commit transaction;
go


begin transaction DeleteCandidate
with mark N'Deleting a Job Candidate';
go
delete from HumanResources.JobCandidate where JobCandidateID = 11;
go
commit transaction Deletecandidate;


use Sterling;
go
create table ValueTable ([value] char)
go


begin transaction
insert into ValueTable values ('A');
insert into ValueTable values('B');
go
rollback transaction
insert into ValueTable values ('C');
select [value] from ValueTable;


create proc SaveTranExample @InputCandidateID int
as
declare @TranCounter int;
set @TranCounter = @@TRANCOUNT; if @TranCounter > 0
save transaction ProcedureSave;
else
begin transaction;
delete HumanResources.JobCandidate
where JobCandidateID = @InputCandidateID; if @TranCounter = 0
commit transaction;
if @TranCounter = 1
rollback transaction ProcedureSave;
go


print @@trancount begin tran
print @@trancount begin tran
print @@trancount commit
print @@trancount commit
print @@trancount


print @@trancount begin tran
print @@trancount begin tran
print @@trancount
rollback
print @@trancount


use AdventureWorks2019;
go
begin transaction ListPriceUpdate
with mark 'UPDATE Product list prices';
go
update Production.Product
set ListPrice = ListPrice * 1.20 where ProductNumber like 'BK-%';
go
commit transaction ListPriceUpdate;
go

-- Session 15 Error Handling 

begin try
declare @num int;
select @num = 217/0;
end try
begin catch
print 'Error occurred, unable to divide by 0'
end catch;


begin try
select 217/0;
end try
begin catch
select 
ERROR_NUMBER () as ErrorNumber, ERROR_SEVERITY () as ErrorSeverity, ERROR_LINE () as ErrorLine, ERROR_MESSAGE () as ErrorMessage;
end catch;
go


if OBJECT_ID ('sp_ErrorInfo', 'p') is not null
drop procedure sp_ErrorInfo;
go
create proc sp_ErrorInfo
as
select 
ERROR_NUMBER () as ErrorNumber,
ERROR_SEVERITY () as ErrorSeverity,
ERROR_LINE () as ErrorLine,
ERROR_MESSAGE () as ErrorMessage;
go
begin try select 217/0;
end try
begin catch
execute sp_ErrorInfo;
end catch;


begin transaction;
begin try
delete from Production.Product where ProductID = 980;
end try 
begin catch 
select 
ERROR_NUMBER () as ErrorNumber,
ERROR_SEVERITY () as ErrorSeverity,
ERROR_LINE () as ErrorLine,
ERROR_MESSAGE () as ErrorMessage,
ERROR_STATE () as ErrorState; if @@TRANCOUNT >0
rollback transaction;
end catch;

if @@TRANCOUNT >0 commit transaction;
go


begin try 
update HumanResources.EmployeePayHistory set PayFrequency = 4
where BusinessEntityID = 1;
end try
begin catch
if @@ERROR = 547
print N'Check constraint violation has occurred.';
end catch


raiserror (N'This is an error message %s %d.', 10, 1, N'serial number', 23);
go


raiserror (N'%*.*s', 10, 1, 7, 11, N'Hello world');
go
raiserror (N'%7.11s', 10, 1, N'Hello world');
go


begin try
raiserror('RaisesError in the TRY block.', 16, 1);
end try
begin catch
declare @ErrorMessage nvarchar(4000);
declare @ErrorSeverity int;
declare @ErrorState int;
select @ErrorMessage = ERROR_MESSAGE(),
@ErrorSeverity = ERROR_SEVERITY(),
@ErrorState = ERROR_STATE();
raiserror (@ErrorMessage, @ErrorSeverity, @ErrorState);
end catch;


begin try
select 217/0;
end try
begin catch
select ERROR_STATE () as ErrorState;
end catch;
go


begin try
select 217/0;
end try
begin catch
select ERROR_SEVERITY () as ErrorSeverity;
end catch;
go


if OBJECT_ID ('usp_Example', 'p') is not null
drop proc usp_Example;
go
create proc usp_Example as
select 217/0;
go
begin try
exec usp_Example;
end try
begin catch
select ERROR_PROCEDURE () as ErrorProcedure;
end catch;
go


if OBJECT_ID ('usp_Example', 'p') is not null
drop proc usp_Example;
go
create proc usp_Example as
select 217/0;
go
begin try
exec usp_Example;
end try
begin catch
select ERROR_PROCEDURE () as ErrorProcedure,
ERROR_NUMBER () as ErrorNumber,
ERROR_LINE () as ErrorLine,
ERROR_SEVERITY () as ErrorSeverity,
ERROR_MESSAGE () as ErrorMessage,
ERROR_STATE () as ErrorState;
end catch;
go


begin try 
select 217/0;
end try
begin catch 
select ERROR_NUMBER () as ErrorNumber;
end catch;
go


begin try 
select 217/0
end try
begin catch 
select ERROR_MESSAGE () as ErrorMessage;
end catch;
go


begin try 
select 217/0
end try
begin catch 
select ERROR_LINE () as ErrorLine;
end catch;
go


begin try
select * from Nonexistent;
end try
begin catch 
select ERROR_NUMBER () as ErrorNumber,
ERROR_MESSAGE () as ErrorMessage;
end catch


if OBJECT_ID (N'sp_Example', N'P') is not null
drop proc usp_Example;
go
create proc sp_Example as
select * from Nonexistent;
go
begin try
exec sp_Example
end try
begin catch 
select 
ERROR_NUMBER () as ErrorNumber,
ERROR_MESSAGE () as ErrorMessage;
end catch;


create table dbo.TestRethRow (ID int primary key);
begin try
insert dbo.TestRethRow (ID) values(1);
insert dbo.TestRethRow (ID) values(1);
end try
begin catch
print ' In catch block.';
throw;
end catch;