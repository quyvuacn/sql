CREATE DATABASE EX02_Lab08
GO
 
USE EX02_Lab08
GO

CREATE TABLE Classes(
	ClassName CHAR(6),
	Teacher NVARCHAR(30),
	TimeSlot VARCHAR(20),
	Class INT,
	Lab INT
)
GO

CREATE UNIQUE CLUSTERED INDEX MyClusteredIndex ON Classes(ClassName)
WITH(FILLFACTOR=70,PAD_INDEX=ON,IGNORE_DUP_KEY=ON)
GO

CREATE NONCLUSTERED INDEX TeacherIndex ON dbo.Classes(Teacher)
GO

DROP INDEX TeacherIndex ON dbo.Classes
GO

CREATE INDEX ClassLabIndex ON dbo.Classes(Class,Lab)
GO

SELECT DB_NAME() AS Database_Name
, sc.name AS Schema_Name
, o.name AS Table_Name
, i.name AS Index_Name
, i.type_desc AS Index_Type
FROM sys.indexes i
INNER JOIN sys.objects o ON i.object_id = o.object_id
INNER JOIN sys.schemas sc ON o.schema_id = sc.schema_id
WHERE i.name IS NOT NULL
AND o.type = 'U'
ORDER BY o.name, i.type