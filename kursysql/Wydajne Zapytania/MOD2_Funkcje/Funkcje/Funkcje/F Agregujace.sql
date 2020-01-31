/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	FUNKCJE
	F: Agregujące

*/

USE AdventureWorks2017
GO

SELECT SubTotal, * 
FROM Sales.SalesOrderHeader 
WHERE CustomerID = 29734 AND YEAR(OrderDate) = 2012

SELECT COUNT(*) 
FROM Sales.SalesOrderHeader  
WHERE CustomerID = 29734 AND YEAR(OrderDate) = 2012

SELECT COUNT(1) 
FROM Sales.SalesOrderHeader  
WHERE CustomerID = 29734 AND YEAR(OrderDate) = 2012

SELECT COUNT(RevisionNumber) 
FROM Sales.SalesOrderHeader  
WHERE CustomerID = 29734 AND YEAR(OrderDate) = 2012

SELECT COUNT(Comment) 
FROM Sales.SalesOrderHeader  
WHERE CustomerID = 29734 AND YEAR(OrderDate) = 2012



SELECT COUNT(ALL RevisionNumber) 
FROM Sales.SalesOrderHeader  
WHERE CustomerID = 29734 AND YEAR(OrderDate) = 2012

SELECT COUNT(DISTINCT RevisionNumber) 
FROM Sales.SalesOrderHeader  
WHERE CustomerID = 29734 AND YEAR(OrderDate) = 2012





-- największa wartość w kolumnie ContactID, tj. największy identyfikator klienta
SELECT MAX(BusinessEntityID) AS MaxContactID 
FROM Person.Person

-- najmniejsza wartość w kolumnie ModifiedDate- najwczesniej zmofyfikowany wiersz...
SELECT MIN(ModifiedDate) AS MinModDate 
FROM Person.Person

-- suma godzin urlopowych dla wszystkich pracownikow
SELECT SUM(VacationHours) 
FROM HumanResources.Employee


SELECT * FROM Sales.SalesOrderHeader



-- najdłuższy czas dostawy (sortuj)
SELECT DATEDIFF(day, OrderDate, ShipDate) AS NoOfDays
FROM Sales.SalesOrderHeader
ORDER BY NoOfDays DESC



-- pokaz najwieksza wartość ()
SELECT MAX(DATEDIFF(day, OrderDate, ShipDate))
FROM Sales.SalesOrderHeader

SELECT TOP 1 DATEDIFF(day, OrderDate, ShipDate) AS NoOfDays
FROM Sales.SalesOrderHeader
ORDER BY NoOfDays DESC



/* NULL */
-- Większość funkcji agregujących ignoruje wartości NULL


SELECT MaxQty, * FROM Sales.SpecialOffer


SELECT * FROM Sales.SpecialOffer WHERE MaxQty IS NULL

-- uwaga na operacje na kolumnach, ktore zawierając null!

-- ile wierszy znajduje się w tabeli Sales.SpecialOffer?
SELECT COUNT(*) FROM Sales.SpecialOffer -- 16


-- jaka jest suma wartości w kolumnie MaxQty?
SELECT SUM(MaxQty) FROM Sales.SpecialOffer -- 138

-- średnia? suma/liczba wierszy, tj...
-- 138/16 = 8,625 

-- funkcja agregująca wyliczająca średnią arytmetyczną - AVG
-- karta "Messages"!!
SELECT AVG(MaxQty) AS AverageValue FROM Sales.SpecialOffer

-- jak wyliczyć poprawny wynik...
SELECT AVG(ISNULL(MaxQty, 0)) FROM Sales.SpecialOffer



-- COUNT(*) vs COUNT(column_name)
SELECT COUNT(*) FROM Sales.SpecialOffer
SELECT COUNT(MaxQty) FROM Sales.SpecialOffer

-- COUNT(*) zwraca liczbe wszystkich wierszy w tabeli
-- COUNT(nazwa_kolumny) zwraca liczbe wierszy, dla ktorych w 
--	nazwa_kolumny jest jakas wartosc









