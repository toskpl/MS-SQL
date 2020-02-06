/*
	KursySQL.pl

	ŁĄCZENIE TABEL
	C: OUTER JOIN - złączenia zewnętrzne

*/

-- 31 465
SELECT
	c.CustomerID,
	soh.SalesOrderID,
	soh.OrderDate,
	soh.SubTotal
FROM Sales.Customer AS c
INNER JOIN Sales.SalesOrderHeader AS soh
	ON soh.CustomerID = c.CustomerID

-- 31 465
SELECT c.CustomerID
FROM Sales.Customer AS c
INNER JOIN Sales.SalesOrderHeader AS soh
	ON soh.CustomerID = c.CustomerID

-- 19 119
SELECT DISTINCT c.CustomerID
FROM Sales.Customer AS c
INNER JOIN Sales.SalesOrderHeader AS soh
	ON soh.CustomerID = c.CustomerID

-- 19 820
SELECT count(*)
FROM Sales.Customer

-- cała "lewa" tabela (Sales.Customer)
-- 
SELECT
	c.CustomerID,
	soh.SalesOrderID
FROM Sales.Customer AS c
LEFT OUTER JOIN Sales.SalesOrderHeader AS soh
	ON soh.CustomerID = c.CustomerID

-- 12 820
SELECT DISTINCT c.CustomerID
FROM Sales.Customer AS c
LEFT OUTER JOIN Sales.SalesOrderHeader AS soh
	ON soh.CustomerID = c.CustomerID



-- tylko klienci bez zamówień
SELECT
	c.CustomerID,
	soh.SalesOrderID
FROM Sales.Customer AS c
LEFT OUTER JOIN Sales.SalesOrderHeader AS soh
	ON soh.CustomerID = c.CustomerID
WHERE soh.SalesOrderID IS NULL

-- tylko zamówienia bez klientów
SELECT
	c.CustomerID,
	soh.SalesOrderID
FROM Sales.Customer AS c
RIGHT OUTER JOIN Sales.SalesOrderHeader AS soh
	ON soh.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL



SELECT * FROM Sales.SalesOrderHeader

-- wstawienie zamówienia bez przypisanego klienta
INSERT INTO Sales.SalesOrderHeader (RevisionNumber, OrderDate, DueDate,	ShipDate, Status, OnlineOrderFlag,
	CustomerID, BillToAddressID, ShipToAddressID, ShipMethodID,
	SubTotal, TaxAmt, Freight, rowguid, ModifiedDate)
SELECT TOP 1 RevisionNumber, OrderDate, DueDate,	ShipDate, Status, OnlineOrderFlag,
	NULL, BillToAddressID, ShipToAddressID, ShipMethodID,
	SubTotal, TaxAmt, Freight, NEWID(), ModifiedDate
FROM Sales.SalesOrderHeader

ALTER TABLE Sales.SalesOrderHeader ALTER COLUMN CustomerID int NULL

SELECT TOP 5 CustomerID, * FROM Sales.SalesOrderHeader ORDER BY SalesOrderID DESC

--DELETE FROM Sales.SalesOrderHeader WHERE SalesOrderID = 75127


-- tylko zamówienia bez klientów
SELECT
	c.CustomerID,
	soh.SalesOrderID
FROM Sales.Customer AS c
RIGHT OUTER JOIN Sales.SalesOrderHeader AS soh
	ON soh.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL


-- 32 167
SELECT
	c.CustomerID,
	soh.SalesOrderID
FROM Sales.Customer AS c
FULL JOIN Sales.SalesOrderHeader AS soh
	ON soh.CustomerID = c.CustomerID


-- cofanie zmian
SELECT * FROM Sales.SalesOrderHeader WHERE CustomerID IS NULL

DELETE FROM Sales.SalesOrderHeader WHERE CustomerID IS NULL

DROP INDEX IX_SalesOrderHeader_CustomerID ON Sales.SalesOrderHeader

ALTER TABLE Sales.SalesOrderHeader ALTER COLUMN CustomerID int NOT NULL

CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_CustomerID
ON Sales.SalesOrderHeader(CustomerID)

GO

SELECT * FROM Sales.SalesOrderHeader WHERE CustomerID IS NULL




/* Filmy */

USE Filmy
GO

-- filmy po polsku z przypisanym krajem
SELECT 
	k.Kraj,
	f.TytulOryginalny
FROM Film AS f
JOIN FilmKraj AS fk ON fk.FilmID = f.FilmID
JOIN Kraj AS k ON k.KrajID = fk.KrajID
WHERE JezykOryginalny = 'pl'
ORDER BY TytulOryginalny


-- ...uwzględniając filmy bez przypisanego kraju
SELECT 
	k.Kraj,
	f.TytulOryginalny
FROM Film AS f
LEFT JOIN FilmKraj AS fk ON fk.FilmID = f.FilmID
LEFT JOIN Kraj AS k ON k.KrajID = fk.KrajID
WHERE JezykOryginalny = 'pl'
ORDER BY TytulOryginalny


-- ...tylko filmy bez przypisanego kraju
SELECT 
	k.Kraj,
	f.TytulOryginalny
FROM Film AS f
LEFT JOIN FilmKraj AS fk ON fk.FilmID = f.FilmID
LEFT JOIN Kraj AS k ON k.KrajID = fk.KrajID
WHERE JezykOryginalny = 'pl' AND fk.KrajID IS NULL
ORDER BY TytulOryginalny



