/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	FUNKCJE
	C: Logiczne

*/


/* CHOOSE() */

-- CHOOSE ( index, val_1, val_2 [, val_n ] )
SELECT CHOOSE ( 3, 'Marty', 'Doc Brown', 'Biff', 'Mr. Strickland')


USE AdventureWorks2017

SELECT ProductCategoryID, CHOOSE (ProductCategoryID, 'A','B','C','D','E') AS Kategoria
FROM Production.ProductCategory



/* IIF() */

-- IIF ( boolean_expression, true_value, false_value )
SELECT IIF ( 1 > 4, 'TRUE', 'FALSE')


SELECT DAY(GETDATE())

-- reszta z dzielenia przez 2
SELECT DAY(GETDATE())%2

SELECT IIF (DAY(GETDATE())%2=0, 'parzysty', 'nieparzysty') + ' dzień miesiąca'


SELECT ListPrice,
	IIF(ListPrice=0, 'brak ceny', NULL) AS ListPrice2, 
	* 
FROM Production.Product

SELECT ListPrice,
	IIF(ListPrice=0, 'brak ceny', IIF(ListPrice<100, 'niska cena', 'wysoka cena')) AS ListPrice2, 
	* 
FROM Production.Product


/* CASE */

SELECT 
	CASE 
		WHEN DAY(GETDATE())%2=0 THEN 'parzysty'
		ELSE 'nieparzysty' END + ' dzień miesiąca'


SELECT ListPrice,
	CASE 
		WHEN ListPrice=0 THEN 'brak ceny'
		WHEN ListPrice<100 THEN 'niska cena'
		ELSE 'wysoka cena' END AS ListPrice2, 
	* 
FROM Production.Product



SELECT Color,
	CASE Color
		WHEN 'Black' THEN 'czarny'
		WHEN 'Silver' THEN 'srebrny'
		WHEN 'Blue' THEN 'niebieski'
		ELSE 'inny kolor' END AS Color2, 
	* 
FROM Production.Product


SELECT Color,
	CASE ISNULL(Color, '')
		WHEN 'Black' THEN 'czarny'
		WHEN 'Silver' THEN 'srebrny'
		WHEN 'Blue' THEN 'niebieski'
		WHEN '' THEN 'brak'
		ELSE 'inny kolor' END AS Color2, 
	* 
FROM Production.Product



