﻿CREATE DATABASE ASS03 --Cơ sở dữ liệu lưu trữ thông tin khách hàng đk đt
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
    )
