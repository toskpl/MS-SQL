/*
	KursySQL.pl

	ŁĄCZENIE TABEL
	B: INNER JOIN - złączenia wewnętrzne

*/


USE AdventureWorks2017
GO


-- Łączenie tabel za pomocą złączenia wewnętrzengo (INNER JOIN)
----------------------------------------

-- bez aliasów, wyświetlając wszystkie kolumny z 1-szej i 2-giej tabeli
SELECT *
FROM Sales.SalesOrderHeader
JOIN Sales.SalesOrderDetail
ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
ORDER BY Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderDetail.SalesOrderDetailID


--!
SELECT SalesOrderID, 
	OrderDate,  
	SalesOrderDetailID, 
	OrderQty,
	ProductID
FROM Sales.SalesOrderHeader 
JOIN Sales.SalesOrderDetail 
ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
ORDER BY Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderDetail.SalesOrderDetailID




-- dodanie aliasów dla lepszej czytelności
SELECT *
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod
ON soh.SalesOrderID = sod.SalesOrderID
ORDER BY soh.SalesOrderID, sod.SalesOrderDetailID



-- 2 kolumny z 1-szej tabeli i 4 z 2-giej
SELECT soh.SalesOrderID, 
	OrderDate, 
	sod.SalesOrderID, 
	SalesOrderDetailID, 
	OrderQty,
	ProductID
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod
ON soh.SalesOrderID = sod.SalesOrderID
ORDER BY sod.SalesOrderID, sod.SalesOrderDetailID



--> dzięki Intellisense wpisywanie zapytań z JOIN jest szybkie




-- łączenie 3 tabel
SELECT 
	soh.SalesOrderID, 
	soh.OrderDate,
	CONVERT(varchar(10), soh.OrderDate, 111) AS OrderDate, 
	sod.SalesOrderDetailID, 
	sod.OrderQty,
	sod.ProductID,
	pp.Name
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod
  ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product AS pp
  ON pp.ProductID = sod.ProductID
ORDER BY sod.SalesOrderID, sod.SalesOrderDetailID



SELECT 
	e.BusinessEntityID,
	e.JobTitle,
	p.FirstName,
	p.LastName,
	e.BirthDate,
	e.MaritalStatus
FROM HumanResources.Employee AS e
JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID



-- kolumna nie zawsze musi nazywać się tak samo w obu tabelach

SELECT * 
FROM Sales.Customer AS c
JOIN Person.Person AS p ON p.BusinessEntityID = c.PersonID




USE AdventureWorks2017

/* Łączenie tabel i grupowanie danych */

-- ile zamówień złożyli poszczególni klienci - wyświetlając imię i nazwisko
SELECT p.FirstName, p.LastName, count(*)
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod ON sod.SalesOrderID = soh.SalesOrderID
JOIN Sales.Customer AS c ON c.CustomerID = soh.CustomerID
JOIN Person.Person AS p ON p.BusinessEntityID = c.PersonID
GROUP BY p.FirstName, p.LastName


-- ile zamówień dostarczono za pomocą poszczególnych sposobów dostaw
SELECT sm.Name, count(*)
FROM Sales.SalesOrderHeader AS soh
JOIN Purchasing.ShipMethod AS sm ON sm.ShipMethodID = soh.ShipMethodID
GROUP BY sm.Name



-- sprzedaż w poszczególnych krajach (diagram)
SELECT cr.Name, count(*) 
FROM Sales.SalesOrderHeader AS soh
JOIN Person.Address AS a ON a.AddressID = soh.ShipToAddressID
JOIN Person.StateProvince AS sp ON sp.StateProvinceID = a.StateProvinceID
JOIN Person.CountryRegion AS cr ON cr.CountryRegionCode = sp.CountryRegionCode
GROUP BY cr.Name

-- sprzedaż w poszczególnych krajach w roku 2011 - dodatkowo filtrowanie
SELECT YEAR(soh.OrderDate), cr.Name, count(*) 
FROM Sales.SalesOrderHeader AS soh
JOIN Person.Address AS a ON a.AddressID = soh.ShipToAddressID
JOIN Person.StateProvince AS sp ON sp.StateProvinceID = a.StateProvinceID
JOIN Person.CountryRegion AS cr ON cr.CountryRegionCode = sp.CountryRegionCode
WHERE YEAR(soh.OrderDate) = 2011
GROUP BY YEAR(soh.OrderDate), cr.Name





/* Baza Filmy */

USE Filmy

-- tytuły filmów i nazwy gatunków (diagram - many-to-many)
SELECT f.FilmID, f.Tytul, g.Gatunek
FROM Film AS f
JOIN FilmGatunek AS fg ON fg.FilmID = f.FilmID
JOIN Gatunek AS g ON g.GatunekID = fg.GatunekID


-- liczba filmów poszczególnych gatunków
SELECT fg.GatunekID, g.Gatunek, count(*)
FROM Film AS f
JOIN FilmGatunek AS fg ON fg.FilmID = f.FilmID
JOIN Gatunek AS g ON g.GatunekID = fg.GatunekID
GROUP BY fg.GatunekID, g.Gatunek
ORDER BY g.Gatunek

-- Ilu aktorów gra w poszczególnych filmach 
SELECT f.FilmID, f.Tytul, count(*)
FROM Film AS f
JOIN FilmAktor AS fa ON fa.FilmID = f.FilmID
GROUP BY f.FilmID, f.Tytul


-- Ilu aktorów gra w poszczególnych POLSKICH filmach 
SELECT f.JezykOryginalny, f.FilmID, f.TytulOryginalny, count(*)
FROM Film AS f
JOIN FilmAktor AS fa ON fa.FilmID = f.FilmID
--JOIN FilmKraj as FK on FK.FilmID = F.FilmID
--JOIN Kraj AS k ON k.KrajID = fk.KrajID 
WHERE f.JezykOryginalny='pl'
GROUP BY f.JezykOryginalny, f.FilmID, f.TytulOryginalny





