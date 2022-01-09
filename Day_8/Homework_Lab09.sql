CREATE DATABASE Homework_Lab09
GO
 
USE Homework_Lab09
GO

CREATE TABLE Class(
	ClassCode VARCHAR(10) PRIMARY KEY,
	HeadTeacher VARCHAR(30) NOT NULL,
	Room VARCHAR(30) NOT NULL,
	TimeSlot CHAR(1), --VD: G,I,L hoặc M
	CloseDate DATETIME
)
GO

CREATE TABLE Student(
	RollNo VARCHAR(10) PRIMARY KEY,
	ClassCode VARCHAR(10) FOREIGN KEY REFERENCES dbo.Class(ClassCode),
	FullName VARCHAR(30) NOT NULL,
	Male BIT ,--Trai: 1, Gái : 0
	BirthDate DATE,
	Address VARCHAR(100),
	Provice VARCHAR(50) NOT NULL,
	Email VARCHAR(100)
)
GO

CREATE TABLE Subjects(
	SubjectCode VARCHAR(10) PRIMARY KEY,
	SubjectName VARCHAR(40) NOT NULL,
	WMark BIT,
	PMark BIT,
	WTest_per INT,
	PTest_per INT
)
GO

CREATE TABLE Mark(
	RollNo VARCHAR(10) FOREIGN KEY REFERENCES dbo.Student(RollNo),
	SubjectCode VARCHAR(10) FOREIGN KEY REFERENCES dbo.Subjects(SubjectCode),
	WMark FLOAT NOT NULL,
	PMark FLOAT NOT NULL,
	Mark FLOAT NOT NULL
)

INSERT INTO dbo.Class
(
    ClassCode,
    HeadTeacher,
    Room,
    TimeSlot,
    CloseDate
)
VALUES
(   'T2109M',       -- ClassCode - varchar(10)
    'Đang Kim Thi',       -- HeadTeacher - varchar(30)
    'S20',       -- Room - varchar(30)
    'G',       -- TimeSlot - char(1)
    NULL-- CloseDate - datetime
    ),
(   'T2108M',       -- ClassCode - varchar(10)
    'Nguyen Van A',       -- HeadTeacher - varchar(30)
    'S21',       -- Room - varchar(30)
    'G',       -- TimeSlot - char(1)
    NULL-- CloseDate - datetime
    ),
(   'T2107M',       -- ClassCode - varchar(10)
    'Nguyen Van B',       -- HeadTeacher - varchar(30)
    'S22',       -- Room - varchar(30)
    'G',       -- TimeSlot - char(1)
    NULL-- CloseDate - datetime
    ),
(   'T2106M',       -- ClassCode - varchar(10)
    'Nguyen Van C',       -- HeadTeacher - varchar(30)
    'S23',       -- Room - varchar(30)
    'I',       -- TimeSlot - char(1)
    NULL-- CloseDate - datetime
    ),
(   'T2105M',       -- ClassCode - varchar(10)
    'Nguyen Van D',       -- HeadTeacher - varchar(30)
    'S24',       -- Room - varchar(30)
    'M',       -- TimeSlot - char(1)
    NULL-- CloseDate - datetime
    )

INSERT INTO dbo.Student
(
    RollNo,
    ClassCode,
    FullName,
    Male,
    BirthDate,
    Address,
    Provice,
    Email
)
VALUES
(   'TH2109016',        -- RollNo - varchar(10)
    'T2109M',        -- ClassCode - varchar(10)
    'Vu Viet Quy',        -- FullName - varchar(30)
    1,      -- Male - bit
    '20030109', -- BirthDate - date
    'Thai Thuy,Thai Binh',        -- Address - varchar(100)
    'Thai Binh',        -- Provice - varchar(50)
    'vuietquyacn@gmail.com'         -- Email - varchar(100)
    ),
(   'TH2109017',        -- RollNo - varchar(10)
    'T2109M',        -- ClassCode - varchar(10)
    'Ta Duy Linh',        -- FullName - varchar(30)
    1,      -- Male - bit
    '20030109', -- BirthDate - date
    'Thai Nguyen',        -- Address - varchar(100)
    'Thai Nguyen',        -- Provice - varchar(50)
    'abc123@gmail.com'         -- Email - varchar(100)
    ),
(   'TH2109018',        -- RollNo - varchar(10)
    'T2109M',        -- ClassCode - varchar(10)
    'Vu Viet Quy',        -- FullName - varchar(30)
    1,      -- Male - bit
    '20030109', -- BirthDate - date
    'Thai Thuy,Thai Binh',        -- Address - varchar(100)
    'Thai Binh',        -- Provice - varchar(50)
    'vuietquyacn@gmail.com'         -- Email - varchar(100)
    ),
