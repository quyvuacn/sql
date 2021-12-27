CREATE DATABASE HighlandsCoffee
GO

CREATE TABLE City(
 CityId INT PRIMARY KEY,
 CityName NVARCHAR(200)
)
GO

CREATE TABLE District(
	DistrictId INT PRIMARY KEY,
	DistrictName NVARCHAR(200),
	CityId INT FOREIGN KEY REFERENCES City(CityId)
)
GO

CREATE TABLE Stores(
	StoreId INT PRIMARY KEY,
	StoreName NVARCHAR(200),
	DistrictId INT FOREIGN KEY REFERENCES District(DistrictId),
)

CREATE TABLE Utilities(
	UtilitiId INT PRIMARY KEY,
	UtilitiName NVARCHAR(200),
)
GO

CREATE TABLE Utiliti_Wifi(
	UtilitiId INT FOREIGN KEY REFERENCES Utilities(UtilitiId) DEFAULT(0),
	StoreId INT FOREIGN KEY REFERENCES Stores(StoreId) UNIQUE
)
GO

CREATE TABLE Utiliti_Card(
	UtilitiId INT FOREIGN KEY REFERENCES Utilities(UtilitiId) DEFAULT(1),
	StoreId INT FOREIGN KEY REFERENCES Stores(StoreId) UNIQUE
)
GO

INSERT INTO City (CityId,CityName)
VALUES
	(17,  -- CityId - int
    N'Thái Bình' -- CityName - nvarchar(200)
    ),
	(35,  -- CityId - int
    N'Ninh Bình' -- CityName - nvarchar(200)
    ),
	(20,  -- CityId - int
    N'Thái Nguyên' -- CityName - nvarchar(200)
    )
GO

INSERT INTO District
(
    DistrictId,
    DistrictName,
    CityId
)
VALUES
	(1700,   -- DistrictId - int
    N'Thái Thụy', -- DistrictName - nvarchar(200)
    17   -- CityId - int
    ),
	(1701,   -- DistrictId - int
    N'Đông Hưng', -- DistrictName - nvarchar(200)
    17   -- CityId - int
    ),
	(1702,   -- DistrictId - int
    N'Hưng Hà', -- DistrictName - nvarchar(200)
    17   -- CityId - int
    ),
	(3500,   -- DistrictId - int
    N'Gia Viễn', -- DistrictName - nvarchar(200)
    35   -- CityId - int
    ),
	(3501,   -- DistrictId - int
    N'Hoa Lư', -- DistrictName - nvarchar(200)
    35   -- CityId - int
    ),
	(3502,   -- DistrictId - int
    N'Nho Quan', -- DistrictName - nvarchar(200)
    35   -- CityId - int
    ),
	(2000,   -- DistrictId - int
    N'Đại Từ', -- DistrictName - nvarchar(200)
    20   -- CityId - int
    ),
	(2001,   -- DistrictId - int
    N'Đồng Hỷ', -- DistrictName - nvarchar(200)
    20   -- CityId - int
    ),
	(2002,   -- DistrictId - int
    N'Phổ Yên', -- DistrictName - nvarchar(200)
    20   -- CityId - int
    )
GO

INSERT INTO Stores
(
    StoreId,
    StoreName,
    DistrictId
)
VALUES
	(1,   -- StoreId - int
    N'Black', -- StoreName - nvarchar(200)
    1700    -- DistrictId - int
    ),
	(2,   -- StoreId - int
    N'Pink', -- StoreName - nvarchar(200)
    1700    -- DistrictId - int
    ),
	(3,   -- StoreId - int
    N'Red', -- StoreName - nvarchar(200)
    2000    -- DistrictId - int
    ),
	(4,   -- StoreId - int
    N'Green', -- StoreName - nvarchar(200)
    3502    -- DistrictId - int
    ),
	(5,   -- StoreId - int
    N'Blue', -- StoreName - nvarchar(200)
    1700    -- DistrictId - int
    )
GO


INSERT INTO Utilities
(
    UtilitiId,
    UtilitiName
)
VALUES
	(0,  -- UtilitiId - int
    N'Wifi miễn phí' -- UtilitiName - nvarchar(200)
    ),
	(1,  -- UtilitiId - int
    N'Thanh toán bằng thẻ' -- UtilitiName - nvarchar(200)
    )
GO

INSERT INTO Utiliti_Wifi
(
    UtilitiId,
    StoreId
)
VALUES
	(0, -- UtilitiId - int
    1  -- StoreId - int
    ),
	(0, -- UtilitiId - int
    2  -- StoreId - int
    ),
	(0, -- UtilitiId - int
    3 -- StoreId - int
    )
GO

INSERT INTO Utiliti_Card
(
    UtilitiId,
    StoreId
)
VALUES
	(1, -- UtilitiId - int
    2  -- StoreId - int
    ),
	(1, -- UtilitiId - int
    3  -- StoreId - int
    ),
	(1, -- UtilitiId - int
    4  -- StoreId - int
    )
--Truy vấn tên tỉnh
SELECT CityName FROM City 
	WHERE CityName LIKE N'Ninh %'
--Truy vấn tên của huyện
SELECT City.CityName,District.DistrictName
FROM City 
JOIN District 
ON City.CityId = District.CityId
WHERE District.DistrictName LIKE 'Thái%'
--Truy vấn tên quán
SELECT City.CityName,District.DistrictName,Stores.StoreName
FROM City 
JOIN District 
ON City.CityId = District.CityId
JOIN Stores
ON Stores.DistrictId = District.DistrictId
WHERE Stores.StoreName LIKE N'Bl%'










	
