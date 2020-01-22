/*

	Kurs SQL120 - J�zyk SQL w 2 godziny
	www.kursysql.pl

*/


USE AdventureWorks2017
GO

-- 1. Wy�wietl wszystkie produkty (tabela Production.Product) koloru czarnego,
-- posortowane malej�co wg ceny (ListPrice) 
SELECT * FROM Production.Product
WHERE Color = 'Black'
ORDER BY ListPrice

-- 2. Wy�wietl wszystkie produkty koloru czerwonego i niebieskiego, kt�rych nazwa zaczyna si� 
-- na 'L', posortowane wg rozmiaru malej�co i ceny rosn�co
SELECT * FROM Production.Product
WHERE Color IN ('Red', 'Blue') AND Name Like 'L%'
ORDER BY Size DESC, ListPrice ASC



-- 3. Wy�wietl wiersze z tabeli Sales.SalesTerritory, przypisane do Europy, posortowane wg nazwy kraju
-- podpowied�: Group jest s�owem zastrzezonym w SQL Server, 
--   pos�uguj�c si� kolumn� o tej nazwie w zapytaniach powiniene� wi�c u�ywa� nawiasow kwadratowych
SELECT * FROM Sales.SalesTerritory
WHERE [Group] = 'Europe'
ORDER BY Name

-- 4. Wy�wietl wiersze z tabeli Sales.SalesTerritory, 
-- posortowane wg grupy region�w (kontynent�w) malej�co i nazwy kraju rosn�co
SELECT * 
FROM Sales.SalesTerritory
ORDER BY [Group] DESC, Name ASC



-- 5. Wy�wietl zam�wienia przypisane do obszar�w o ID 7,8,9
SELECT * FROM Sales.SalesOrderHeader 
WHERE TerritoryID = 7 OR TerritoryID = 8 OR TerritoryID = 9
ORDER BY OrderDate

SELECT * FROM Sales.SalesOrderHeader 
WHERE TerritoryID IN (7,8,9)
ORDER BY OrderDate


-- 6. Wy�wietl 10 ostatnich zam�wie�,
-- przypisanych do obszar�w o ID 7,8,9 o 
-- warto�ci (kolumna SubTotal) mniejszej ni� 100
SELECT * 
FROM Sales.SalesOrderHeader 
WHERE TerritoryID IN (7,8,9) AND SubTotal < 100
ORDER BY OrderDate

-- 7. Wy�wietl 10 zam�wie� na najwy�sz� kwot�, przypisanych do obszaru 7,
SELECT TOP 10 *
FROM Sales.SalesOrderHeader 
WHERE TerritoryID = 7 
ORDER BY SubTotal ASC

-- 8. Wy�wietl zam�wienia przypisanych do obszaru 7, 
-- bez przypisanego numeru kardy kredytowej (kolumna CreditCardID)
SELECT *
FROM Sales.SalesOrderHeader 
WHERE TerritoryID = 7 AND CreditCardID IS NULL


-- 9. Wy�wietl zam�wienia przypisanych do obszaru 7, z przypisanym numerem kardy kredytowej 
SELECT *
FROM Sales.SalesOrderHeader 
WHERE TerritoryID = 7 AND CreditCardID IS NOT NULL


-- 10. Wy�wietl zam�wienia z roku 2011, posortuj wg daty zam�wienia
SELECT * FROM Sales.SalesOrderHeader 
WHERE OrderDate >= '20110101' AND OrderDate <= '20111231'
ORDER BY OrderDate

SELECT * FROM Sales.SalesOrderHeader 
WHERE OrderDate BETWEEN '20110101' AND '20111231'
ORDER BY OrderDate