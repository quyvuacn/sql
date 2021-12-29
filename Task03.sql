CREATE DATABASE Task03
GO

USE Task03
GO

CREATE TABLE Class(
 ClassId INT IDENTITY PRIMARY KEY,
 ClassName VARCHAR(100) NOT NULL
)
GO

CREATE TABLE Student(
	ID INT IDENTITY PRIMARY KEY,
	StudenID NVARCHAR(50) UNIQUE,
	StudentName NVARCHAR(300) NOT NULL,
	Class_CurrentID INT FOREIGN KEY REFERENCES dbo.Class(ClassId)
)
GO

CREATE TABLE Inf_Class(
	StudentID INT FOREIGN KEY REFERENCES Student(ID),
	ClassId INT FOREIGN KEY REFERENCES Class(ClassId),	
	Status INT NOT NULL, --1: Lớp học chính,2: Đang theo học,3: Đã hoàn thành,4: Bảo lưu kết quả
	Admission DATE NOT NULL, --Ngày nhập học
	Finish DATE DEFAULT(NULL)
)
GO

CREATE TABLE Subjects(
	SubjectID INT IDENTITY PRIMARY KEY,
	SubjectName NVARCHAR(500) NOT NULL
)
GO

CREATE TABLE Inf_Subjects(
	StudentID INT FOREIGN KEY REFERENCES Student(ID),
	SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID),
	Admission DATE NOT NULL, --Ngày bắt đầu học phần
	Finish DATE DEFAULT(NULL), --Ngày hoàn thành
	Status INT NOT NULL, -- 1: Đang học,0 : Trượt,2 : Đang Học lại, 11 : Hoàn thành
)

INSERT INTO dbo.Class
(
    ClassName
)
VALUES
('T2109M' -- ClassName - varchar(100)
    ),
('T2108M' -- ClassName - varchar(100)
    ),
('A3.T2109M' -- ClassName - varchar(100)
    ),
('T2007M' -- ClassName - varchar(100)
    )


INSERT INTO dbo.Student
(
    StudenID,
    StudentName,
    Class_CurrentID
)
VALUES
(   N'TH2109016', -- StudenID - nvarchar(50)
    N'Vũ Viết Quý', -- StudentName - nvarchar(300)
    1    -- Class_CurrentID - int
    ),
(   N'TH2109017', -- StudenID - nvarchar(50)
    N'Đinh Quang Anh', -- StudentName - nvarchar(300)
    1    -- Class_CurrentID - int
    ),
(   N'TH2109018', -- StudenID - nvarchar(50)
    N'Tạ Duy Linh', -- StudentName - nvarchar(300)
    1    -- Class_CurrentID - int
    ),
(   N'TH2109019', -- StudenID - nvarchar(50)
    N'Nguyễn Quốc Anh', -- StudentName - nvarchar(300)
    1    -- Class_CurrentID - int
    ),
(   N'TH2109020', -- StudenID - nvarchar(50)
    N'Nguyễn Đắc Dũng', -- StudentName - nvarchar(300)
    1    -- Class_CurrentID - int
    )

INSERT INTO dbo.Inf_Class
(
    StudentID,
    ClassId,
    Status,
    Admission,
    Finish
)
VALUES
(	1,         -- StudentID - int
    1,         -- ClassId - int
    1,       -- Status - nvarchar(500)
    '20210920', -- Admission - date
    NULL  -- Finish - date
    ),
(	1,         -- StudentID - int
    1,         -- ClassId - int
    1,       -- Status - nvarchar(500)
    '20210920', -- Admission - date
    NULL  -- Finish - date
    ),
(	2,         -- StudentID - int
    1,         -- ClassId - int
    1,       -- Status - nvarchar(500)
    '20210920', -- Admission - date
    NULL  -- Finish - date
    ),
(	3,         -- StudentID - int
    1,         -- ClassId - int
    1,       -- Status - nvarchar(500)
    '20210920', -- Admission - date
    NULL  -- Finish - date
    ),
(	5,         -- StudentID - int
    1,         -- ClassId - int
    1,       -- Status - nvarchar(500)
    '20210920', -- Admission - date
    NULL  -- Finish - date
    )

INSERT INTO dbo.Subjects
(
    SubjectName
)
VALUES
(N'C/C++' -- SubjectName - nvarchar(500)
    ),
(N'HTML' -- SubjectName - nvarchar(500)
    ),
(N'Javascript' -- SubjectName - nvarchar(500)
    ),
(N'SQL' -- SubjectName - nvarchar(500)
    )

INSERT INTO dbo.Inf_Subjects
(
    StudentID,
    SubjectID,
    Admission,
    Finish,
    Status
)
VALUES
(   1,         -- StudentID - int
    1,         -- SubjectID - int
   '20210922', -- Admission - date
    '20211012', -- Finish - date
    11        -- Status - nvarchar(500)
    ),
(   1,         -- StudentID - int
    2,         -- SubjectID - int
   '20210922', -- Admission - date
    '20211012', -- Finish - date
    11        -- Status - nvarchar(500)
    ),
(   1,         -- StudentID - int
    3,         -- SubjectID - int
   '20210922', -- Admission - date
    '20211012', -- Finish - date
    11        -- Status - nvarchar(500)
    ),
(   1,         -- StudentID - int
    4,         -- SubjectID - int
   '20210922', -- Admission - date
    NULL, -- Finish - date
    1        -- Status - nvarchar(500)
    ),
(   2,         -- StudentID - int
    1,         -- SubjectID - int
   '20210922', -- Admission - date
    '20211012', -- Finish - date
    11        -- Status - nvarchar(500)
    ),
(   2,         -- StudentID - int
    2,         -- SubjectID - int
   '20210922', -- Admission - date
    '20211012', -- Finish - date
    11        -- Status - nvarchar(500)
    ),
(   2,         -- StudentID - int
    3,         -- SubjectID - int
   '20210922', -- Admission - date
    '20211012', -- Finish - date
    11        -- Status - nvarchar(500)
    ),
(   2,         -- StudentID - int
    4,         -- SubjectID - int
   '20210922', -- Admission - date
    NULL, -- Finish - date
    1        -- Status - nvarchar(500)
    )


--Truy vấn
	--Truy vấn Môn học
SELECT Student.StudentName,Subjects.SubjectName,Inf_Subjects.Status
FROM dbo.Inf_Subjects
JOIN dbo.Student
ON Student.ID = Inf_Subjects.StudentID
JOIN Subjects
ON Subjects.SubjectID = Inf_Subjects.SubjectID
WHERE Subjects.SubjectName LIKE 'HTML%'
	--Truy vấn lớp học
SELECT Student.StudentName,Class.ClassName
FROM dbo.Student
JOIN dbo.Class 
ON Class.ClassId = Student.Class_CurrentID
WHERE Class.ClassName LIKE 'T%'


	



