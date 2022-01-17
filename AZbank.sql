DROP DATABASE IF EXISTS AZBank
GO

CREATE DATABASE AZBank
GO

USE AZBank
GO

CREATE TABLE Customer(
	CustomerId INT PRIMARY KEY,
	Name NVARCHAR(50),
	City NVARCHAR(50),
	Country NVARCHAR(50),
	Phone NVARCHAR(15),
	Email NVARCHAR(50)
)
GO

CREATE TABLE CustomerAccount(
	AccountNumber CHAR(9) PRIMARY KEY,
	CustomerID INT NOT NULL FOREIGN KEY REFERENCES dbo.Customer(CustomerId),
	Balance MONEY NOT NULL,
	MiniAccount MONEY
)
GO

CREATE TABLE CustomerTransaction(
	TransactionID INT PRIMARY KEY,
	AccountNumber CHAR(9) FOREIGN KEY REFERENCES dbo.CustomerAccount(AccountNumber),
	TransactionDate SMALLDATETIME,
	Amount MONEY,
	DepositorWithdraw BIT
)
GO

INSERT INTO dbo.Customer
(
    CustomerId,
    Name,
    City,
    Country,
    Phone,
    Email
)
VALUES
(   0,   -- CustomerId - int
    N'Vũ Viết Quý', -- Name - nvarchar(50)
    N'Hà Nội', -- City - nvarchar(50)
    N'Hoàn Kiếm', -- Country - nvarchar(50)
    N'0326459773', -- Phone - nvarchar(15)
    N'vuvietquyacn@gmail.com'  -- Email - nvarchar(50)
    ),
(   1,   -- CustomerId - int
    N'Đinh Quang Anh', -- Name - nvarchar(50)
    N'Ninh Bình', -- City - nvarchar(50)
    N'Nho Quan,Xích Thổ', -- Country - nvarchar(50)
    N'0987999999', -- Phone - nvarchar(15)
    N'quanganhzela@gmail.com'  -- Email - nvarchar(50)
    ),
(   2,   -- CustomerId - int
    N'Tạ Duy Linh', -- Name - nvarchar(50)
    N'Thái Nguyên', -- City - nvarchar(50)
    N'Đồng Hỉ,Nam Hòa', -- Country - nvarchar(50)
    N'034599999', -- Phone - nvarchar(15)
    N'duylinhlangben@gmail.com'  -- Email - nvarchar(50)
    )

INSERT INTO dbo.CustomerAccount
(
    AccountNumber,
    CustomerID,
    Balance,
    MiniAccount
)
VALUES
(   '369888888',   -- AccountNumber - char(9)
    0,    -- CustomerID - int
    1000000000, -- Balance - money
    10000000  -- MiniAccount - money
    ),
(   '164647554',   -- AccountNumber - char(9)
    1,    -- CustomerID - int
    2000000000, -- Balance - money
    10000000  -- MiniAccount - money
    ),
(   '123666666',   -- AccountNumber - char(9)
    2,    -- CustomerID - int
    1000000000, -- Balance - money
    10000000  -- MiniAccount - money
    )

INSERT INTO dbo.CustomerTransaction
(
    TransactionID,
    AccountNumber,
    TransactionDate,
    Amount,
    DepositorWithdraw
)
VALUES
(   0,                     -- TransactionID - int
    '369888888',                    -- AccountNumber - char(9)
    '2022-01-17 01:52:54', -- TransactionDate - smalldatetime
    50000,                  -- Amount - money
    0                   -- DepositorWithdraw - bit
    ),
(   1,                     -- TransactionID - int
    '164647554',                    -- AccountNumber - char(9)
    '2022-01-17 01:56:54', -- TransactionDate - smalldatetime
    50000,                  -- Amount - money
    1                   -- DepositorWithdraw - bit
    ),
(   2,                     -- TransactionID - int
    '164647554',                    -- AccountNumber - char(9)
    '2022-01-17 01:57:54', -- TransactionDate - smalldatetime
    50000,                  -- Amount - money
    1                   -- DepositorWithdraw - bit
    )
--4 Write a query to get all customers from Customer table who live in ‘Hanoi’.
SELECT * FROM dbo.Customer 
WHERE City = N'Hà Nội'
--5 Write a query to get account information of the customers (Name, Phone, Email, AccountNumber, Balance)
SELECT Name,Phone,Email,AccountNumber,Balance FROM dbo.Customer
JOIN dbo.CustomerAccount
ON CustomerAccount.CustomerID = Customer.CustomerId
--6 Constraint check : transfers
ALTER TABLE dbo.CustomerTransaction
ADD CONSTRAINT check_transfer CHECK(Amount>0 AND Amount<=1000000)
--7. Create a view named vCustomerTransactions
CREATE VIEW vCustomerTransactions
AS 
SELECT Name,CustomerAccount.AccountNumber,TransactionDate,Amount,DepositorWithdraw FROM dbo.Customer
JOIN dbo.CustomerAccount
ON CustomerAccount.CustomerID = Customer.CustomerId
JOIN dbo.CustomerTransaction
ON CustomerTransaction.AccountNumber = CustomerAccount.AccountNumber
GO

