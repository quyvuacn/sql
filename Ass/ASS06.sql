CREATE DATABASE ASS06
GO

USE ASS06
GO

CREATE TABLE NXB(
	Ma_NXB INT IDENTITY PRIMARY KEY,
	NXB NVARCHAR(200) NOT NULL UNIQUE,
	DiaChi NVARCHAR(200) NOT NULL,
)
GO

CREATE TABLE TacGia(
	Ma_TG INT IDENTITY PRIMARY KEY,
	TenTG NVARCHAR(200) NOT NULL 
)
GO

CREATE TABLE LoaiSach(
	Ma_Loai INT IDENTITY PRIMARY KEY,
	LoaiSach NVARCHAR(200) NOT NULL UNIQUE
)

CREATE TABLE ThongTinSach(
	Ma_NXB INT FOREIGN KEY REFERENCES dbo.NXB(Ma_NXB),
	Ma_TG INT FOREIGN KEY REFERENCES dbo.TacGia(Ma_TG),
	Ma_Sach INT IDENTITY UNIQUE,
	TenSach NVARCHAR(200) NOT NULL,
	Ma_Loai INT FOREIGN KEY REFERENCES dbo.LoaiSach(Ma_Loai),
	NamXB DATE NOT NULL,
	LanXB INT NOT NULL,
	Gia MONEY NOT NULL CHECK(Gia>0),
	SL INT CHECK(SL>0) NOT NULL,
    PRIMARY KEY(Ma_Sach,Ma_Loai)
) 
GO

CREATE TABLE ND(
	Ma_Sach INT FOREIGN KEY REFERENCES dbo.ThongTinSach(Ma_Sach),
	ND TEXT
)
GO

INSERT INTO dbo.NXB
(
    NXB,
    DiaChi
)
VALUES
(   N'Kim Đồng', -- NXB - nvarchar(200)
    N'Hà Nội'  -- DiaChi - nvarchar(200)
    ),
(   N'Tri Thức', -- NXB - nvarchar(200)
    N'Hà Nội'  -- DiaChi - nvarchar(200)
    ),
(   N'Tuổi Trẻ', -- NXB - nvarchar(200)
    N'Hà Nội'  -- DiaChi - nvarchar(200)
    ),
(   N'Văn Hóa - Nghệ Thuật', -- NXB - nvarchar(200)
    N'Hà Nội'  -- DiaChi - nvarchar(200)
    )

INSERT INTO dbo.TacGia
(
    TenTG
)
VALUES
(N'Mèo Xù' -- TenTG - nvarchar(200)
    ),
(N'Nguyễn Du' -- TenTG - nvarchar(200)
    ),
(N'Xuân Hương' -- TenTG - nvarchar(200)
    )

INSERT INTO dbo.LoaiSach
(
    LoaiSach
)
VALUES
(N'Ngôn Tình' -- LoaiSach - nvarchar(200)
    ),
(N'Toán Học' -- LoaiSach - nvarchar(200)
    ),
(N'Vật Lý' -- LoaiSach - nvarchar(200)
    ),
(N'Trinh Thám' -- LoaiSach - nvarchar(200)
    ),
(N'Kĩ Năng Sống' -- LoaiSach - nvarchar(200)
    )


INSERT INTO dbo.ThongTinSach
(
    Ma_NXB,
    Ma_TG,
    TenSach,
    Ma_Loai,
    NamXB,
    LanXB,
    Gia,
    SL
)
VALUES
(   4,         -- Ma_NXB - int
    1,         -- Ma_TG - int
    N'Cứ Tin Mình Sẽ Hạnh Phúc',       -- TenSach - nvarchar(200)
    5,         -- Ma_Loai - int
    GETDATE(), -- NamXB - date
    1,         -- LanXB - int
    59000,      -- Gia - money
    200          -- SL - int
    )

INSERT INTO dbo.ND
(
    Ma_Sach,
    ND
)
VALUES
(   1, -- Ma_Sach - int
    'Nỗi đau của hôm nay là món quà của ngày mai!' -- ND - text
    )

--3. Liệt kê sách có năm xuất bạn từ 2008 đến nay
SELECT Ma_Sach,TenSach FROM dbo.ThongTinSach
WHERE YEAR(NamXB) >= 2008 
--4. Liệt kê 10 cuốn sách có giá cao nhất
SELECT TOP 10 Ma_Sach,TenSach,Gia FROM dbo.ThongTinSach
ORDER BY Gia DESC

--5. Tìm cuốn có tiêu đề chứ từ hạnh phúc
SELECT * FROM dbo.ThongTinSach
WHERE TenSach LIKE N'%Hạnh phúc%'

--6. Liệt kê cuốn sách bắt đầu bằng chữ T theo thứ tự giảm giần
SELECT TenSach,Gia FROM dbo.ThongTinSach
WHERE TenSach LIKE 'T%'
ORDER BY Gia DESC

--7. Liệt kê các cuốn sách của nhà SB Văn Hóa - Nghệ Thuật
SELECT TenSach FROM dbo.ThongTinSach
WHERE Ma_NXB = (
	SELECT Ma_NXB FROM dbo.NXB
	WHERE NXB LIKE N'Văn Hóa - Nghệ Thuật'
)

