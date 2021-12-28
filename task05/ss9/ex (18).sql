DECLARE @CollectionDemo TABLE (
shape geometry, shapeType nvarchar(50)
)
INSERT INTO @CollectionDemo (shape,shapeType) VALUES ('CURVEPOLYGON (
CIRCULARSTRING(2 3, 4 1, 6 3, 4 5, 2 3))', 'Circle'),
('POLYGON ( (1 1, 1, 4 5, 1 5, 1 1))', 'Rectangle');
SELECT geometry::CollectionAggregate (shape) FROM @CollectionDemo;