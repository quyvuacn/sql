SELECT E.BusinessEntityID FROM Person.BusinessEntityContact e WHERE
e.ContactTypeID IN (
SELECT c.ContactTypeID FROM
Person.ContactType c
WHERE YEAR (e.ModifiedDate) >=2012
)