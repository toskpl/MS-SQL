/*
	KursySQL.pl

	ŁĄCZENIE TABEL
	D: CROSS JOIN

*/

USE AdventureWorks2017
GO



SELECT t.Name, *
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesTerritory AS t ON t.TerritoryID = soh.TerritoryID
WHERE CustomerID = 29994


-- 10
SELECT * FROM Sales.SalesTerritory

-- 12
SELECT * FROM Sales.SalesOrderHeader WHERE CustomerID = 29994

-- 10*12 = 120
SELECT DISTINCT t.Name, *
FROM Sales.SalesOrderHeader AS soh
CROSS JOIN Sales.SalesTerritory AS t
WHERE CustomerID = 29994



/* "stara" składania łącząca tabele */

SELECT t.Name, *
FROM Sales.SalesOrderHeader AS soh, Sales.SalesTerritory AS t 
WHERE t.TerritoryID = soh.TerritoryID

-- przypadkowy iloczyn kartezjański
SELECT t.Name, *
FROM Sales.SalesOrderHeader AS soh, Sales.SalesTerritory AS t 
--WHERE t.TerritoryID = soh.TerritoryID


-- 1 018
SELECT DISTINCT FirstName FROM Person.Person

-- 1 206
SELECT DISTINCT LastName FROM Person.Person


-- 1 227 708
SELECT * FROM 
	(SELECT DISTINCT FirstName FROM Person.Person) AS fname
CROSS JOIN 
	(SELECT DISTINCT LastName FROM Person.Person) AS lname

