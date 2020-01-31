/*
	KursySQL.pl

	PIERWSZE ZAPYTANIA
	C Sortowanie danych

*/



USE AdventureWorks2017
GO


-- domyślny porządek sortowania
SELECT * FROM Production.Product


-- wiersze posortowane ROSNĄCO wg zawartości kolumny Name
-- = produkty posortowanie wg nazwy
SELECT * FROM Production.Product
ORDER BY Name


-- porządek sortowania malejący
SELECT * FROM Production.Product
ORDER BY Name DESC


-- dwa poziomy sortowania
-- produkty posortowane wg koloru, a te które mają ten sam kolor - wg nazwy
SELECT * FROM Production.Product
ORDER BY Color, Name


-- malejąco wg koloru i rosnąco wg nazwy
SELECT * FROM Production.Product
ORDER BY Color DESC, Name




-- Klauzula TOP

SELECT ProductID, Name, Color FROM Production.Product


SELECT TOP 10 ProductID, Name, Color 
FROM Production.Product
ORDER BY Name 


SELECT TOP 10 PERCENT ProductID, Name, Color FROM Production.Product
ORDER BY Name 



SELECT TOP 5 ProductID, Name, Color FROM Production.Product
ORDER BY Color DESC


SELECT TOP 5 WITH TIES ProductID, Name, Color FROM Production.Product
ORDER BY Color DESC



