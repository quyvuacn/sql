CREATE DATABASE ASM01
GO

USE ASM01
GO

CREATE TABLE Product(
	ProductID INT PRIMARY KEY,
	Name NVARCHAR(200) NOT NULL,
	Description NVARCHAR(200) NOT NULL,
	Unit NVARCHAR(20) NOT NULL,
	Price MONEY NOT NULL,
	Quantity INT NOT NULL ,
	Status NVARCHAR(200)
)
GO

CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY,
	CustomerName NVARCHAR(50) NOT NULL,
	Address NVARCHAR(200) DEFAULT(N'Chưa cập nhật'),
	Tel INT,
	Status NVARCHAR(10)
)
GO

CREATE TABLE ProductOrder(
	OrderID INT PRIMARY KEY,
	CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
	OrderDate DATETIME NOT NULL,	
	Status NVARCHAR(50) NOT NULL,
)
GO

CREATE TABLE OrderDetails(
	OrderID INT FOREIGN KEY REFERENCES ProductOrder(OrderID),
	ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
	AddDress NVARCHAR(200) NOT NULL,
	Price INT NOT NULL,
	Quantity INT NOT NULL ,
)
GO

INSERT INTO Product
(
    ProductID,
    Name,
    Description,
    Unit,
    Price,
    Quantity,
    Status
)
VALUES
	(0,    -- ProductID - int
    N'Máy Tính T450',  -- Name - nvarchar(200)
    N'Nhập khẩu mới',  -- Description - nvarchar(200)
    N'Chiếc',  -- Unit - nvarchar(20)
    1000, -- Price - money
    20,    -- Quantity - int
    N'Sẵn trong kho'   -- Status - nvarchar(200)
    ),
	(1,    -- ProductID - int
    N'Nokia 1280',  -- Name - nvarchar(200)
    N'Hàng hot',  -- Description - nvarchar(200)
    N'Chiếc',  -- Unit - nvarchar(20)
    200, -- Price - money
    50,    -- Quantity - int
    N'Sẵn trong kho'   -- Status - nvarchar(200)
    ),
	(2,    -- ProductID - int
    N'Máy in mini',  -- Name - nvarchar(200)
    N'Hàng ế',  -- Description - nvarchar(200)
    N'Chiếc',  -- Unit - nvarchar(20)
    200, -- Price - money
    200,    -- Quantity - int
    N'Sẵn trong kho'   -- Status - nvarchar(200)
    ),
	(3,    -- ProductID - int
    N'Iphone 13',  -- Name - nvarchar(200)
    N'Hàng hot',  -- Description - nvarchar(200)
    N'Chiếc',  -- Unit - nvarchar(20)
    2000, -- Price - money
    200,    -- Quantity - int
    N'Đang nhập kho'   -- Status - nvarchar(200)
    ),
	(4,    -- ProductID - int
    N'Laptop gaming',  -- Name - nvarchar(200)
    N'Hàng hot',  -- Description - nvarchar(200)
    N'Chiếc',  -- Unit - nvarchar(20)
    2500, -- Price - money
    200,    -- Quantity - int
    N'Đang nhập kho'   -- Status - nvarchar(200)
    )

INSERT INTO Customer
(
    CustomerID,
    CustomerName,
    Address,
    Tel,
    Status
)
VALUES
	(0,   -- CustomerID - int
    N'Vũ Viết Quý', -- CustomerName - nvarchar(50)
    N'Thái Thụy Thái Bình', -- Address - nvarchar(200)
    0326459773,   -- Tel - int
    N'VIP'  -- Status - nvarchar(10)
    ),
	(1,   -- CustomerID - int
    N'Đặng Kim Thi', -- CustomerName - nvarchar(50)
    N'Hà Nội', -- Address - nvarchar(200)
    0,   -- Tel - int
    N'VIP'  -- Status - nvarchar(10)
    ),
	(2,   -- CustomerID - int
    N'Nguyễn Văn A', -- CustomerName - nvarchar(50)
    N'Thái Thụy Thái Bình', -- Address - nvarchar(200)
    0,   -- Tel - int
    N'Familiar'  -- Status - nvarchar(10)
    ),
	(3,   -- CustomerID - int
    N'Tạ Duy Linh', -- CustomerName - nvarchar(50)
    N'Thái Nguyên', -- Address - nvarchar(200)
    0,   -- Tel - int
    N'Bad'  -- Status - nvarchar(10)
    )