--8. Lấy thông tin chi tiết của nhà SX cuốn Cứ tin mình sẽ hạnh phúc
SELECT * FROM dbo.NXB
WHERE Ma_NXB = (
	SELECT Ma_NXB FROM dbo.ThongTinSach
	WHERE TenSach LIKE N'Cứ tin Mình Sẽ Hạnh Phúc'
)

--9. Hiển thị thông tin của các cuốn sách : Mã sách, Tên sách, Năm xuất bản, Nhà xuất bản, Loại sách 
SELECT Ma_Sach,TenSach,NamXB,NXB,LoaiSach FROM dbo.ThongTinSach
JOIN dbo.NXB 
ON NXB.Ma_NXB = ThongTinSach.Ma_NXB
JOIN dbo.LoaiSach 
ON LoaiSach.Ma_Loai = ThongTinSach.Ma_Loai

--10. Tìm (các) cuốn sách có giá đắt nhất
SELECT Ma_Sach,TenSach,Gia FROM dbo.ThongTinSach
WHERE Gia = (
	SELECT MAX(Gia) FROM dbo.ThongTinSach
)

--11. Tìm cuốn sách có số lượng lớn nhất trong kho
SELECT Ma_Sach,TenSach,SL FROM dbo.ThongTinSach
WHERE SL = (
	SELECT MAX(SL) FROM dbo.ThongTinSach
)

--12. Tìm các cuốn sách của tác giả Mèo Xù
SELECT Ma_Sach,TenSach FROM dbo.ThongTinSach
WHERE Ma_TG = (
	SELECT Ma_TG FROM dbo.TacGia
	WHERE TenTG LIKE N'Mèo Xù'
)

--13. Giảm giá 10% các cuốn sách SB từ 2008 trở về trc
UPDATE dbo.ThongTinSach
SET Gia = Gia*0.9
WHERE YEAR(NamXB) < 2008

--14. Thống kê số đầu sách của mỗi NXB
SELECT NXB,COUNT(Ma_Sach) AS 'Số sách' FROM dbo.ThongTinSach
JOIN dbo.NXB
ON NXB.Ma_NXB = ThongTinSach.Ma_NXB
GROUP BY NXB

--15. Thống kê số đầu sách của mỗi loại sách
SELECT LoaiSach,COUNT(Ma_Sach) AS 'Số sách' FROM dbo.ThongTinSach
JOIN dbo.LoaiSach
ON LoaiSach.Ma_Loai = ThongTinSach.Ma_Loai
GROUP BY LoaiSach

--16. Đặt index
CREATE INDEX IX_Tensach ON ThongTinSach(TenSach)
GO
--17:View
CREATE VIEW View_Sach
AS 
SELECT Ma_Sach,TenTG,NXB,Gia FROM dbo.TacGia
JOIN dbo.ThongTinSach
ON dbo.TacGia.Ma_TG = ThongTinSach.Ma_TG
JOIN dbo.NXB
ON NXB.Ma_NXB = dbo.ThongTinSach.Ma_NXB
GO
--18 Viết Store Procedure:
--SP_Them_Sach: thêm mới một cuốn sách
CREATE PROCEDURE SP_Them_Sach
	@Ma_NXB INT ,
	@Ma_TG INT ,
	@Ma_Sach INT ,
	@Ten_Sach NVARCHAR(100)  ,
	@MaLoai INT ,
	@NamXB DATE ,
	@LanXB INT ,
	@Gia MONEY ,
	@SL INT 
AS 
IF (@Ma_NXB IS NOT NULL AND @Ma_TG IS NOT NULL AND @Ten_Sach IS NOT NULL)
INSERT INTO dbo.ThongTinSach
(
    Ma_NXB,
    Ma_TG,
    TenSach,
    Ma_Loai,
    NamXB,
    LanXB,
    Gia,
    SL
)
VALUES
(   @Ma_NXB,         -- Ma_NXB - int
    @Ma_TG,         -- Ma_TG - int
    @Ten_Sach,       -- TenSach - nvarchar(200)
    @MaLoai,         -- Ma_Loai - int
    @NamXB, -- NamXB - date
    @LanXB,         -- LanXB - int
    @Gia,      -- Gia - money
    @SL          -- SL - int
    )
GO

--SP_Tim_Sach: Tìm các cuốn sách theo từ khóa
CREATE PROCEDURE SP_Tim_Sach
	@key NVARCHAR(50)
AS
SELECT TenSach,TenTG,NXB FROM dbo.NXB
JOIN dbo.ThongTinSach
ON ThongTinSach.Ma_NXB = NXB.Ma_NXB
JOIN dbo.TacGia 
ON TacGia.Ma_TG = ThongTinSach.Ma_TG
WHERE 
	TenSach LIKE '%' + @key +'%' OR
	TenTG LIKE '%' + @key +'%' OR
	NXB LIKE '%' + @key +'%'
ORDER BY TenSach,TenTG,NXB

EXECUTE dbo.SP_Tim_Sach  @key = N'h' -- nvarchar(50)
GO

--SP_Sach_ChuyenMuc:Liệt kê các cuốn sách theo mã chuyên mục
CREATE PROCEDURE SP_Sach_ChuyenMuc
	@key NVARCHAR(100)
AS
SELECT * FROM dbo.ThongTinSach
JOIN dbo.LoaiSach
ON LoaiSach.Ma_Loai = ThongTinSach.Ma_Loai
WHERE LoaiSach LIKE '%' + @key +'%'
