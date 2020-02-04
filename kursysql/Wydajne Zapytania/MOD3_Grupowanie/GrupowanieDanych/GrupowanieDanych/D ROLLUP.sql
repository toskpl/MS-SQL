/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	GRUPOWANIE DANYCH
	D: ROLLUP, CUBE, GROUPING SETS

*/


USE AdventureWorks2017
GO




-- przydatne funkcje: YEAR(), MONTH(), CONVERT(), DATENAME()
-- liczba zamówień w poszczególnych latach
SELECT
	YEAR(OrderDate) AS OrderYear,
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear


-- w poszczególnych latach, miesiącach
SELECT
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear

-- co to za miesiąc?
SELECT
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	DATENAME(MONTH, OrderDate) AS OrderMonthName,
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate), DATENAME(MONTH, OrderDate)
ORDER BY OrderYear


-- nazwa miesiąca w j. polskim
SET LANGUAGE Polish
SELECT
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	DATENAME(MONTH, OrderDate) AS OrderMonthName,
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate), DATENAME(MONTH, OrderDate)
ORDER BY OrderYear

-- poprawnie posortować miesiące...
SELECT
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	DATENAME(MONTH, OrderDate) AS OrderMonthName,
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate), DATENAME(MONTH, OrderDate)
ORDER BY OrderYear, OrderMonth



SET LANGUAGE english

-- Liczba zamówień w poszczególnych latach - miesiącach (wyświetl numer i nazwę miesiąca, posortuj wg numeru)
SELECT
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	DATENAME(month, OrderDate) AS OrderMonthName,
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate), DATENAME(month, OrderDate)
ORDER BY YEAR(OrderDate), MONTH(OrderDate)


-- Dodaj obsługę ROLLUP - podsumowania dla kombinacji kolumn
SELECT
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	DATENAME(month, OrderDate) AS OrderMonthName,
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY ROLLUP(
	YEAR(OrderDate), MONTH(OrderDate), DATENAME(month, OrderDate))
ORDER BY YEAR(OrderDate), MONTH(OrderDate)

-- CUBE - podsumowania dla wszystkich kombinacji
SELECT
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	DATENAME(month, OrderDate) AS OrderMonthName,
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY CUBE(YEAR(OrderDate), MONTH(OrderDate), DATENAME(month, OrderDate))
ORDER BY YEAR(OrderDate), MONTH(OrderDate)





/*
	GROUPING SETS
	określone poziomy grupowań
*/
SELECT
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	DATENAME(month, OrderDate) AS OrderMonthName,
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY GROUPING SETS
(
	(),
	(YEAR(OrderDate)),
	(YEAR(OrderDate), MONTH(OrderDate), DATENAME(month, OrderDate))
)
ORDER BY YEAR(OrderDate), MONTH(OrderDate)





/* 
	GROUPING() 
	Pozwala odróżnić zgrupowane wartości wg wskazanej kolumny
	od pozostałych
*/

SELECT
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	DATENAME(month, OrderDate) AS OrderMonthName,

	GROUPING(MONTH(OrderDate)) AS GroupedByMonth,
	GROUPING(YEAR(OrderDate) ) AS GroupedByYear,
	
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY CUBE(YEAR(OrderDate), MONTH(OrderDate), DATENAME(month, OrderDate))
ORDER BY YEAR(OrderDate), MONTH(OrderDate)




-- CurrencyRateID zawiera wartości nieokreślone - NULL
SELECT
	YEAR(OrderDate) AS OrderYear,
	CurrencyRateID,
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY CUBE(YEAR(OrderDate), CurrencyRateID)
ORDER BY YEAR(OrderDate), CurrencyRateID


SELECT
	YEAR(OrderDate) AS OrderYear,
	CurrencyRateID,
	GROUPING(CurrencyRateID),
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
GROUP BY CUBE(YEAR(OrderDate), CurrencyRateID)
ORDER BY YEAR(OrderDate), CurrencyRateID

SELECT
	YEAR(OrderDate) AS OrderYear,
	CurrencyRateID,
	GROUPING(CurrencyRateID),
	COUNT(*) AS CntOrders
FROM Sales.SalesOrderHeader
WHERE CurrencyRateID IS NOT NULL
GROUP BY CUBE(YEAR(OrderDate), CurrencyRateID)
ORDER BY YEAR(OrderDate), CurrencyRateID







/* Baza Filmy */

USE Filmy

SELECT * FROM Film


SELECT JezykOryginalny, YEAR(Premiera) AS PremieraRok, AVG(CzasTrwaniaMin) AS CzasTrwaniaSredni
FROM Film
WHERE JezykOryginalny IN ('pl', 'en', 'fr') AND YEAR(Premiera) > 2000
GROUP BY JezykOryginalny, YEAR(Premiera)
ORDER BY JezykOryginalny, PremieraRok


SELECT JezykOryginalny, YEAR(Premiera) AS PremieraRok, AVG(CzasTrwaniaMin) AS CzasTrwaniaSredni
FROM Film
WHERE JezykOryginalny IN ('pl', 'en', 'fr') AND YEAR(Premiera) > 2000
GROUP BY GROUPING SETS (
	(JezykOryginalny, YEAR(Premiera)),
	(),
	(JezykOryginalny)
)
ORDER BY JezykOryginalny, PremieraRok











