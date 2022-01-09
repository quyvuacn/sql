CREATE DATABASE ASS04
GO

USE ASS04
GO

CREATE TABLE NhanVien(
	MaNV INT IDENTITY PRIMARY KEY,
	TenNV NVARCHAR(100) NOT NULL
)
GO
 
CREATE TABLE LoaiSP(
	MaloaiSP INT  PRIMARY KEY,
	TenLoaiSP NVARCHAR(100) NOT NULL UNIQUE
)
GO

CREATE TABLE SanPham(
	MaSP INT IDENTITY PRIMARY KEY,
	TenSP NVARCHAR(100) NOT NULL,
	MaLoaiSP INT FOREIGN KEY REFERENCES dbo.LoaiSP(MaloaiSP)
)
GO

CREATE TABLE PhuTrach(
	MaSP INT FOREIGN KEY REFERENCES SanPham(MaSP),
	NVPhuTrach INT FOREIGN KEY REFERENCES dbo.NhanVien(MaNV),
	NSX DATE
)
GO


INSERT INTO dbo.NhanVien
(
    TenNV
)
VALUES
(N'Vũ Viết Quý' -- TenNV - nvarchar(100)
    ),
(N'Nguyễn Văn A' -- TenNV - nvarchar(100)
    ),
(N'Nguyễn Văn B' -- TenNV - nvarchar(100)
    ),
(N'Nguyễn Văn C' -- TenNV - nvarchar(100)
    )

INSERT INTO dbo.LoaiSP
(
    MaloaiSP,
    TenLoaiSP
)
VALUES
(   0,  -- MaloaiSP - int
    N'Z37E' -- TenLoaiSP - nvarchar(100)
    ),
(   1,  -- MaloaiSP - int
    N'MD30' -- TenLoaiSP - nvarchar(100)
    ),
(   2,  -- MaloaiSP - int
    N'MH370' -- TenLoaiSP - nvarchar(100)
    )

INSERT INTO dbo.SanPham
(
    TenSP,
    MaLoaiSP 
)
VALUES
(   N'Máy tính sách tay Z37', -- TenSP - nvarchar(100)
    0  -- MaLoaiSP - int
    ),
(   N'Máy bay  Boeing 747', -- TenSP - nvarchar(100)
    1  -- MaLoaiSP - int
    )

INSERT INTO dbo.PhuTrach
(
    MaSP,
    NVPhuTrach
)
VALUES
(   1, -- MaSP - int
    1  -- NVPhuTrach - int
    ),
(   1, -- MaSP - int
    2  -- NVPhuTrach - int
    ),
(   2, -- MaSP - int
    3  -- NVPhuTrach - int
    )

SELECT * FROM dbo.PhuTrach

--4a. Liệt kê danh sách loại SP của công ty
SELECT TenLoaiSP FROM dbo.LoaiSP

--4b. Liệt kê danh sách sản phẩm của công ty
SELECT DISTINCT TenSP FROM dbo.SanPham

--4c. Liệt kê danh sách người chịu trách nhiệm của công ty
SELECT TenNV,TenSP FROM dbo.SanPham
JOIN dbo.PhuTrach
ON PhuTrach.MaSP = SanPham.MaSP
JOIN dbo.NhanVien 
ON MaNV = NVPhuTrach

--5a. Liệt kê các danh sách loại SP của công ty theo thứ tự a-z
SELECT DISTINCT TenSP FROM dbo.SanPham
ORDER BY TenSP

--5b. Liệt kê danh sách người phụ trách a-z
SELECT TenNV,TenSP FROM dbo.SanPham
JOIN dbo.PhuTrach
ON PhuTrach.MaSP = SanPham.MaSP
JOIN dbo.NhanVien 
ON MaNV = NVPhuTrach
ORDER BY TenNV

--5c. Liệt kê các sp có mã sp là 0
SELECT * FROM dbo.SanPham
WHERE MaSP = 1

--5d. Liệt kê sản phẩm Vũ Viết Quý chịu trách nhiệm
SELECT TenSP FROM dbo.SanPham
JOIN dbo.PhuTrach
ON PhuTrach.MaSP = SanPham.MaSP 
WHERE NVPhuTrach =(
	SELECT MaNV FROM dbo.NhanVien
	WHERE TenNV = N'Vũ Viết Quý'
)

