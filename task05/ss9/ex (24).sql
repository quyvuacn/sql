SELECT A.FirstName, A.LastName, B.JobTitle
FROM Person.Person A
JOIN
HumanResources.Employee B ON
A.BusinessEntityID= B.BusinessEntityID;