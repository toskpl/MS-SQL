/*
	KursySQL.pl

	PIERWSZE ZAPYTANIA
	F NULL - wartości nieokreślone

*/

USE AdventureWorks2017
GO



-- NULL

-- na początku w kolumnie kolor wartości nieokreślone
SELECT * FROM Production.Product
ORDER BY Color

--! czy na pewno nie ma takich wierszy
SELECT * FROM Production.Product
WHERE Color = NULL


SELECT * FROM Production.Product
WHERE Color IS NULL

SELECT * FROM Production.Product
WHERE Color IS NOT NULL


-- łączymy razem...
SELECT * FROM Production.Product 
WHERE Color = 'Black' AND Size IS NOT NULL AND Name LIKE '%Frame%'


/* Funkcja ISNULL */

SELECT ISNULL(NULL, 'pusto!')
SELECT ISNULL('test2', 'pusto!')
SELECT ISNULL(3, 'pusto!')



SELECT ProductID, Name, ISNULL(Color, 'brak koloru') AS Color
FROM Production.Product



SELECT ProductID, 
	Name, 
	Color,
	Size
FROM Production.Product



SELECT ProductID, 
	Name, 
	ISNULL(Color, '') AS Color, 
	ISNULL(Size, '') AS Size
FROM Production.Product



