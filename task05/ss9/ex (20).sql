SELECT FirstName, LastName FROM Person. Person
WHERE Person.Person.BusinessEntityID IN (SELECT BusinessEntityID
FROM HumanResources.Employee WHERE JobTitle='Researchand Development Manager');