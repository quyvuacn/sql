CREATE DATABASE NhanSu
GO

USE NhanSu
GO

CREATE TABLE PhongBan(
	MaPB VARCHAR(7) PRIMARY KEY,
	TenPB NVARCHAR(50)
)
GO

CREATE TABLE NhanVien(
	MaNV VARCHAR(7) PRIMARY KEY,
	TenNV NVARCHAR(200),
	NgaySinh DATETIME,
	CMND CHAR(15) CHECK( ISNUMERIC(CMND) = 1) ,
	GioiTinh CHAR(1) CHECK (GioiTinh='M'OR GioiTinh='F') DEFAULT('M'),
	DiaChi NVARCHAR(100),
	NgayVaoLam DATETIME,
	MaPB VARCHAR(7) FOREIGN KEY REFERENCES PhongBan(MaPB),
 CHECK(YEAR(NgayVaoLam)-YEAR(NgaySinh)>20)
)
GO

CREATE TABLE LuongDA(
	MaDA VARCHAR(7) ,
	MaNV VARCHAR(7) FOREIGN KEY REFERENCES dbo.NhanVien(MaNV),
	NgayNhan DATETIME DEFAULT(GETDATE()),
	SoTien MONEY CHECK(SoTien>0),
	PRIMARY KEY(MaDA,MaNV)
)
GO

INSERT INTO dbo.PhongBan
(
    MaPB,
    TenPB
)
VALUES
(   'PB01', -- MaPB - varchar(7)
    N'Phòng ban 1' -- TenPB - nvarchar(50)
    ),
(   'PB02', -- MaPB - varchar(7)
    N'Phòng ban 2' -- TenPB - nvarchar(50)
    ),
(   'PB0', -- MaPB - varchar(7)
    N'Phòng ban 3' -- TenPB - nvarchar(50)
    ),
(   'PB04', -- MaPB - varchar(7)
    N'Phòng ban 4' -- TenPB - nvarchar(50)
    ),
(   'PB05', -- MaPB - varchar(7)
    N'Phòng ban 5' -- TenPB - nvarchar(50)
    )

INSERT INTO dbo.NhanVien
(
    MaNV,
    TenNV,
    NgaySinh,
    CMND,
    GioiTinh,
    DiaChi,
    NgayVaoLam,
    MaPB
)
VALUES
(   'NV01',        -- MaNV - varchar(7)
    N'Nguyễn Vân A',       -- TenNV - nvarchar(200)
    '19990101', -- NgaySinh - datetime
    '123456789',        -- CMND - char(9)
    'M',        -- GioiTinh - char(1)
    N'Thái Thụy,Thái Bình',       -- DiaChi - nvarchar(100)
    GETDATE(), -- NgayVaoLam - datetime
    'PB01'         -- MaPB - varchar(7)
    ),
(   'NV02',        -- MaNV - varchar(7)
    N'Nguyễn Vân B',       -- TenNV - nvarchar(200)
    '19990201', -- NgaySinh - datetime
    '123456799',        -- CMND - char(9)
    'M',        -- GioiTinh - char(1)
    N'Hà Đông,Hà Nội',       -- DiaChi - nvarchar(100)
    GETDATE(), -- NgayVaoLam - datetime
    'PB01'         -- MaPB - varchar(7)
    ),
(   'NV03',        -- MaNV - varchar(7)
    N'Nguyễn Vân C',       -- TenNV - nvarchar(200)
    '19990301', -- NgaySinh - datetime
    '123456899',        -- CMND - char(9)
    'M',        -- GioiTinh - char(1)
    N'Thái Nguyên',       -- DiaChi - nvarchar(100)
    GETDATE(), -- NgayVaoLam - datetime
    'PB01'         -- MaPB - varchar(7)
    ),
(   'NV04',        -- MaNV - varchar(7)
    N'Nguyễn Thị D',       -- TenNV - nvarchar(200)
    '19990501', -- NgaySinh - datetime
    '123456699',        -- CMND - char(9)
    'F',        -- GioiTinh - char(1)
    N'Hà Đông,Hà Nội',       -- DiaChi - nvarchar(100)
    GETDATE(), -- NgayVaoLam - datetime
    'PB02'         -- MaPB - varchar(7)
    ),
