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
	NVPhuTrach INT FOREIGN KEY REFERENCES dbo.NhanVien(MaNV)
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
SELECT * FROM 