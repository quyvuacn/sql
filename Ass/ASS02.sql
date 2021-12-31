CREATE DATABASE ASS02 -- Cơ sở dữ liệu lưu trữ sản phẩm theo hãng
GO

USE ASS02
GO

CREATE  TABLE Trademark(
	TrademarkID INT IDENTITY PRIMARY KEY,
	TrademarkName NVARCHAR(100) NOT NULL,
	Address NVARCHAR(20) NOT NULL,
	Tel NCHAR(20) NOT NULL CHECK(ISNUMERIC(Tel) = 1),
)
GO

CREATE TABLE Product_type(
	TypeID INT IDENTITY PRIMARY KEY,
	TypeName NVARCHAR(20) NOT NULL UNIQUE, --VD: Máy Tính,Điện thoại,Máy in
)
GO


CREATE TABLE Product(
	TrademarkID INT NOT NULL FOREIGN KEY REFERENCES dbo.Trademark(TrademarkID),
	TypeID INT FOREIGN KEY REFERENCES dbo.Product_type(TypeID),
	ProductID INT IDENTITY PRIMARY KEY,
	ProductName NVARCHAR(200) NOT NULL,
	Status NVARCHAR(100) NOT NULL, --Chất lượng? Độ hot
	Unit NVARCHAR(20) NOT NULL , -- Đơn vị: chiếc,lô,...
	Price MONEY NOT NULL CHECK(Price>0),
	Quantily INT NOT NULL CHECK(Quantily>0),
)
GO


INSERT INTO dbo.Trademark
(
    TrademarkName,
    Address,
    Tel
)
VALUES
(   N'Asus', -- TrademarkName - nvarchar(100)
    N'USA', -- Address - nvarchar(20)
    N'0983232'  -- Tel - nchar(20)
    ),
(   N'Apple', -- TrademarkName - nvarchar(100)
    N'USA', -- Address - nvarchar(20)
    N'012345'  -- Tel - nchar(20)
    ),
(   N'Xiaomi', -- TrademarkName - nvarchar(100)
    N'CHINA', -- Address - nvarchar(20)
    N'036458'  -- Tel - nchar(20)
    )


INSERT INTO dbo.Product_type
(
    TypeName  
)
VALUES
(   N'Máy Tính'-- TypeName - nvarchar(20)
   ),
(   N'Điện Thoại'-- TypeName - nvarchar(20)
   ),
(   N'Máy in'-- TypeName - nvarchar(20)
   ),
(   N'Phụ kiện'-- TypeName - nvarchar(20)
   )

INSERT INTO dbo.Product
(	TrademarkID,
    TypeID,
    ProductName,
    Status,
    Unit,
    Price,
    Quantily
)
VALUES
(   1,
	1,    -- TypeID - int
    N'Máy tính Asus',  -- ProductName - nvarchar(200)
    N'Hàng mới',  -- Status - nvarchar(100)
    N'Chiếc',  -- Unit - nvarchar(20)
    1500, -- Price - money
    20     -- Quantily - int
    )

--4: Hiển thị các hãng và các sp
SELECT TrademarkName FROM dbo.Trademark
SELECT * FROM dbo.Product_type
SELECT * FROM dbo.Product

--5a.Liệt kê danh sách hãng z-a
SELECT TrademarkName FROM dbo.Trademark
ORDER BY TrademarkName DESC

--5b.Liệt kê danh sách sp theo giá giảm dần
SELECT ProductName,Price FROM dbo.Product
ORDER BY Price DESC

--5c.Hiển thị thông tin hãng Asus
SELECT * FROM dbo.Trademark
WHERE TrademarkName = 'Asus'

--5d. Liệt kê danh sách sản phẩm ít hơn 11 chiếc trong kho
SELECT ProductName,Quantily FROM dbo.Product
WHERE Quantily<11

--5e.Liệt kê danh sách sản phẩm của hãng Asus
SELECT * FROM dbo.Product


--6a. Hiển thị số hãng sp mà cửa hàng có
SELECT COUNT(TrademarkID) AS 'Số hãng' FROM dbo.Trademark

--6b. Hiển thị số mặt hàng tại cửa hàng bán
SELECT COUNT(ProductID) AS 'Số mặt hàng' FROM dbo.Product

--6c. Tổng số sp của mỗi hãng trong cửa hàng
SELECT TrademarkName,COUNT(ProductID) AS 'Số sản phẩm' FROM dbo.Product
JOIN dbo.Trademark
ON Trademark.TrademarkID = Product.TrademarkID
GROUP BY TrademarkName

--6d. Tổng số đầu sp của toàn cửa hàng
SELECT SUM(Quantily) AS 'Số đầu sản phẩm' FROM dbo.Product

--7a. Thay đổi giá mặt hàng >0 -> check
--7b. Thêm ràng buộc tel bắt đầu bằng 0
ALTER TABLE dbo.Trademark
 ADD CONSTRAINT ck_tel CHECK(LEFT(Tel,1)='0')

 --8: Chưa học tới



