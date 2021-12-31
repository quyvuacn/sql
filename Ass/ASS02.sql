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
INSERT INTO dbo.Product
(
    ProductName,
    Status,
    Unit,
    Price,
    Quantily
)
VALUES
(   N'Máy tính T450',  -- ProductName - nvarchar(200)
    N'Máy nhập cũ',  -- Status - nvarchar(100)
    N'Chiếc',  -- Unit - nvarchar(20)
    1000, -- Price - money
    10     -- Quantily - int
    ),
(   N'Điện thoại Nokia5670',  -- ProductName - nvarchar(200)
    N'Điện thoại đang hot',  -- Status - nvarchar(100)
    N'Chiếc',  -- Unit - nvarchar(20)
    200, -- Price - money
    200     -- Quantily - int
    ),
(   N'Máy in Asus',  -- ProductName - nvarchar(200)
    N'Máy nhập mới',  -- Status - nvarchar(100)
    N'Chiếc',  -- Unit - nvarchar(20)
    1000, -- Price - money
    100     -- Quantily - int
    )

SELECT * FROM dbo.Trademark
SELECT * FROM dbo.Product