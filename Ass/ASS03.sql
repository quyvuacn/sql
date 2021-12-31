CREATE DATABASE ASS03 --Cơ sở dữ liệu lưu trữ thông tin khách hàng đk đt
GO

USE ASS03
GO

CREATE TABLE ThueBao(
	MaTB INT IDENTITY PRIMARY KEY,
	TenTB NVARCHAR(100) NOT NULL,
	SCMT CHAR(20) NOT NULL CHECK(ISNUMERIC(SCMT)=1),
	Diachi NVARCHAR(200),
)
GO

CREATE TABLE SoThueBao(
	MaHopDong INT IDENTITY PRIMARY KEY,
	MaTB INT FOREIGN KEY REFERENCES dbo.ThueBao(MaTB),
	SoTB CHAR(15) NOT NULL UNIQUE CHECK(ISNUMERIC(SoTB)=1),
	LoaiTB INT CHECK(LoaiTB=0 OR LoaiTB=1), --0:Trả trước --1:Trả sau
	NgayDK DATE DEFAULT(GETDATE())
)
GO

INSERT INTO dbo.ThueBao
(
    TenTB,
    SCMT,
    Diachi
)
VALUES
(   N'Vũ Viết Quý', -- TenTB - nvarchar(100)
    '034203004985',  -- SCMT - char(20)
    N'Thái Thụy,Thái Bình'  -- Diachi - nvarchar(200)
    ),
(   N'Đặng Kim Thi', -- TenTB - nvarchar(100)
    '123456789',  -- SCMT - char(20)
    N'Hà Nội'  -- Diachi - nvarchar(200)
    ),
(   N'Nguyễn Nguyệt Nga', -- TenTB - nvarchar(100)
    '1234567890',  -- SCMT - char(20)
    N'Hà Nội'  -- Diachi - nvarchar(200)
    )

INSERT INTO dbo.SoThueBao
(   MaTB,
	SoTB,
	LoaiTB,
	NgayDK
)
VALUES
(  	3,        -- MaTB - int
	'0326459773',       -- SoTB - char(15)
	0,        -- LoaiTB - int
	GETDATE() -- NgayDK - date
	)
--4: Hiển thị thông tin khách hàng và thông tin thuê bao
SELECT * FROM dbo.ThueBao
JOIN dbo.SoThueBao 
ON SoThueBao.MaTB = ThueBao.MaTB 
--5a. Hiển thị thông tin thuê bao có CMT là 1234567890
SELECT * FROM dbo.ThueBao
WHERE SCMT = '1234567890'

--5b. Hiển thị thông tin thuê bao có Số Thuê bao là 0326459773
SELECT * FROM dbo.ThueBao
JOIN dbo.SoThueBao 
ON SoThueBao.MaTB = ThueBao.MaTB 
WHERE SoTB = '0326459773'

--5c.Hiển thị các số thuê bao của khách hàng có cmt là 1234567890
SELECT * FROM dbo.ThueBao
JOIN dbo.SoThueBao 
ON SoThueBao.MaTB = ThueBao.MaTB 
WHERE SCMT = '1234567890'

--5d. Liệt kê các thuê bao đk vào ngày 31/12/2021
SELECT TenTB FROM dbo.ThueBao
JOIN dbo.SoThueBao 
ON SoThueBao.MaTB = ThueBao.MaTB 
WHERE NgayDK = '20211231'

--5e. Liệt kê thuê bao sống ở Hà Nội
SELECT * FROM dbo.ThueBao
WHERE Diachi LIKE N'%Hà Nội%'

--6a. Tổng số khách hàng của công ty
SELECT COUNT(MaTB) AS 'Khách hàng' FROM dbo.ThueBao

--6b. Tổng số thuê bao của công ty
SELECT COUNT(MaHopDong) AS 'Hợp đồng' FROM dbo.SoThueBao

--6c. Tổng số thuê bao của công ty đk 12/31/2021
SELECT COUNT(MaHopDong) AS 'Số hợp đồng' FROM dbo.SoThueBao
WHERE NgayDK = '20211231'

--6d. Hiển thị toàn bộ thông tin về khách hàng của các số thuê bao
SELECT * FROM dbo.ThueBao
JOIN dbo.SoThueBao 
ON SoThueBao.MaTB = ThueBao.MaTB 

--7ab.Thay đổi ngày đk => not null
ALTER TABLE dbo.SoThueBao
	ALTER COLUMN NgayDK DATE NOT NULL
ALTER TABLE dbo.SoThueBao
	ADD CHECK(NgayDK<=GETDATE())

--7c. Thay đổi đầu SDT bằng 03 hoặc 09
ALTER TABLE dbo.SoThueBao
	ADD CHECK(LEFT(SoTB,2)='03' OR LEFT(SoTB,2)='09')

--