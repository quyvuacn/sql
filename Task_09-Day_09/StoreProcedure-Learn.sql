USE AdventureWorks2019
GO

--Tạo thủ tục lưu trữ tìm kiếm tên nước
CREATE PROCEDURE sp_search
	@nuoc VARCHAR(20)
AS
SELECT * FROM Person.CountryRegion
WHERE Name = @nuoc
GO

EXECUTE dbo.sp_search @nuoc = 'Zambia' -- varchar(20)
GO

-- Trình tự
-- Tạo
	--CREATE PROCEDURE [Tên PROCEDURE]
	-- [@thamso1 type, @thamso2 type,...]
	--AS
	--SELECT * FROM [Bảng]
	--WHERE ĐK ứng với tham số
--Sử dụng
	--EXECUTE [tên PROCEDURE] [gtthamso1,gtthamso2,...]

--Đếm xem có bao nhiêu sản phẩm có màu sắc được truyền vào
--C1
CREATE PROCEDURE sp_color
	@color VARCHAR(20),
	@return INT OUTPUT
AS
SELECT @return = COUNT(Color)  FROM Production.Product
WHERE Color = @color
GO

DECLARE @return INT;
EXECUTE dbo.sp_color @color = 'Black',             
                     @return = @return OUTPUT 
PRINT @return
GO

--Đếm xem có bao nhiêu sản phẩm có màu sắc được truyền vào
--C2
CREATE PROCEDURE sp_color2
	@color VARCHAR(20)
AS
DECLARE @return INT
SELECT @return=COUNT(Color) FROM Production.Product
WHERE Color = @color
RETURN @return
GO

DECLARE @return INT
EXECUTE @return = dbo.sp_color2 @color = 'Black' -- varchar(20)
PRINT @return
