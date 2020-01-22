/*

	Kurs SQL120 - Jêzyk SQL w 2 godziny
	www.kursysql.pl

*/


USE AdventureWorks2017
GO

-- 1. Wyœwietl wszystkie produkty (tabela Production.Product) koloru czarnego,
-- posortowane malej¹co wg ceny (ListPrice) 
SELECT * FROM Production.Product
WHERE Color = 'Black'
ORDER BY ListPrice

-- 2. Wyœwietl wszystkie produkty koloru czerwonego i niebieskiego, których nazwa zaczyna siê 
-- na 'L', posortowane wg rozmiaru malej¹co i ceny rosn¹co
SELECT * FROM Production.Product
WHERE Color IN ('Red', 'Blue') AND Name Like 'L%'
ORDER BY Size DESC, ListPrice ASC



-- 3. Wyœwietl wiersze z tabeli Sales.SalesTerritory, przypisane do Europy, posortowane wg nazwy kraju
-- podpowiedŸ: Group jest s³owem zastrzezonym w SQL Server, 
--   pos³uguj¹c siê kolumn¹ o tej nazwie w zapytaniach powinieneœ wiêc u¿ywaæ nawiasow kwadratowych
SELECT * FROM Sales.SalesTerritory
WHERE [Group] = 'Europe'
ORDER BY Name

-- 4. Wyœwietl wiersze z tabeli Sales.SalesTerritory, 
-- posortowane wg grupy regionów (kontynentów) malej¹co i nazwy kraju rosn¹co
SELECT * 
FROM Sales.SalesTerritory
ORDER BY [Group] DESC, Name ASC



-- 5. Wyœwietl zamówienia przypisane do obszarów o ID 7,8,9
SELECT * FROM Sales.SalesOrderHeader 
WHERE TerritoryID = 7 OR TerritoryID = 8 OR TerritoryID = 9
ORDER BY OrderDate

SELECT * FROM Sales.SalesOrderHeader 
WHERE TerritoryID IN (7,8,9)
ORDER BY OrderDate


-- 6. Wyœwietl 10 ostatnich zamówieñ,
-- przypisanych do obszarów o ID 7,8,9 o 
-- wartoœci (kolumna SubTotal) mniejszej ni¿ 100
SELECT * 
FROM Sales.SalesOrderHeader 
WHERE TerritoryID IN (7,8,9) AND SubTotal < 100
ORDER BY OrderDate

-- 7. Wyœwietl 10 zamówieñ na najwy¿sz¹ kwotê, przypisanych do obszaru 7,
SELECT TOP 10 *
FROM Sales.SalesOrderHeader 
WHERE TerritoryID = 7 
ORDER BY SubTotal ASC

-- 8. Wyœwietl zamówienia przypisanych do obszaru 7, 
-- bez przypisanego numeru kardy kredytowej (kolumna CreditCardID)
SELECT *
FROM Sales.SalesOrderHeader 
WHERE TerritoryID = 7 AND CreditCardID IS NULL


-- 9. Wyœwietl zamówienia przypisanych do obszaru 7, z przypisanym numerem kardy kredytowej 
SELECT *
FROM Sales.SalesOrderHeader 
WHERE TerritoryID = 7 AND CreditCardID IS NOT NULL


-- 10. Wyœwietl zamówienia z roku 2011, posortuj wg daty zamówienia
SELECT * FROM Sales.SalesOrderHeader 
WHERE OrderDate >= '20110101' AND OrderDate <= '20111231'
ORDER BY OrderDate

SELECT * FROM Sales.SalesOrderHeader 
WHERE OrderDate BETWEEN '20110101' AND '20111231'
ORDER BY OrderDate