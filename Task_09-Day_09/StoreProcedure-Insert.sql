CREATE DATABASE  Store_Procedure_Insert
GO

CREATE TABLE NhanVien(
	MaNV INT IDENTITY PRIMARY KEY,
	TenNV NVARCHAR(100) NOT NULL,
	NgaySinh DATE 
)
GO


CREATE PROCEDURE sp_insert_NhanVien
	@TenNV NVARCHAR(100),
	@NgaySinh DATE
AS 
BEGIN
	IF(@TenNV IS NOT NULL )
	INSERT INTO dbo.NhanVien
	(
	    TenNV,
	    NgaySinh
	)
	VALUES
	(   @TenNV,      -- TenNV - nvarchar(100)
	    @NgaySinh -- NgaySinh - date
	    )
END
GO

DECLARE @err NVARCHAR(100);
EXEC dbo.sp_insert_NhanVien @TenNV = N'Vũ Viết Quý',             -- nvarchar(100)
                            @NgaySinh = '2022-01-09' -- date
              
SELECT * FROM dbo.NhanVien

GO

