SELECT A.FirstName, A.LastName, B.JobTitle
FROM Person.Person A
INNER JOIN HumanResources.Employee B
         ON
A.BusinessEntityID= B.BusinessEntityID;