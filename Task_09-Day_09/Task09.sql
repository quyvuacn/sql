-- code vd sesion10

--vd1:
CREATE VIEW vwProductInfo AS
SELECT ProductID, ProductNumber, Name ,SafetyStockLevel 
FROM Production. Product;
GO

--vd2:
| SELECT * FROM vwProductInfo

--vd3:
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

--vd4:
| SELECT * FROM vwPersonDetails

--vd5:
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

--vd6:
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

 --vd7:
 CREATE TABLE Employee_Personal_Details(
 EmpID int NOT NULL,
 FirstName varchar(30)NOT NULL,
 lastName varchar(30)NOT NULL, Address
 varchar (30)
 )

 --vd8:
CREATE TABLE Employee_Salary_Details(
EmpID
int NOT NULL,
Designation varchar(30),
Salary int NOT NULL
)
-- 9
CREATE VIEW vwEmployee_Personal_Details
AS
SELECT e1.EmpID, FirstName, LastName, Designation, Salary
FROM Employee_Personal_Details e1
JOIN Employee_Salary_Details e2
ON e1.EmpID=e2.EmpID
-- 10
INSERT INTO vwEmployee_Personal_Details VALUES (2,'Jack','Wilson','Software
Developer',16000)
-- 11
CREATE VIEW vwEmpDetails AS
SELECT FirstName, Address
FROM Employee_Personal_Details
-- 12
INSERT INTO vwEmpDetails VALUES ('Jack', 'NYC')
-- 13
CREATE TABLE Product_Details (
ProductID int, ProductName
varchar(30), Rate money
)
-- 14
CREATE VIEW vwProduct_Details
AS
SELECT ProductName, Rate FROM Product_Details
-- 15
UPDATE vwProduct_Details
SET Rate=3000
WHERE ProductName='DVD Writer'
-- 16
CREATE VIEW vwProduct_Details AS
SELECT
ProductName,
Description,
Rate FROM Product_Details
--17
UPDATE vwProduct_Details
SET DESCRIPTION .WRITE(N'Ex',0,2)
WHERE ProductName='PortableHardDrive'

--18
DELETE FROM vwCustDetails WHERE CustID = 'C004'

-- 19
ALTER VIEW vwProductInfo AS
SELECT ProductID, ProductNumber, NAME, SafetyStockLevel, ReOrderPoint
FROM Production.Product;
GO

-- 20
DROP VIEW vwProductInfo

--21
EXEC sp_helptext vwProductPrice


-- 22
CREATE VIEW vwProduct_Details
AS
SELECT
ProductName,
AVG(Rate) AS AverageRate
FROM Product_Details
GROUP BY ProductName

--23
CREATE VIEW vwProductInfo AS
SELECT ProductID, ProductNumber, Name,SafetyStockLevel, ReOderPoint
FROM Production.Product
WHERE SafetyStockLevel<=1000
WITH CHECK OPTION;
GO

-- 24
UPDATE vwProductInfo SET SafetyStockLevel =2500
WHERE ProductID=321
--vd25
create view vwNewProductInfo with schemabinding as 
select ProductID, ProductNumber, Name, SafetyStockLevel 
from Production.Product;
go

--vd26
create table vwCustomers
(
CustID int,
CustName varchar(50),
Address varchar(60)
)

--vd27
create view viewCustomers
as
select * from vwCustomers 

--vd28
select * from vwCustomers

--vd29
alter table vwCustomers ADD Age int

--vd30
select * from vwCustomers

--vd31
EXEC sp_refreshview 'vwCustomers'

--vd32 
alter table Production.Product alter column ProductID varchar(7)