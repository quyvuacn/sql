CREATE DATABASE EX01_Lab09
GO

USE EX01_Lab09
GO

CREATE TABLE Books(
	BookCode INT PRIMARY KEY,
	Category NVARCHAR(50) NOT NULL,
	Author NVARCHAR(50) NOT NULL,
	Publisher NVARCHAR(50),
	Title NVARCHAR(100) NOT NULL,
	Price MONEY NOT NULL CHECK (Price>0),
	InStore INT
)
GO

CREATE TABLE Customer(
	CustomerID INT IDENTITY PRIMARY KEY,
	CustumerName NVARCHAR(100) NOT NULL,
	Address NVARCHAR(100),
	Phone CHAR(15) CHECK(ISNUMERIC(Phone)=1)
)
GO

CREATE TABLE BookSold(
	BookSoldID INT PRIMARY KEY, --Mã đơn hàng sách
	CustomerID INT FOREIGN KEY REFERENCES dbo.Customer(CustomerID),
	BookCode INT FOREIGN KEY REFERENCES dbo.Books(BookCode),
	Date DATETIME NOT NULL,
	Price MONEY NOT NULL CHECK(Price>0),
	Amount INT NOT NULL, -- Số lượng sách đã bán
)
GO

INSERT INTO dbo.Customer
(
    CustumerName,
    Address,
    Phone
)
VALUES
(   N'Nguyễn Văn A', -- CustumerName - nvarchar(100)
    N'Hà Nội', -- Address - nvarchar(100)
    '123456'   -- Phone - char(15)
    ),
(   N'Nguyễn Văn B', -- CustumerName - nvarchar(100)
    N'Thái Nguyên', -- Address - nvarchar(100)
    '123456'   -- Phone - char(15)
    ),
(   N'Nguyễn Văn C', -- CustumerName - nvarchar(100)
    N'Hải Dương', -- Address - nvarchar(100)
    '123456'   -- Phone - char(15)
    ),
(   N'Nguyễn Văn D', -- CustumerName - nvarchar(100)
    N'Thái Bình', -- Address - nvarchar(100)
    '123456'   -- Phone - char(15)
    ),
(   N'Lê Thị Quang Anh', -- CustumerName - nvarchar(100)
    N'Hà Nội', -- Address - nvarchar(100)
    '123456'   -- Phone - char(15)
    )

INSERT INTO dbo.Books
(
    BookCode,
    Category,
    Author,
    Publisher,
    Title,
    Price,
    InStore
)
VALUES
(   1,    -- BookCode - int
    N'Ngôn Lù',  -- Category - nvarchar(50)
    N'Vô danh',  -- Author - nvarchar(50)
    N'Kim Đồng',  -- Publisher - nvarchar(50)
    N'Yêu',  -- Title - nvarchar(100)
    200, -- Price - money
    10     -- InStore - int
    ),
(   2,    -- BookCode - int
    N'Kiếm hiệp',  -- Category - nvarchar(50)
    N'Vô danh',  -- Author - nvarchar(50)
    N'Kim Đồng',  -- Publisher - nvarchar(50)
    N'Kiếm hiệp 4.0',  -- Title - nvarchar(100)
    250, -- Price - money
    10     -- InStore - int
    ),
(   3,    -- BookCode - int
    N'Trinh Thám',  -- Category - nvarchar(50)
    N'Vô danh',  -- Author - nvarchar(50)
    N'Kim Đồng',  -- Publisher - nvarchar(50)
    N'Thám tử lừng danh Conan',  -- Title - nvarchar(100)
    150, -- Price - money
    20    -- InStore - int
    ),
(   4,    -- BookCode - int
    N'Truyện Thiếu Nhi',  -- Category - nvarchar(50)
    N'Tokuda',  -- Author - nvarchar(50)
    N'Nhật Bản',  -- Publisher - nvarchar(50)
    N'Người ông luôn hết mình vì con cháu',  -- Title - nvarchar(100)
    350, -- Price - money
    200   -- InStore - int
    ),
(   5,    -- BookCode - int
    N'Truyện Thiếu Nhi',  -- Category - nvarchar(50)
    N'Vô danh',  -- Author - nvarchar(50)
    N'Kim Đồng',  -- Publisher - nvarchar(50)
    N'Trạng Tí',  -- Title - nvarchar(100)
    150, -- Price - money
    20    -- InStore - int
    )

INSERT INTO dbo.BookSold
(
    BookSoldID,
    CustomerID,
    BookCode,
    Date,
    Price,
    Amount
)
VALUES
(   1,         -- BookSoldID - int
    1,         -- CustomerID - int
    2,         -- BookCode - int
    GETDATE(), -- Date - datetime
    200,      -- Price - money
    1          -- Amount - int
    ),
(   2,         -- BookSoldID - int
    1,         -- CustomerID - int
    2,         -- BookCode - int
    GETDATE(), -- Date - datetime
    250,      -- Price - money
    1          -- Amount - int
    ),
(   3,         -- BookSoldID - int
    3,         -- CustomerID - int
    4,         -- BookCode - int
    GETDATE(), -- Date - datetime
    250,      -- Price - money
    0          -- Amount - int
    ),
(   4,         -- BookSoldID - int
    5,         -- CustomerID - int
    3,         -- BookCode - int
    GETDATE(), -- Date - datetime
    350,      -- Price - money
    2          -- Amount - int
    ),
(   5,         -- BookSoldID - int
    5,         -- CustomerID - int
    3,         -- BookCode - int
    GETDATE(), -- Date - datetime
    250,      -- Price - money
    10          -- Amount - int
    )
--2
CREATE VIEW BookList
AS
SELECT Books.BookCode,Title,Books.Price,Amount  FROM dbo.BookSold
JOIN dbo.Books
ON Books.BookCode = BookSold.BookCode


--3
CREATE VIEW CustomerList
AS
SELECT BookSold.CustomerID,CustumerName,Address,SUM(Amount) AS Amount FROM dbo.Customer
JOIN dbo.BookSold
ON BookSold.CustomerID = Customer.CustomerID
GROUP BY BookSold.CustomerID,CustumerName,Address

SELECT * FROM CustomerList


--4
CREATE VIEW CustomerMonth
AS
SELECT BookSold.CustomerID,CustumerName,Address,SUM(Amount) AS Amount FROM dbo.Customer
JOIN dbo.BookSold
ON BookSold.CustomerID = Customer.CustomerID
WHERE Date = MONTH(GETDATE()) - 1
GROUP BY BookSold.CustomerID,CustumerName,Address

SELECT * FROM CustomerMonth

--5
CREATE VIEW Customer_Bill
AS
SELECT BookSold.CustomerID,CustumerName,SUM(BookSold.Price*BookSold.Amount) AS CALC FROM dbo.Customer
JOIN dbo.BookSold
ON BookSold.CustomerID = Customer.CustomerID
GROUP BY  BookSold.CustomerID,CustumerName

SELECT * FROM Customer_Bill