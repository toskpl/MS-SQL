/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	GRUPOWANIE DANYCH
	E: PIVOT

*/


USE AdventureWorks2017
GO

-- tylko 4 różne lata sprzedaży
SELECT DISTINCT	YEAR(OrderDate) AS OrderYear
FROM Sales.SalesOrderHeader

-- 26 017 wierszy
SELECT
	YEAR(OrderDate) AS OrderYear,
	CustomerID,
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), CustomerID
ORDER BY YEAR(OrderDate), CustomerID





/* PIVOT */

-- 19 119
SELECT CustomerID, [2011], [2012], [2013], [2014] 
FROM (
	SELECT YEAR(OrderDate) AS OrderYear, SalesOrderID, CustomerID
	FROM Sales.SalesOrderHeader) AS Src
PIVOT (
	COUNT(SalesOrderID) FOR OrderYear IN ([2011], [2012], [2013], [2014]) 
) AS Pvt


-- 19 119
SELECT CustomerID, [2011], [2012], [2013], [2014] 
FROM (
	SELECT YEAR(OrderDate) AS OrderYear, SubTotal, CustomerID
	FROM Sales.SalesOrderHeader) AS Src
PIVOT (
	SUM(SubTotal) FOR OrderYear IN ([2011], [2012], [2013], [2014]) 
) AS Pvt


SELECT *FROM Person.Person
SELECT DISTINCT PersonType FROM Person.Person

SELECT PersonType, count(*)
FROM Person.Person
GROUP BY PersonType

SELECT 'NumberOfPeople', [IN], [EM], [SP], [SC], [VC], [GC]
FROM (
	SELECT PersonType, BusinessEntityID
	FROM Person.Person) AS Src
PIVOT (
	COUNT(BusinessEntityID) FOR PersonType IN ([IN], [EM], [SP], [SC], [VC], [GC])
) AS Pvt



/* Baza Filmy */
USE Filmy

SELECT * FROM Film

SELECT DISTINCT YEAR(Premiera) FROM Film
SELECT DISTINCT JezykOryginalny FROM Film


SELECT PremieraRok, [pl], [en], [fr]
FROM (
	SELECT JezykOryginalny, YEAR(Premiera) AS PremieraRok, FilmID
	FROM Film) AS Src
PIVOT (
	COUNT(FilmID) FOR JezykOryginalny IN ([pl], [en], [fr])
) AS Pvt


/* Dynamiczny PIVOT */

SELECT DISTINCT JezykOryginalny
FROM Filmy.dbo.Film
 
SELECT STRING_AGG(JezykOryginalny, ', ')
FROM Film

SELECT STRING_AGG(CAST(JezykOryginalny AS nvarchar(max)), ', ')
FROM Film

SELECT STRING_AGG(JezykOryginalny, ', ')
FROM (
SELECT DISTINCT JezykOryginalny FROM Film) AS Dis


DECLARE @Kolumny AS NVARCHAR(max)

	SELECT @Kolumny =  STRING_AGG('['+JezykOryginalny+']', ', ')
	FROM (
	SELECT DISTINCT JezykOryginalny FROM Film) AS Dis
	

DECLARE @Sql AS NVARCHAR(max)

SET @Sql = 
	'SELECT PremieraRok, ' + @Kolumny + '
	FROM (
		SELECT JezykOryginalny, YEAR(Premiera) AS PremieraRok, FilmID
		FROM Film) AS Src
	PIVOT (
		COUNT(FilmID) FOR JezykOryginalny IN ('+@Kolumny+')
	) AS Pvt'

PRINT @Sql

EXEC sp_executesql @Sql
GO

-- ograniczenie listy języków 

SELECT YEAR(Premiera), JezykOryginalny, COUNT(*) 
FROM Film
GROUP BY YEAR(Premiera), JezykOryginalny
HAVING COUNT(*)>50

SELECT DISTINCT JezykOryginalny 
FROM Film
GROUP BY YEAR(Premiera), JezykOryginalny
HAVING COUNT(*)>50

DECLARE @Kolumny AS NVARCHAR(max)

	SELECT @Kolumny =  STRING_AGG('['+JezykOryginalny+']', ', ')
	FROM (
		SELECT DISTINCT JezykOryginalny FROM Film
		GROUP BY YEAR(Premiera), JezykOryginalny HAVING COUNT(*)>50
	) AS Dis


DECLARE @Sql AS NVARCHAR(max)

SET @Sql = 
	'SELECT PremieraRok, ' + @Kolumny + '
	FROM (
		SELECT JezykOryginalny, YEAR(Premiera) AS PremieraRok, FilmID
		FROM Film) AS Src
	PIVOT (
		COUNT(FilmID) FOR JezykOryginalny IN ('+@Kolumny+')
	) AS Pvt'

PRINT @Sql

EXEC sp_executesql @Sql
GO







/* UNPIVOT */

USE AdventureWorks2017
GO

-- 31 465
SELECT YEAR(OrderDate) AS OrderYear, CustomerID, SubTotal
FROM Sales.SalesOrderHeader
ORDER BY OrderYear, CustomerID

DROP TABLE IF EXISTS OrdersPivot

SELECT CustomerID, [2011], [2012], [2013], [2014] 
INTO OrdersPivot
FROM (
	SELECT YEAR(OrderDate) AS OrderYear, SubTotal, CustomerID
	FROM Sales.SalesOrderHeader) AS Src
PIVOT (
	SUM(SubTotal) FOR OrderYear IN ([2011], [2012], [2013], [2014]) 
) AS Pvt

SELECT * FROM OrdersPivot
GO

-- 26 017
SELECT CustomerID, OrderYear, SubTotalSum
FROM OrdersPivot AS Pvt
UNPIVOT (SubTotalSum FOR OrderYear IN ([2011],[2012],[2013],[2014])) AS un

