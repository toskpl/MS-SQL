/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	GRUPOWANIE DANYCH
	C: HAVING

*/


USE AdventureWorks2017
GO


SELECT * FROM Sales.SalesOrderHeader

-- zapytanie grupujące
SELECT YEAR(OrderDate), CustomerID, COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), CustomerID


-- można filtrować po wartościach wszystkich kolumn w tabeli
-- bądź na podstawie wyników wyrażeń
SELECT YEAR(OrderDate), CustomerID, COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
WHERE CustomerID = 16452
GROUP BY YEAR(OrderDate), CustomerID

SELECT YEAR(OrderDate), CustomerID, COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2012
GROUP BY YEAR(OrderDate), CustomerID

-- .. również jeśli wybrana kolumna nie jest wyświetlana
SELECT YEAR(OrderDate), CustomerID, COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
WHERE TerritoryID = 9
GROUP BY YEAR(OrderDate), CustomerID



--! nie można filtrować w WHERE na podstawie wyniku funkcji agregującej
SELECT YEAR(OrderDate), CustomerID, COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
WHERE COUNT(*) >= 5
GROUP BY YEAR(OrderDate), CustomerID



/* 
	HAVING 
	opcjonalna klauzula, która pozwala filtrować wynik 
	operując na wyliczonych, zgrupowanych danych
	(WHERE jest stosowany zanim odbywa się grupowanie)
*/

-- zamówienia dla klientów którzy złożyli min 5 zamówień
SELECT CustomerID, COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
-- WHERE COUNT(*) >= 5 << źle
GROUP BY CustomerID
HAVING COUNT(*) >= 5


-- zamówienia, które składają się z min 10 pozycji
SELECT SalesOrderID, COUNT(*) AS Cnt
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(*) > 9




/* Baza Filmy */

USE Filmy

-- liczba filmów przypisanych do poszczególnych języków
-- tylko te języki do których jest przypisanych ponad 1000 filmów
SELECT JezykOryginalny, COUNT(*) AS Liczba
FROM Film
GROUP BY JezykOryginalny
HAVING COUNT(*)>1000


-- liczba premier w poszczególnych latach, 
-- ograniczona do tych lat w których było ponad 800 premier
SELECT YEAR(Premiera) AS RokPremiery, COUNT(*) AS Liczba
FROM Film
GROUP BY YEAR(Premiera)
HAVING COUNT(*)>800
ORDER BY RokPremiery













