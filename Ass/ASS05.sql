CREATE DATABASE ASS05
GO

USE ASS05
GO

CREATE TABLE Info(
	UID INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
	DateOfBirth DATE
)
GO

CREATE TABLE Tel(
	UID INT FOREIGN KEY REFERENCES dbo.Info(UID),
	Tel CHAR(10) NOT NULL CHECK(ISNUMERIC(Tel)=1)
)
GO

INSERT INTO dbo.Info
(
    Name,
    DateOfBirth
)
VALUES
(   N'Vũ Viết Quý',      -- Name - nvarchar(100)
    '20030109' -- DateOfBirth - date
    ),
(   N'Nguyễn Văn An',      -- Name - nvarchar(100)
    '20030109' -- DateOfBirth - date
    )

INSERT INTO dbo.Tel
(
	UID,
	Tel
)
VALUES
(   1, -- UID - int
	'0326459773' -- Tel - char(10)
	),
(   1, -- UID - int
	'0969264559' -- Tel - char(10)
	),
(   1, -- UID - int
	'0392156772' -- Tel - char(10)
	)


SELECT * FROM dbo.Info
SELECT * FROM dbo.Tel

--4a. Liệt kê danh sách những người có tỏng danh bạ
SELECT Name FROM dbo.Info
--4b. Liệt kê danh sách sdt có trong danh bạ
SELECT Tel FROM dbo.Tel

--5a. Liệt kê danh sách số người có trong danh bạ a-z
SELECT Name FROM dbo.Info
ORDER BY Name
--5b. Liệt kê số điện thoại của Vũ Viết Quý
SELECT Tel FROM dbo.Tel
WHERE UID = (
	SELECT UID FROM dbo.Info
	WHERE Name = N'Vũ Viết Quý'
)
--5c. Liệt kê những người có ngày sinh 09/01/2003
SELECT Name FROM dbo.Info
WHERE DateOfBirth = '20030109'

--6a. Tìm số lượng std của mỗi người có trong danh bạ
SELECT Name,COUNT(Tel) AS 'Số lượng' FROM dbo.Tel
FULL JOIN dbo.Info
ON Info.UID = Tel.UID
GROUP BY Name
--6b. Đếm số người trong danh bạ sinh tháng 1
SELECT COUNT(UID) AS 'Số đếm' FROM dbo.Info
WHERE MONTH(DateOfBirth) = 1
--6c. Hiển thị toàn bộ thông tin người của từng số điện thoại
SELECT Name,Tel FROM dbo.Info
JOIN dbo.Tel
ON Tel.UID = Info.UID
--6d. Hiển thị thông tin của người có sdt 0326459773
SELECT * FROM dbo.Info
WHERE UID =(
	SELECT UID FROM dbo.Tel
	WHERE Tel = '0326459773'
)

--7a. Viết câu lệnh để thay đổi trường ngày sing trước ngày ht
ALTER TABLE dbo.Info
	ADD CHECK(DateOfBirth<GETDATE())
--7b. Viết câu lênh để thêm trường ngày bắt đầu liên lạc
ALTER TABLE dbo.Tel
	ADD Contact  DATE 

--8a: index
CREATE INDEX IX_HoTen ON dbo.Info(Name)
GO

CREATE INDEX IX_SoDienThoai ON dbo.Tel(Tel)
GO

--8.b View
CREATE VIEW View_SoDienThoai
AS 
SELECT Name,Tel FROM dbo.Tel
JOIN dbo.Info
ON Info.UID = Tel.UID
GO

CREATE VIEW View_SinhNhat
AS
SELECT Name,DateOfBirth,Tel FROM dbo.Info
JOIN dbo.Tel
ON Tel.UID = Info.UID
GO

--8c
--SP_Them_DanhBa: Thêm một người mới vào danh bạn
CREATE PROCEDURE SP_Them_DanhBa
	@Name NVARCHAR(100),
	@DateOfBirth DATE,
	@Tel CHAR(15)
AS 
BEGIN
	IF (@UID IS NOT NULL AND @Name IS NOT NULL AND @Tel IS NOT NULL)
	BEGIN
	INSERT INTO dbo.Info
	(
	    Name,
	    DateOfBirth
	)
	VALUES
	(  @Name,      -- Name - nvarchar(100)
	    @DateOfBirth -- DateOfBirth - date
	    )
	INSERT INTO dbo.Tel
	(
	    UID,
	    Tel,
	    Contact
	)
	VALUES
	(   0,        -- UID - int
	    '',       -- Tel - char(10)
	    GETDATE() -- Contact - date
	    )

	END


END

