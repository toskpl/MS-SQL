/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	GRUPOWANIE DANYCH
	F: Funkcje okna 

*/



USE AdventureWorks2017
GO

-- bez grupowania
SELECT OrderDate
	,CustomerID, SalesOrderNumber, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate ASC


-- GROUP BY 
SELECT OrderDate
	--,CustomerID, SalesOrderNumber, TotalDue
	,SUM(TotalDue)
FROM Sales.SalesOrderHeader
GROUP BY OrderDate
ORDER BY OrderDate

-- ?? jaki klient? jakie numery zamówień?

-- PARTYCJA: data (dzień) sprzedaży
SELECT OrderDate, CustomerID, SalesOrderNumber, TotalDue
	,SUM(TotalDue) OVER (PARTITION BY OrderDate) AS TotalDueDate
FROM Sales.SalesOrderHeader
WHERE OrderDate > '20110531'
ORDER BY OrderDate ASC


-- RAMKA: dodanie ORDER BY daje sumę kroczącą, kolejność wyznaczona numeracją zamówień
SELECT OrderDate, CustomerID, SalesOrderNumber, TotalDue
	,SUM(TotalDue) OVER (PARTITION BY OrderDate ORDER BY SalesOrderNumber) AS TotalDueDateRunningSUM
FROM Sales.SalesOrderHeader
WHERE OrderDate > '20110531'
ORDER BY OrderDate ASC


-- jedno zapytanie - dwa wyrażenia
SELECT OrderDate, CustomerID, SalesOrderNumber, TotalDue
	,SUM(TotalDue) OVER (PARTITION BY OrderDate) AS TotalDueDateSUM
	,SUM(TotalDue) OVER (PARTITION BY OrderDate ORDER BY SalesOrderNumber) AS TotalDueDateRunningSUM
	--,SUM(TotalDue) OVER () 
FROM Sales.SalesOrderHeader
WHERE OrderDate > '20110531'
ORDER BY OrderDate ASC



/* Funkcje agregujące */

SELECT CustomerID, SalesOrderNumber, OrderDate, CurrencyRateID, TotalDue
	,SUM(TotalDue) OVER (PARTITION BY OrderDate) AS TotalDueDateSUM
	,AVG(TotalDue) OVER (PARTITION BY OrderDate) AS TotalDueDateAVG
	,MIN(TotalDue) OVER (PARTITION BY OrderDate) AS TotalDueDateMIN
	,MAX(TotalDue) OVER (PARTITION BY OrderDate) AS TotalDueDateMAX
	,COUNT(*) OVER (PARTITION BY OrderDate) AS TotalDueDateCOUNT
	,COUNT(CurrencyRateID) OVER (PARTITION BY OrderDate) AS TotalDueDateCOUNT_CurrencyRateID
	-- ,COUNT(DISTINCT CurrencyRateID) OVER (PARTITION BY OrderDate) AS TotalDueDateCOUNT_DISTINCT
FROM Sales.SalesOrderHeader
WHERE OrderDate > '20110531'
ORDER BY OrderDate ASC


/* Funkcje szeregujące */

SELECT CustomerID, SalesOrderNumber, OrderDate, CurrencyRateID, TotalDue
	,RANK() OVER (PARTITION BY OrderDate ORDER BY TotalDue DESC) AS TotalDueRANK
	,DENSE_RANK() OVER (PARTITION BY OrderDate ORDER BY TotalDue DESC) AS TotalDueDENSE_RANK
	,ROW_NUMBER() OVER (PARTITION BY OrderDate ORDER BY TotalDue DESC) AS TotalDueROW_NUMBER
	,ROW_NUMBER() OVER (ORDER BY TotalDue DESC) AS TotalDueROW_NUMBER2
FROM Sales.SalesOrderHeader
WHERE OrderDate > '20110531'
--ORDER BY OrderDate ASC, TotalDue DESC
ORDER BY CustomerID



-- stronicowanie za pomocą ROW_NUMBER

SELECT CustomerID, SalesOrderNumber, OrderDate, CurrencyRateID, TotalDue
	,ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNumber
FROM Sales.SalesOrderHeader

;WITH Paging_CTE AS
(
	SELECT CustomerID, SalesOrderNumber, OrderDate, CurrencyRateID, TotalDue
		,ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNumber
	FROM Sales.SalesOrderHeader
)
SELECT * FROM Paging_CTE 
WHERE RowNumber >= 101 AND RowNumber <= 200




SELECT ProductID, Name, Color, 
	SUM(ListPrice) OVER (PARTITION BY Color) AS ListPriceSUM
FROM Production.Product

-- Wyświetl identiyfikator i nazwę najdroższego produktu każdego z kolorów

SELECT Color, MAX(ListPrice) -- ?? ProductID, Name
FROM Production.Product
GROUP BY Color

SELECT ProductID, Name, Color, MAX(ListPrice) -- ?? ProductID, Name
FROM Production.Product
GROUP BY ProductID, Name, Color


SELECT ProductID, Name, Color, ListPrice,
	ROW_NUMBER() OVER (PARTITION BY Color ORDER BY ListPrice DESC) AS Rn
FROM Production.Product



;WITH _cte AS (
	SELECT ProductID, Name, Color, ListPrice,
		ROW_NUMBER() OVER (PARTITION BY Color ORDER BY ListPrice DESC) AS Rn
	FROM Production.Product
)
SELECT ProductID, Name, Color, ListPrice
FROM _cte WHERE Rn=1