INSERT INTO ProductOrder
(
    OrderID,
    CustomerID,
    OrderDate,
    Status
)
VALUES
	(0,         -- OrderID - int
    2,         -- CustomerID - int
    GETDATE(), -- OrderDate - datetime
    N'Đang giao hàng'        -- Status - nvarchar(50)
    ),
	(1,         -- OrderID - int
    3,         -- CustomerID - int
    GETDATE(), -- OrderDate - datetime
    N'Chuẩn bị hàng'        -- Status - nvarchar(50)
    )

INSERT INTO dbo.OrderDetails
(
    OrderID,
    ProductID,
    AddDress,
    Price,
    Quantity
)
VALUES
	(1,   -- OrderID - int
    0,   -- ProductID - int
    N'Hà nội', -- AddDress - nvarchar(200)
    1000,   -- Price - int
    1    -- Quantity - int
    ),
	(1,   -- OrderID - int
    1,   -- ProductID - int
    N'Hà nội', -- AddDress - nvarchar(200)
    200,   -- Price - int
    1    -- Quantity - int
    )
GO

INSERT INTO dbo.OrderDetails
(
    OrderID,
    ProductID,
    AddDress,
    Price,
    Quantity
)
VALUES
	(0,   -- OrderID - int
    0,   -- ProductID - int
    N'Hà nội', -- AddDress - nvarchar(200)
    1000,   -- Price - int
    1    -- Quantity - int
    ),
	(0,   -- OrderID - int
    1,   -- ProductID - int
    N'Hà nội', -- AddDress - nvarchar(200)
    200,   -- Price - int
    1    -- Quantity - int
    ),
	(0,   -- OrderID - int
    2,   -- ProductID - int
    N'Hà nội', -- AddDress - nvarchar(200)
    200,   -- Price - int
    1    -- Quantity - int
    )
GO

INSERT INTO dbo.OrderDetails
(
    OrderID,
    ProductID,
    AddDress,
    Price,
    Quantity
)
VALUES
	(1,   -- OrderID - int
    3,   -- ProductID - int
    N'Hà nội', -- AddDress - nvarchar(200)
    2000,   -- Price - int
    1    -- Quantity - int
    )
GO


--4.a: Liệt kê các khách hàng đã mua hàng 
SELECT CustomerName FROM dbo.Customer
	WHERE CustomerID IN(
		SELECT CustomerID FROM dbo.ProductOrder
	)
--4.b: Liệt kê danh sách sản phẩm của cửa hàng
SELECT Name FROM dbo.Product
--4.c: Liệt kê cách danh sách các đơn đặt hàng tại cửa hàng
SELECT * FROM dbo.ProductOrder
--5.a: Liệt kê danh sách khách hàng theo thứ tự xuôi
SELECT CustomerName FROM dbo.Customer
	ORDER BY CustomerName

--5.b:Liệt kê danh sách sản phẩm của cửa hàng theo giá từ cao xuống thấp
SELECT Name,Price FROM dbo.Product	
	ORDER BY Price DESC

--5.c: Liệt kê sản phẩm Phan Văn A đã mua
SELECT * FROM dbo.Product 
	WHERE ProductID IN(
		SELECT ProductID FROM dbo.OrderDetails
			WHERE OrderID IN(
				SELECT OrderID FROM dbo.ProductOrder
					WHERE CustomerID = 2 --2 là mã id của An
				)
		)
 --6.a Truy vấn số khách mua hàng tại cửa hàng
 SELECT COUNT(DISTINCT CustomerID ) AS 'Số khách mua hàng' 
 FROM dbo.ProductOrder 

--6.b Truy vấn số mặt hàng mà cửa hàng bán
SELECT COUNT(ProductID) AS 'Số mặt hàng'
FROM dbo.Product
--6.c Tổng tiền từng đơn hàng 
SELECT OrderID,SUM(Price * Quantity) 'Tổng' FROM OrderDetails 
	GROUP BY OrderID
--7.a Thay đổi trường giá tiền
ALTER TABLE dbo.Product 
	ADD CONSTRAINT ck_pricePr CHECK (Price>0)
GO
ALTER TABLE dbo.OrderDetails
	ADD CONSTRAINT ck_priceOd CHECK (Price>0)
GO

--7.b Thay đổi trường ngày
ALTER TABLE dbo.ProductOrder
	ADD CONSTRAINT ck_date CHECK(OrderDate <= GETDATE())
GO
--7.c Thêm cột ngày đưa sản phẩm lên thị trường
ALTER TABLE dbo.Product 
	ADD PublicDate DATETIME
GO
