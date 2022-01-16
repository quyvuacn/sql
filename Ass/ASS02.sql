DROP DATABASE IF EXISTS ASS02
GO


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
	Quantily INT NOT NULL,
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
    ),
(   1,
	1,    -- TypeID - int
    N'Điện Thoại',  -- ProductName - nvarchar(200)
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

 --8a: Thiết lập index
CREATE INDEX IX_Product ON dbo.Product(ProductName)
GO

CREATE INDEX IX_ProductStatus ON dbo.Product(Status)
GO

--8b. View
CREATE VIEW View_SanPham
AS 
SELECT ProductID,ProductName,Price FROM dbo.Product
GO

--8c. Viết các Store Procedure sau:
--SP_SanPham_TenHang: Liệt kê các sản phẩm với tên hãng truyền vào store
CREATE PROCEDURE SP_SanPham_TenHang
	@TrademarkName NVARCHAR(100)
AS 
SELECT ProductName FROM dbo.Product
JOIN dbo.Trademark
ON Trademark.TrademarkID = Product.TrademarkID
WHERE TrademarkName LIKE @TrademarkName
GO

EXECUTE dbo.SP_SanPham_TenHang @TrademarkName = N'asus' -- nvarchar(100)
GO

--SP_SanPham_Gia: Liệt kê các sản phẩm có giá bán lớn hơn hoặc bằng giá bán truyền vào
CREATE PROCEDURE SP_SanPham_Gia
	@input_price MONEY
AS
SELECT * FROM dbo.Product
WHERE Price > @input_price
GO

EXECUTE dbo.SP_SanPham_Gia @input_price = 100 -- money
GO

--SP_SanPham_HetHang:
CREATE PROCEDURE SP_SanPham_HetHang 
AS 
SELECT * FROM dbo.Product
WHERE Quantily =0
GO

EXECUTE dbo.SP_SanPham_HetHang 
GO

--8d: 
--TG_Xoa_Hang: Ngăn không cho xóa hãng
CREATE TRIGGER TG_Xoa_Hang
ON dbo.Trademark
FOR DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	PRINT N'Không thể xóa hãng'
END
GO
--TG_Xoa_SanPham: Chỉ cho phép xóa các sản phẩm đã hết hàng (số lượng = 0)
ALTER TRIGGER TG_Xoa_SanPham
ON dbo.Product
FOR DELETE
AS
BEGIN	

END
GO

SELECT * FROM dbo.Product

DELETE dbo.Product
WHERE ProductID = 20















