SELECT
    pl. ProductID,
     pl.Color,
    p1.Name,
    p2.Name
	FROM
    Production.Product pl
INNER JOIN Production.Product p2 ON pl.Color = p2.Color
ORDER BY pl.ProductID 