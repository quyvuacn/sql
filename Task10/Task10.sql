CREATE DATABASE Task10_Ex
GO

USE Task10_Ex
GO

CREATE TABLE Toys(
	Product VARCHAR(5) PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	Category VARCHAR(30),
	Manufacturer VARCHAR(40),
	AgeRange VARCHAR(15),
	UnitPrice MONEY NOT NULL CHECK(UnitPrice>0),
	NetWeight INT NOT NULL,
	QtyOnHand INT NOT NULL
)

INSERT INTO dbo.Toys
(
    Product,
    Name,
    Category,
    Manufacturer,
    AgeRange,
    UnitPrice,
    NetWeight,
	QtyOnHand
)
VALUES
(   'MB01',   -- Product - varchar(5)
    'Máy Bay đồ chơi',   -- Name - varchar(30)
    'Máy bay',   -- Category - varchar(30)
    'QQ',   -- Manufacturer - varchar(40)
    '3-5',   -- AgeRange - varchar(15)
    200, -- UnitPrice - money
    400,-- NetWeight - int
	20
    ),
(   'XT01',   -- Product - varchar(5)
    'Xe tăng đồ chơi',   -- Name - varchar(30)
    'Xe tăng',   -- Category - varchar(30)
    'QQ',   -- Manufacturer - varchar(40)
    '3-5',   -- AgeRange - varchar(15)
    200, -- UnitPrice - money
    400,-- NetWeight - int
	30
    )
GO

--1
--2 Viết câu lệnh tạo Thủ tục lưu trữ có tên là HeavyToys cho phép liệt kê tất cả các loại đồ chơi có trọng lượng lớn hơn 500g.
CREATE PROCEDURE HeavyToys
AS
SELECT * FROM dbo.Toys
WHERE NetWeight > 500
GO

--3 Viết câu lệnh tạo Thủ tục lưu trữ có tên là PriceIncreasecho phép tăng giá của tất cả các loại đồ chơi lên thêm 10 đơn vị giá.
CREATE PROCEDURE PriceIncrease
AS
UPDATE dbo.Toys
SET UnitPrice = UnitPrice + 10
GO
--4 Viết câu lệnh tạo Thủ tục lưu trữ có tên là QtyOnHand làm giảm số lượng đồ chơi còn trong của hàng mỗi thứ 5 đơn vị.
CREATE PROCEDURE QtyOnHand
AS
UPDATE dbo.Toys
SET QtyOnHand = QtyOnHand - 5
GO

EXEC dbo.HeavyToys
EXEC dbo.PriceIncrease
EXEC dbo.QtyOnHand
SELECT * FROM dbo.Toys

--BTVN
--1 sp_helptext,sys.sql_modules,OBJECT_DEFINITION()
--1.1
EXEC sys.sp_helptext @objname = N'QtyOnHand'  -- nvarchar(776)
GO
--1.2
SELECT 
          sm.object_id
        , ss.[name] as [schema]
        , o.[name] as object_name
        , o.[type]
        , o.[type_desc]
        , sm.[definition]  
FROM sys.sql_modules AS sm     
JOIN sys.objects AS o 
    ON sm.object_id = o.object_id  
JOIN sys.schemas AS ss
    ON o.schema_id = ss.schema_id  
ORDER BY 
      o.[type]
    , ss.[name]
    , o.[name]
--OBJECT_DEFINITION()
SELECT OBJECT_DEFINITION (OBJECT_ID(N'QtyOnHand')) AS [Object Definition]

--2. Viết câu lệnh hiển thị các đối tượng phụ thuộc của mỗi thủ tục lưu trữ trên
EXEC sys.sp_depends @objname = N'QtyOnHand' 
--3. Chỉnh sửa PriceIncreasevà QtyOnHandthêm câu lệnh cho phép hiển thị giá trị mới đã được cập nhật của các trường (UnitPrice,QtyOnHand).