(   'NV05',        -- MaNV - varchar(7)
    N'Nguyễn Thị E',       -- TenNV - nvarchar(200)
    '19990211', -- NgaySinh - datetime
    '123466699',        -- CMND - char(9)
    'F',        -- GioiTinh - char(1)
    N'Hà Đông,Hà Nội',       -- DiaChi - nvarchar(100)
    GETDATE(), -- NgayVaoLam - datetime
    'PB02'         -- MaPB - varchar(7)
    ),
	(   'NV06',        -- MaNV - varchar(7)
    N'Vũ Viết Quý',       -- TenNV - nvarchar(200)
    '19990211', -- NgaySinh - datetime
    '123466699',        -- CMND - char(9)
    'F',        -- GioiTinh - char(1)
    N'Hà Đông,Hà Nội',       -- DiaChi - nvarchar(100)
    GETDATE(), -- NgayVaoLam - datetime
    'PB05'         -- MaPB - varchar(7)
    ),
(   'NV07',        -- MaNV - varchar(7)
    N'Vũ Viết Sơn',       -- TenNV - nvarchar(200)
    '19990211', -- NgaySinh - datetime
    '123466699',        -- CMND - char(9)
    'F',        -- GioiTinh - char(1)
    N'Hà Đông,Hà Nội',       -- DiaChi - nvarchar(100)
    GETDATE(), -- NgayVaoLam - datetime
    'PB05'         -- MaPB - varchar(7)
    )


	

INSERT INTO dbo.LuongDA
(
    MaDA,
    MaNV,
    NgayNhan,
    SoTien
)
VALUES
(   'DA01',        -- MaDA - varchar(7)
    'NV01',        -- MaNV - varchar(7)
    GETDATE(), -- NgayNhan - datetime
    100       -- SoTien - money
    ),
(   'DA02',        -- MaDA - varchar(7)
    'NV02',        -- MaNV - varchar(7)
    GETDATE(), -- NgayNhan - datetime
    150     -- SoTien - money
    ),
(   'DA03',        -- MaDA - varchar(7)
    'NV03',        -- MaNV - varchar(7)
    GETDATE(), -- NgayNhan - datetime
    150     -- SoTien - money
    ),
(   'DA04',        -- MaDA - varchar(7)
    'NV04',        -- MaNV - varchar(7)
    GETDATE(), -- NgayNhan - datetime
    150     -- SoTien - money
    ),
(   'DA05',        -- MaDA - varchar(7)
    'NV05',        -- MaNV - varchar(7)
    GETDATE(), -- NgayNhan - datetime
    150     -- SoTien - money
    )

