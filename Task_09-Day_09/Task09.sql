
CREATE VIEW vwProductInfo AS
SELECT ProductID, ProductNumber, Name ,SafetyStockLevel 
FROM Production. Product;
GO


 SELECT * FROM vwProductInfo


CREATE VIEW wwPersonDetails AS
SELECT 
p.Title
,p.[FirstName]
,p.[MiddleName]
,p.[LastName]
,e.[JobTitle]
FROM[HumanResources].[Employee]e
	INNER JOIN [Person].[Person]p
	ON p.[BusinessEntityID] = e.[BusinessEntityID]
GO


| SELECT * FROM vwPersonDetails


CREATE VIEW wwPersonDetailsNew
AS
SELECT 
COALESCE(p.MiddleName,' ')AS  Title
,p.[FirstName]
 ,COALESCE(p.MiddleName,' ')ASMiddleName
 ,p.[LastName]
 ,e.[JobTitle]
 FROM[HumanResources].[Employee]e
	INNER JOIN [Person].[Person]p
	ON p.[BusinessEntityID] = e.[BusinessEntityID]
GO


CREATE VIEW wwSortedPersonDetails AS
SELECT TOP 10 COALESCE(p.Title,'') AS Title
,p.[FirstName]
COALESCE(p.MiddleName,' ')AS  Title
,p.[FirstName]
 ,e.[JobTitle]
 FROM [HumanResources].[Employee] e INNER JOIN [Person].[Person] p
 ON p.[BusinessEntityID] = e.[BusinessEntityID] ORDER BY p.FirstName
 GO
 
 SELECT * FROM  wwSortedPersonDetails

 CREATE TABLE Employee_Personal_Details(
 EmpID int NOT NULL,
 FirstName varchar(30)NOT NULL,
 lastName varchar(30)NOT NULL, Address
 varchar (30)
 )


CREATE TABLE Employee_Salary_Details(
EmpID
int NOT NULL,
Designation varchar(30),
Salary int NOT NULL
)

CREATE VIEW vwEmployee_Personal_Details
AS
SELECT e1.EmpID, FirstName, LastName, Designation, Salary
FROM Employee_Personal_Details e1
JOIN Employee_Salary_Details e2
ON e1.EmpID=e2.EmpID

INSERT INTO vwEmployee_Personal_Details VALUES (2,'Jack','Wilson','Software
Developer',16000)

CREATE VIEW vwEmpDetails AS
SELECT FirstName, Address
FROM Employee_Personal_Details

INSERT INTO vwEmpDetails VALUES ('Jack', 'NYC')

CREATE TABLE Product_Details (
ProductID int, ProductName
varchar(30), Rate money
)

CREATE VIEW vwProduct_Details
AS
SELECT ProductName, Rate FROM Product_Details

UPDATE vwProduct_Details
SET Rate=3000
WHERE ProductName='DVD Writer'

CREATE VIEW vwProduct_Details AS
SELECT
ProductName,
Description,
Rate FROM Product_Details

UPDATE vwProduct_Details
SET DESCRIPTION .WRITE(N'Ex',0,2)
WHERE ProductName='PortableHardDrive'

DELETE FROM vwCustDetails WHERE CustID = 'C004'


ALTER VIEW vwProductInfo AS
SELECT ProductID, ProductNumber, NAME, SafetyStockLevel, ReOrderPoint
FROM Production.Product;
GO


DROP VIEW vwProductInfo
EXEC sp_helptext vwProductPrice


CREATE VIEW vwProduct_Details
AS
SELECT
ProductName,
AVG(Rate) AS AverageRate
FROM Product_Details
GROUP BY ProductName


CREATE VIEW vwProductInfo AS
SELECT ProductID, ProductNumber, Name,SafetyStockLevel, ReOderPoint
FROM Production.Product
WHERE SafetyStockLevel<=1000
WITH CHECK OPTION;
GO


UPDATE vwProductInfo SET SafetyStockLevel =2500
WHERE ProductID=321

create view vwNewProductInfo with schemabinding as 
select ProductID, ProductNumber, Name, SafetyStockLevel 
from Production.Product;
go


create table vwCustomers
(
CustID int,
CustName varchar(50),
Address varchar(60)
)


create view viewCustomers
as
select * from vwCustomers 


select * from vwCustomers


alter table vwCustomers ADD Age int


select * from vwCustomers


EXEC sp_refreshview 'vwCustomers'


alter table Production.Product alter column ProductID varchar(7)