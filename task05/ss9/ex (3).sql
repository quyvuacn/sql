SELECT SalesYear, TotalSales FROM
(
    SELECT * FROM
	(
        SELECT YEAR (SOH.OrderDate) AS SalesYear,
               SOH. SubTotal AS TotalSales
        FROM sales.SalesOrderHeader SOH
             JOIN sales.SalesOrderDetail SOD ON SOH.SalesOrderId = SOD.SalesOrderId
     ) AS Sales PIVOT (SUM(TotalSales) FOR SalesYear IN([2011],
                                                         [2012],
                                                         [2013],
                                                         [2014])) AS PVT
) T UNPIVOT (TotalSales FOR SalesYear IN([2011],
                                          [2012],
                                          [2013],
                                          [2014])) AS upvt;