USE Northwind;

WITH cte_mayor50 AS (
    SELECT *
    FROM products as p
    where p.price>50
)
SELECT ProductName, Unit
FROM cte_mayor50;

WITH cte_rentable AS (
    SELECT  P.ProductID,
			P.ProductName,
			sum(o.quantity*p.price) as TotalRevenue
    FROM products as p
		JOIN orderdetails as o
		ON p.ProductID = o.ProductID
    GROUP BY P.ProductID,P.ProductName
ORDER BY TotalRevenue DESC
)
SELECT ProductID,ProductName,TotalRevenue
FROM cte_rentable
ORDER BY TotalRevenue DESC
LIMIT 6;


WITH cte_categoria AS (
   SELECT  c.CategoryName ,
		COUNT(DISTINCT p.ProductID) as ProductCount
    FROM categories as c
		JOIN products as p
		ON c.CategoryID = p.CategoryID
    GROUP BY c.CategoryName 
    ORDER BY ProductCount DESC
)
SELECT CategoryName,ProductCount
FROM cte_categoria
LIMIT 5;



WITH cte_promedio AS (
   SELECT  c.CategoryName ,
		avg(od.quantity) as AvgOrderQuantity
    FROM categories as c
		JOIN products as p
		ON c.CategoryID = p.CategoryID
        JOIN orderdetails as od
		ON p.ProductID = od.ProductID
    GROUP BY c.CategoryName 
    ORDER BY AvgOrderQuantity DESC
)
SELECT CategoryName, AvgORderQuantity
FROM cte_promedio;




WITH cte_promedio_pedido AS (
   SELECT  c.CustomerID,
		   c.CustomerName,
		   avg(od.quantity*p.Price) as AvgOrderAmount
    FROM customers as c
		JOIN orders as o
		ON c.CustomerID = o.CustomerID
        JOIN orderdetails as od
		ON o.OrderID = od.OrderID
        JOIN products as p
		ON p.ProductID = od.ProductID
    GROUP BY c.CustomerID, c.CustomerName
    ORDER BY AvgOrderAmount DESC
)
SELECT CustomerID, CustomerName, AvgOrderAmount
FROM cte_promedio_pedido;


WITH cte_ventas_1997 AS (
   SELECT  	P.ProductName,
			sum(od.quantity) as TotalSales
    FROM products as p
		JOIN orderdetails as od
		ON p.ProductID = od.ProductID
        JOIN orders as o
        ON od.OrderID = o.OrderID
	WHERE YEAR(o.OrderDate)=1997
    GROUP BY p.ProductName
ORDER BY TotalSales DESC
)
SELECT ProductName, TotalSales
FROM cte_ventas_1997;




    



