SELECT Geography::UnionAggregate(SpatialLocation) AS AVGLocation
FROM Person.Address
WHERE City= 'London';