--6a. Số sp từng loại
SELECT MaLoaiSP,COUNT(MaSP) AS 'Số SP' FROM dbo.SanPham
GROUP BY MaLoaiSP

--6c. Hiển thị toàn bộ thông tin sản phẩm
SELECT TenSP,TenLoaiSP FROM dbo.SanPham
JOIN dbo.LoaiSP
ON LoaiSP.MaloaiSP = SanPham.MaLoaiSP

--6d. Hiển thị thông tin về người chịu trách nhiệm, lsp và sp
SELECT TenNV,TenSP,MaLoaiSP FROM dbo.SanPham
JOIN dbo.PhuTrach
ON PhuTrach.MaSP = SanPham.MaSP
JOIN dbo.NhanVien 
ON MaNV = NVPhuTrach
ORDER BY TenNV

--7a. NSX <= ngày hiện tại
ALTER TABLE dbo.PhuTrach
	ADD CHECK(NSX<=GETDATE())
--7c.Thêm trường phiên bản của SP
ALTER TABLE dbo.SanPham 
	ADD PhienBan INT 

--8a. index
CREATE INDEX IX_NguoiCTN ON dbo.NhanVien(TenNV)
GO

--8b. View
CREATE VIEW View_SanPham
AS
SELECT TenSP,TenLoaiSP FROM dbo.SanPham
JOIN dbo.LoaiSP
ON LoaiSP.MaloaiSP = SanPham.MaLoaiSP
GO

CREATE VIEW View_SanPham_NCTN
AS
SELECT PhuTrach.MaSP,TenSP,NSX,TenNV FROM dbo.NhanVien
JOIN dbo.PhuTrach
ON PhuTrach.NVPhuTrach = NhanVien.MaNV
JOIN dbo.SanPham
ON SanPham.MaSP = PhuTrach.MaSP
GO

--8c: SP_Them_LoaiSP: Thêm mới một loại sản phẩm
CREATE PROCEDURE SP_Them_LoaiSP
	@MaloaiSP INT,
	@TenLoaiSP NVARCHAR(50)
AS
BEGIN
	IF (@MaloaiSP IS NOT NULL AND @TenLoaiSP IS NOT NULL)
	INSERT INTO dbo.LoaiSP
	(
	    MaloaiSP,
	    TenLoaiSP
	)
	VALUES
	(   @MaloaiSP,  -- MaloaiSP - int
	    @TenLoaiSP -- TenLoaiSP - nvarchar(100)
	    )
END
GO

--SP_Them_NCTN: Thêm mới người chịu trách nhiệm
CREATE PROCEDURE SP_Them_NCTN
	@TenNV NVARCHAR(100)
AS
BEGIN
	IF (@TenNV IS NOT NULL)
	INSERT INTO dbo.NhanVien
	(
	    TenNV
	)
	VALUES
	(@TenNV -- TenNV - nvarchar(100)
	    )
END
GO

--SP_Them_SanPham: Thêm mới một sản phẩm
CREATE PROCEDURE SP_Them_SanPham
	@MaSP INT,
	@TenSP NVARCHAR(100),
	@MaLoaiSP INT,
	@PB INT
AS
BEGIN 
	IF(@MaSP IS NOT NULL AND @TenSP IS NOT NULL AND @MaLoaiSP IS NOT NULL)
	INSERT INTO dbo.SanPham
	(
	    TenSP,
	    MaLoaiSP,
	    PhienBan
	)
	VALUES
	(   @TenSP, -- TenSP - nvarchar(100)
	    @MaLoaiSP,   -- MaLoaiSP - int
	    @PB   -- PhienBan - int
	    )
END
GO

--SP_Xoa_SanPham: Xóa một sản phẩm theo mã sản phẩm
CREATE PROCEDURE SP_Xoa_SanPham
	@MaSP INT
AS
DELETE FROM dbo.SanPham
WHERE MaSP = @MaSP
GO
--SP_Xoa_SanPham_TheoLoai: Xóa các sản phẩm của một loại nào đó
CREATE PROCEDURE SP_Xoa_SanPham_TheoLoai
	@MaLoaiSP INT
AS
DELETE FROM dbo.SanPham
WHERE MaLoaiSP = @MaLoaiSP
GO