--2.
SELECT * FROM dbo.LuongDA
SELECT * FROM dbo.NhanVien 
SELECT * FROM dbo.PhongBan
--3
SELECT * FROM dbo.NhanVien
WHERE GioiTinh = 'F'
--4
SELECT * FROM dbo.LuongDA
--5 : Tổng lương từng nhân viên
SELECT MaNV,SUM(SoTien) AS 'Tổng lương' 
FROM dbo.LuongDA
GROUP BY MaNV
--6: Truy vấn nhân viên trong phòng ban
SELECT TenNV,MaPB FROM dbo.NhanVien
WHERE MaPB IN(
	SELECT MaPB FROM dbo.PhongBan
	WHERE TenPB = N'Phòng Ban 1'
)
--7: Hiển thị mức lương của nhân viên phòng ban 2
SELECT NhanVien.TenNV,LuongDA.SoTien FROM dbo.NhanVien 
JOIN dbo.LuongDA
ON LuongDA.MaNV = NhanVien.MaNV
WHERE MaPB IN(
	SELECT MaPB FROM dbo.PhongBan
	WHERE TenPB = N'Phòng Ban 2'
)
--8: Hiển thị số lượng nhân viên của từng phòng
SELECT MaPB,COUNT(MaNV) AS 'Số lượng nhân viên'
FROM dbo.NhanVien
GROUP BY MaPB
--9: Hiển thị nhân viên tham gia trên 1 DA
SELECT MaNV,COUNT(MaDA) FROM dbo.LuongDA
GROUP BY MaNV 
HAVING COUNT(MaDA)>0
--10: Hiển thị phòng ban có nhiều nhân viên nhất
SELECT Count_PB.MaPB,Count_PB.NV FROM (
SELECT  MaPB,COUNT(MaNV) AS NV FROM dbo.NhanVien
GROUP BY MaPB ) AS Count_PB
WHERE Count_PB.NV = (
	SELECT MAX(Count_PB.NV) FROM (
	SELECT  MaPB,COUNT(MaNV) AS NV FROM dbo.NhanVien
	GROUP BY MaPB
	) AS Count_PB
)
--11: Tổng số nhân viên trong Phòng Ban 1
SELECT COUNT(MaNV) AS 'Số lượng nhân viên'
FROM dbo.NhanVien
WHERE MaPB = 'PB01'
GROUP BY MaPB
--12: Hiển thị tổng lương của các nhân viên có CMT tận cùng là 99
SELECT LuongDA.MaNV,NhanVien.CMND,SUM(SoTien) AS 'Tổng Lương'
FROM dbo.LuongDA
JOIN dbo.NhanVien
ON NhanVien.MaNV = LuongDA.MaNV
WHERE RIGHT(CMND,2) = '99'
GROUP BY LuongDA.MaNV,NhanVien.CMND
--13: Liệt kê nhân viên có lương cao nhất
SELECT * FROM (
SELECT  MaNV,SUM(SoTien) AS Luong FROM dbo.LuongDA 
GROUP BY MaNV 
) AS Tabe_Luong
WHERE Tabe_Luong.Luong = (
    SELECT MAX(Tabe_Luong.Luong) FROM 
	(
	SELECT  MaNV,SUM(SoTien) AS Luong FROM dbo.LuongDA 
	GROUP BY MaNV 
	) AS Tabe_Luong
)
--14: Nữ  + phòng ban 2 + tổng lương > 90
SELECT NhanVien.TenNV,SUM(SoTien) FROM dbo.NhanVien
JOIN dbo.LuongDA 
ON LuongDA.MaNV = NhanVien.MaNV
WHERE GioiTinh = 'F' AND MaPB = (
	SELECT MaPB FROM dbo.PhongBan
	WHERE TenPB = 'Phòng Ban 2'
)
GROUP BY TenNV
HAVING SUM(SoTien) > 90
--15: Tổng lương trên từng phòng
SELECT MaPB,SUM(SoTien) AS 'Tổng lương phòng ban'
FROM dbo.LuongDA
JOIN dbo.NhanVien
ON NhanVien.MaNV = LuongDA.MaNV
GROUP BY MaPB
--16: Liệt kê các dự án có ít nhất 2 ng tham gia
SELECT MaDA,COUNT(MaNV) AS 'Số người tham gia'
FROM dbo.LuongDA
GROUP BY MaDA
HAVING COUNT(MaNV) >=1
--17: Liệt kê thông tin nhân viên có tên bắt đầu bằng 'N'
SELECT * FROM dbo.NhanVien
WHERE LEFT(TenNV,1) = 'N'
--18: Hiển thị thông tin chi tiết các  nhân viên nhận tiền dự án năm 2021
SELECT NhanVien.MaNV,TenNV,NgaySinh,CMND,GioiTinh,DiaChi,NgayVaoLam FROM NhanVien
JOIN dbo.LuongDA 
ON NhanVien.MaNV = LuongDA.MaNV
WHERE YEAR(NgayNhan) = 2021
--19: Hiển thị chi tiết thông tin các nhân viên không tham gia dự án nào
SELECT * FROM dbo.NhanVien
WHERE MaNV NOT IN(
SELECT MaNV FROM dbo.LuongDA
)
--20: Xóa dự 1 dự án DA05
DELETE dbo.LuongDA WHERE MaDA = 'DA05'
--21: Xóa nhân viên có tổng lương là 100 đi từ bảng LuongDA
DELETE FROM dbo.LuongDA 
WHERE SoTien = 100
--22: Cập nhật lương cho DA02 tăng thêm 10% lương
UPDATE LuongDA
SET SoTien = SoTien*110/100
WHERE MaDA = 'DA02';
SELECT * FROM LuongDA
--23: Xóa các nhân viên trong bảng NhanVien khi có dữ liệu trong bảng DA
DELETE FROM NhanVien
WHERE MaNV NOT IN(
SELECT MaNV FROM dbo.LuongDA
)
--24: Đặt lại ngày vào làm của các nhân viên PB01 là 12/02/2020
UPDATE NhanVien 
SET NgayVaoLam = '20200212'
WHERE MaPB = 'PB01'

