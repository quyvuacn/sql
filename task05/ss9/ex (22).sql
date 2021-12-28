SELECT LastName, FirstName FROM Person.Person WHERE BusinessEntityID IN (SELECT
BusinessEntityID FROM Sales.SalesPerson WHERE TerritoryID IN
  (SELECT TerritoryID
  FROM Sales.SalesTerritory
         WHEREName='Canada')