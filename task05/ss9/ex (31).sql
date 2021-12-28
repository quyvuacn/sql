WITH CTE_Students
AS (
StudentCode, S.Name,C.CityName, St.Status FROM Student S
INNER JOIN City C
         ON S.CityCode C.CityCode INNER 
JOIN Status St
ON S.StatusId = St.StatusId)
, 
StatusRecord This is the second CTE being defined --
AS (
SELECT Status, COUNT(Name) AS CountofStudents FROM
CTE_Students
GROUP BY Status
)
SELECT * FROM StatusRecord