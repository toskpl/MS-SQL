/*
	KursySQL.pl

	PIERWSZE ZAPYTANIA
	E Filtrowanie danych

*/


USE AdventureWorks2017
GO

/* Wartości liczbowe, tekst, daty */

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID = 707

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID > 707

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID >= 707

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID <> 707


SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Red'

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Size = 'M'



SELECT ProductID, Name, Color, Size, ModifiedDate 
FROM Production.Product
WHERE ModifiedDate > '20140208'




/* Wartości tekstowe i operator LIKE */

SELECT * FROM Production.Product 
WHERE Name LIKE 'Men%'

-- % - dowolony znak w dowolnej liczbie
SELECT * FROM Production.Product 
WHERE Name LIKE '%Bib-short%'


--!
SELECT * FROM Production.Product 
WHERE Name = 'Men's Bib-Shorts, L'

' --

SELECT * FROM Production.Product 
WHERE Name = 'Men''s Bib-Shorts, L'

SELECT * FROM Production.Product 
WHERE Name LIKE 'Men''s Bib-Shorts, %'




-- _ dowolny pojedynczy znak
SELECT * FROM Production.Product
WHERE Name LIKE 'Men''s Bib-Shorts, _'



-- [] lista znaków
SELECT * FROM Production.Product
WHERE Name LIKE 'Men''s Bib-Shorts, [AM]'

SELECT * FROM Production.Product
WHERE Name LIKE 'Men''s Bib-Shorts, [A-S]'




--! = zamiast LIKE
SELECT * FROM Production.Product 
WHERE Name = '%Bike%'




/* Operator BETWEEN */

SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID BETWEEN 300 AND 320

-- taki sam wynik
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID >= 300 AND ProductID <= 320

-- zaprzeczenie
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE ProductID NOT BETWEEN 300 AND 320


SELECT SalesOrderID, OrderDate, CustomerID
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '20140101' AND '20140131'

-- taki sam wynik
SELECT SalesOrderID, OrderDate, CustomerID
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '20140101' AND OrderDate <= '20140131'

-- zaprzeczenie
SELECT SalesOrderID, OrderDate, CustomerID
FROM Sales.SalesOrderHeader
WHERE OrderDate NOT BETWEEN '20140101' AND '20140131'



/* Operator IN */
SELECT ProductID, Name, Color, Size 
FROM Production.Product 
WHERE Color IN ('Black', 'Silver', 'Red')

-- taki sam wynik
SELECT ProductID, Name, Color, Size 
FROM Production.Product 
WHERE Color = 'Black' OR Color= 'Silver' OR Color  = 'Red'

-- zaprzeczenie
SELECT ProductID, Name, Color, Size 
FROM Production.Product 
WHERE Color NOT IN ('Black', 'Silver', 'Red')




/* Operatory logiczne */

-- produkty koloru czarnego, o rozmiarze M
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Black' AND Size = 'M'

-- produkty koloru czarnego lub niebieskiego
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Black' OR Color = 'Blue'



--!
SELECT ProductID, Name, Color, Size
FROM Production.Product 
WHERE Color = 'Blue' AND Color = 'Red'


-- produkty koloru czarnego, srebrnego i niebieskiego (odpowiednik IN)
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Black' OR Color = 'Silver' OR Color = 'Blue'

-- łączymy razem...
SELECT ProductID, Name, Color, Size, ProductSubcategoryID
FROM Production.Product 
WHERE ProductSubcategoryID = 2 AND NOT Color = 'Red'
-- taki sam wynik
SELECT ProductID, Name, Color, Size, ProductSubcategoryID
FROM Production.Product 
WHERE ProductSubcategoryID = 2 AND Color <> 'Red'
-- taki sam wynik
SELECT ProductID, Name, Color, Size, ProductSubcategoryID
FROM Production.Product 
WHERE ProductSubcategoryID = 2 AND Color != 'Red'



/* Hierarchia operatorów */

-- AND przed OR
-- (produkty koloru czarnego i rozmiaru M) lub (rozmiaru S)
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Black' AND Size = 'M' OR Size = 'S'
-- taki sam wynik
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE (Color = 'Black' AND Size = 'M') OR Size = 'S'



-- nawiasy...
SELECT ProductID, Name, Color, Size 
FROM Production.Product
WHERE Color = 'Black' AND (Size = 'M' OR Size = 'S')




/* Baza Filmy */
USE Filmy
GO

SELECT * 
FROM Film WHERE JezykOryginalny = 'pl'


SELECT TOP 100 *
FROM Film 
WHERE JezykOryginalny = 'pl' 
ORDER BY Premiera DESC

SELECT TOP 100 *
FROM Film 
WHERE JezykOryginalny = 'pl' AND Premiera BETWEEN '20140101' AND '20141231'

SELECT *
FROM Film 
WHERE JezykOryginalny = 'pl' AND Budzet > 2000000


SELECT TOP 100 *
FROM Film 
WHERE JezykOryginalny = 'pl' AND Tytul LIKE 'I%'


SELECT TOP 100 *
FROM Film 
WHERE (JezykOryginalny = 'pl' OR JezykOryginalny = 'fr') AND CzasTrwaniaMin > 240

SELECT TOP 100 *
FROM Film 
WHERE JezykOryginalny IN ('pl', 'fr') AND CzasTrwaniaMin > 240


