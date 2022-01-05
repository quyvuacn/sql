CREATE DATABASE Homework_Lab08
GO

USE Homework_Lab08
GO

CREATE TABLE Student(
	StudentNo INT PRIMARY KEY,
	StudentName NVARCHAR(100) NOT NULL,
	StudentAddress NVARCHAR(200),
	PhoneNo INT
)
GO
 
CREATE TABLE Department(
	DeptNo INT PRIMARY KEY,
	DeptName NVARCHAR(100) NOT NULL,
	ManagerName CHAR(30) NOT NULL
)
GO

CREATE TABLE Assignment(
	AssignmentNo INT PRIMARY KEY,
	Description NVARCHAR(100)
)
GO

CREATE TABLE Works_Assign(
	JobId INT PRIMARY KEY,
	StudentNo INT FOREIGN KEY REFERENCES dbo.Student(StudentNo),
	AssignmentNo INT FOREIGN KEY REFERENCES dbo.Assignment(AssignmentNo),
	TotalHours INT,
	JobDetails XML
)
GO

CREATE NONCLUSTERED INDEX IX_Student ON dbo.Student(StudentNo) 
GO


CREATE NONCLUSTERED INDEX IX_Dept ON dbo.Department(DeptNo,DeptName,ManagerName)
GO




