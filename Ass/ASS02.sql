CREATE DATABASE ASS01 -- Cơ sở dữ liệu lưu trữ sản phẩm theo hãng
GO

USE ASS01
GO

CREATE  TABLE Trademark(
	TrademarkID INT IDENTITY PRIMARY KEY,
	TrademarkName NVARCHAR(100) NOT NULL,
	Address NVARCHAR(20) NOT NULL,
	Tel NCHAR(20) NOT NULL CHECK(ISNUMERIC(Tel) = 1),
)
GO

CREATE TABLE Product(
	TrademarkID INT FOREIGN KEY REFERENCES Trademark(TrademarkID),
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
    N'983232'  -- Tel - nchar(20)
    ),
(   N'Apple', -- TrademarkName - nvarchar(100)
    N'USA', -- Address - nvarchar(20)
    N'012345'  -- Tel - nchar(20)
    ),
(   N'Xiaomi', -- TrademarkName - nvarchar(100)
    N'CHINA', -- Address - nvarchar(20)
    N'036458'  -- Tel - nchar(20)
    )
	CREATE DATABASE ASS01 -- Cơ sở dữ liệu lưu trữ sản phẩm theo hãng
GO

CREATE  TABLE Trademark(
	TrademarkID INT IDENTITY PRIMARY KEY,
	TrademarkName NVARCHAR(100) NOT NULL,
	Address NVARCHAR(20) NOT NULL,
	Tel NCHAR(20) NOT NULL CHECK(ISNUMERIC(Tel) = 1),
)
GO

CREATE TABLE Product(
	TrademarkID INT FOREIGN KEY REFERENCES Trademark(TrademarkID),
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
INSERT INTO dbo.Product
(
    TrademarkID,
    ProductName,
    Status,
    Unit,
    Price,
    Quantily
)
VALUES
(   1,
	N'Máy tính T450',  -- ProductName - nvarchar(200)
    N'Máy nhập cũ',  -- Status - nvarchar(100)
    N'Chiếc',  -- Unit - nvarchar(20)
    1000, -- Price - money
    10     -- Quantily - int
    ),
(   1,
	N'Điện thoại Nokia5670',  -- ProductName - nvarchar(200)
    N'Điện thoại đang hot',  -- Status - nvarchar(100)
    N'Chiếc',  -- Unit - nvarchar(20)
    200, -- Price - money
    200     -- Quantily - int
    ),
(   1,
	N'Máy in Asus',  -- ProductName - nvarchar(200)
    N'Máy nhập mới',  -- Status - nvarchar(100)
    N'Chiếc',  -- Unit - nvarchar(20)
    1000, -- Price - money
    100     -- Quantily - int
    )

--4: Hiển thị các hãng và các sp
SELECT TrademarkName FROM dbo.Trademark
SELECT ProductName FROM dbo.Product

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
WHERE TrademarkID = (
	SELECT TrademarkID FROM dbo.Trademark
	WHERE TrademarkName = 'Asus'
)

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