(   'TH2109019',        -- RollNo - varchar(10)
    'T2109M',        -- ClassCode - varchar(10)
    'Dinh Quang Anh',        -- FullName - varchar(30)
    1,      -- Male - bit
    '20030109', -- BirthDate - date
    'Thai Thuy,Thai Binh',        -- Address - varchar(100)
    'Thai Binh',        -- Provice - varchar(50)
    'vuietquyacn@gmail.com'         -- Email - varchar(100)
    ),
(   'TH2109020',        -- RollNo - varchar(10)
    'T2109M',        -- ClassCode - varchar(10)
    'Nguyen Do Ngoc Diep',        -- FullName - varchar(30)
    0,      -- Male - bit
    '20030109', -- BirthDate - date
    'Thai Thuy,Thai Binh',        -- Address - varchar(100)
    'Thai Binh',        -- Provice - varchar(50)
    'vuietquyacn@gmail.com'         -- Email - varchar(100)
    ),
(   'TH2109021',        -- RollNo - varchar(10)
    'T2109M',        -- ClassCode - varchar(10)
    'Nguyen Ha Anh',        -- FullName - varchar(30)
    0,      -- Male - bit
    '20030109', -- BirthDate - date
    'Thai Thuy,Thai Binh',        -- Address - varchar(100)
    'Thai Binh',        -- Provice - varchar(50)
    'vuietquyacn@gmail.com'         -- Email - varchar(100)
    )

INSERT INTO dbo.Subjects
(
    SubjectCode,
    SubjectName,
    WMark,
    PMark,
    WTest_per,
    PTest_per
)
VALUES
(   'C',   -- SubjectCode - varchar(10)
    'C',   -- SubjectName - varchar(40)
    1, -- WMark - bit
    1, -- PMark - bit
    20,    -- WTest_per - int
    15    -- PTest_per - int
    ),
(   'HTML',   -- SubjectCode - varchar(10)
    'HTML',   -- SubjectName - varchar(40)
    1, -- WMark - bit
    1, -- PMark - bit
    20,    -- WTest_per - int
    15    -- PTest_per - int
    ),
(   'JS',   -- SubjectCode - varchar(10)
    'Javascript',   -- SubjectName - varchar(40)
    1, -- WMark - bit
    1, -- PMark - bit
    20,    -- WTest_per - int
    15    -- PTest_per - int
    ),
(   'SQL',   -- SubjectCode - varchar(10)
    'SQL',   -- SubjectName - varchar(40)
    1, -- WMark - bit
    1, -- PMark - bit
    20,    -- WTest_per - int
    15    -- PTest_per - int
    )

INSERT INTO dbo.Mark
(
    RollNo,
    SubjectCode,
    WMark,
    PMark,
    Mark
)
VALUES
(   'TH2109016',  -- RollNo - varchar(10)
    'C',  -- SubjectCode - varchar(10)
    12.0, -- WMark - float
   13.0, -- PMark - float
    12.5  -- Mark - float
    ),
(   'TH2109016',  -- RollNo - varchar(10)
    'HTML',  -- SubjectCode - varchar(10)
    15.0, -- WMark - float
   13.0, -- PMark - float
    14.0  -- Mark - float
    ),
(   'TH2109016',  -- RollNo - varchar(10)
    'JS',  -- SubjectCode - varchar(10)
    15.0, -- WMark - float
   13.0, -- PMark - float
    14.0 -- Mark - float
    ),
(   'TH2109017',  -- RollNo - varchar(10)
    'C',  -- SubjectCode - varchar(10)
    12.0, -- WMark - float
   13.0, -- PMark - float
    12.5  -- Mark - float
    ),
(   'TH2109017',  -- RollNo - varchar(10)
    'HTML',  -- SubjectCode - varchar(10)
    15.0, -- WMark - float
   13.0, -- PMark - float
    14.0  -- Mark - float
    ),
(   'TH2109017',  -- RollNo - varchar(10)
    'JS',  -- SubjectCode - varchar(10)
    15.0, -- WMark - float
   13.0, -- PMark - float
    14.0 -- Mark - float
    )
--2.Tạo một khung nhìn chứa danh sách các sinh viên đã có ít nhất 2 bài thi (2 môn học khác nhau).
CREATE VIEW Test_02
AS
SELECT FullName FROM dbo.Student
JOIN dbo.Mark
ON Mark.RollNo = Student.RollNo
GROUP BY FullName
HAVING COUNT(DISTINCT SubjectCode) >=2
GO
--3: Tạo khung nhìn sinh viên trượt ít nhất 1 môn
CREATE  VIEW Truot
AS 
SELECT DISTINCT Mark.RollNo,FullName FROM dbo.Mark
JOIN dbo.Student
ON Student.RollNo = Mark.RollNo
WHERE WMark < 8 OR PMark < 6

--4. Tạo một khung nhìn chứa danh sách các sinh viên đang học ở TimeSlot G.
CREATE VIEW Test_04
AS
SELECT RollNo,FullName FROM dbo.Student
WHERE ClassCode IN (
	SELECT ClassCode FROM dbo.Class
	WHERE TimeSlot = 'G'
)
GO





