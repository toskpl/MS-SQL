/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	GRUPOWANIE DANYCH
	B: GROUP BY

*/



USE AdventureWorks2017
GO



SELECT * FROM Sales.SalesOrderHeader


SELECT COUNT(*) AS Cnt FROM Sales.SalesOrderHeader


SELECT SUM(SubTotal) AS SubTotalSum FROM Sales.SalesOrderHeader



SELECT 
	COUNT(*) AS Cnt,
	SUM(SubTotal) AS SubTotalSum 
FROM Sales.SalesOrderHeader


-- czas dostawy
SELECT DATEDIFF(DAY, OrderDate, ShipDate), * FROM Sales.SalesOrderHeader

-- najdłuższy czas dostawy
SELECT MAX(DATEDIFF(DAY, OrderDate, ShipDate)) FROM Sales.SalesOrderHeader








-- jakie długie nazwisko
SELECT LEN(LastName), * FROM Person.Person

-- jakie długie imię i nazwisko
SELECT LEN(Firstname + ' ' + LastName), * FROM Person.Person

-- średnia długość imienia i nazwiska
SELECT AVG(LEN(Firstname + ' ' + LastName)) FROM Person.Person



-- można używać więcej niż jednej funkcji agregującej
SELECT COUNT(*), SUM(SubTotal) FROM Sales.SalesOrderHeader


SELECT * FROM Sales.SalesOrderHeader


--! używając funkcji agregującej nie można wyświetlać jakichkolwiek szczegółowych danych  
SELECT COUNT(*), SUM(SubTotal), * FROM Sales.SalesOrderHeader

--!
SELECT COUNT(*), CustomerID FROM Sales.SalesOrderHeader






/*
	GROUP BY
	część zapytania wskazująca wg których kolumn dane mają być pogrupowane, 
	dla których wartości mają wyliczyć funkcje agregujące
*/


-- liczba zamówień dla poszczególnych klientów
-- (grupujemy wg ID klienta i wyliczamy sumę dla grup)
SELECT CustomerID, COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY CustomerID


SELECT SalesOrderID, SUM(OrderQty) AS SUM_OrderQty
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID

SELECT SalesOrderID, AVG(OrderQty) AS AVG_OrderQty
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID

-- mozemy sortowac po wyniku funkcji agregującej
SELECT SalesOrderID, SUM(OrderQty) AS SUM_OrderQty
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY SUM_OrderQty DESC



-- ile szczegółów (pozycji) zamówień?
-- największe zamówienie na początku (ORDER BY)
SELECT SalesOrderID, COUNT(*) AS DetailsCount
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY DetailsCount DESC


SELECT * FROM Sales.SalesOrderHeader

-- kto jest najlepszym klientem? (złożył najwięcej zamówień)
SELECT CustomerID,  COUNT(*) AS NoOfOrders
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY NoOfOrders DESC


-- najnowsze zamówienia- dla poszczególnych klientów
SELECT CustomerID,  MAX(OrderDate) AS MaxOrderDate
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID DESC



-- najdłuższy czas dostawy - dla poszczególnych klientów
SELECT CustomerID,  MAX(DATEDIFF(day, OrderDate, ShipDate))
FROM Sales.SalesOrderHeader
GROUP BY CustomerID



-- najdłuższy czas dostawy oraz suma wartości zamówień - dla poszczególnych klientów
SELECT CustomerID,  
	MAX(DATEDIFF(day, OrderDate, ShipDate)) AS MaxPeriod, 
	SUM(SubTotal) AS SumSubTotal
FROM Sales.SalesOrderHeader
GROUP BY CustomerID


-- grupowanie na podstawie wyrażenia

SELECT YEAR(OrderDate), COUNT(*)
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)


-- grupowanie po dwóch kolumnach
SELECT YEAR(OrderDate), CustomerID, COUNT(*)
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), CustomerID
ORDER BY CustomerID, YEAR(OrderDate)


/* Baza Filmy */

USE Filmy

SELECT * FROM Film

-- liczba filmów przypisanych do poszczególnych języków
SELECT JezykOryginalny, COUNT(*) AS Liczba
FROM Film
GROUP BY JezykOryginalny

SELECT JezykOryginalny, COUNT(*)
FROM Film
GROUP BY JezykOryginalny

SELECT DISTINCT JezykOryginalny
FROM Film



-- liczba premier w poszczególnych latach
SELECT YEAR(Premiera) AS RokPremiery, COUNT(*) AS Liczba
FROM Film
GROUP BY YEAR(Premiera)
ORDER BY RokPremiery



