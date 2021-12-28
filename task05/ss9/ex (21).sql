SELECT FirstName, LastName FROM Person.Person ASA WHERE EXISTS (SELECT *
FROM HumanResources.Employee As B WHERE JobTitle='Research and Development Manager'
AND A.BusinessEntityID=B.BusinessEntityID);