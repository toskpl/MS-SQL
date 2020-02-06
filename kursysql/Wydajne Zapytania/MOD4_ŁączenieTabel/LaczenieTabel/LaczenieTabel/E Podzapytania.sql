/*
	KursySQL.pl

	ŁĄCZENIE TABEL
	E: Podzapytania

*/


/* Podzapytania NIESKORELOWANE */

-- klienci, którzy złożyli choć jedno zamówienie
SELECT
	 CustomerID, AccountNumber
FROM Sales.Customer
WHERE CustomerID IN
	(SELECT DISTINCT CustomerID FROM Sales.SalesOrderHeader)


-- inny operator, ostatnio kupiony produkt
SELECT * 
FROM Production.Product
WHERE ProductID = 
(SELECT TOP 1 ProductID FROM Sales.SalesOrderDetail 
ORDER BY SalesOrderDetailID DESC)


-- podzapytanie w FROM
SELECT *
FROM (SELECT FirstName, LastName, PersonType FROM Person.Person) AS p
WHERE p.PersonType = 'VC'




/* Podzapytania SKORELOWANE */


-- podzapytanie w SELECT
SELECT p.FirstName, p.LastName,
	(
		SELECT COUNT(*)
		FROM Sales.Customer AS c 
		JOIN Sales.SalesOrderHeader AS soh ON soh.CustomerID = c.CustomerID
		WHERE c.PersonID = p.BusinessEntityID
	)
FROM Person.Person AS p


-- kupowane produkty
SELECT * 
FROM Production.Product AS pp
WHERE EXISTS (SELECT * FROM Sales.SalesOrderDetail 
	WHERE ProductID = pp.ProductID)

-- to samo co powyzej
SELECT DISTINCT pp.*
FROM Production.Product AS pp
JOIN Sales.SalesOrderDetail AS sod ON sod.ProductID = pp.ProductID



-- NIE-kupowane produkty
SELECT * 
FROM Production.Product AS pp
WHERE NOT EXISTS (SELECT * FROM Sales.SalesOrderDetail WHERE ProductID = pp.ProductID)

-- to samo co powyzej
SELECT DISTINCT pp.*
FROM Production.Product AS pp
LEFT JOIN Sales.SalesOrderDetail AS sod ON sod.ProductID = pp.ProductID
WHERE sod.ProductID IS NULL





