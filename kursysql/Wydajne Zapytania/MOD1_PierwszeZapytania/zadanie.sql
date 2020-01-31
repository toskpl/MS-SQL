/*
	KursySQL.pl

	PIERWSZE ZAPYTANIA

*/

USE AdventureWorks2017
GO

/*
	1. Wy�wietl identyfikator, dat� zam�wienia, identyfikator klienta i warto��
	wszystkich zam�wie� posortowanych wg daty z�o�enia
*/

SELECT SalesOrderID, OrderDate, CustomerID, SubTotal
FROM Sales.SalesOrderHeader
ORDER BY OrderDate


/*
	2. Wy�wietl zam�wienia z�o�one w maju 2014, posortowanych wg daty z�o�enia
*/

SELECT *
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '20140501' AND '20140531'
ORDER BY OrderDate


/*
	3. Wy�wietl zam�wienia z�o�one po 1 czerwca 2014, kt�re z�o�yli klienci 11091 i 11277,
	posortowane wg daty z�o�enia
*/

SELECT *
FROM Sales.SalesOrderHeader
WHERE OrderDate > '20140601' AND CustomerID IN (11091, 11277)
ORDER BY OrderDate


/*
	4. Wy�wietl podkategorie nale��ce do podkategorii 2 i zaczynaj�ce si� na liter� B lub C
*/
SELECT * 
FROM Production.ProductSubcategory
WHERE ProductCategoryID = 2 AND (Name LIKE 'B%' OR Name LIKE 'C%')


/*
	5. Wy�wietl dane os�b o identyfikatorze wi�kszym ni� 1000 i nieokre�lonym drugim imieniem,
	posortowane wg nazwiska i imienia
*/

SELECT * 
FROM Person.Person
WHERE BusinessEntityID > 1000 AND MiddleName IS NULL
ORDER BY LastName, FirstName


/*
	6. Wy�wietl 10 zam�wie� na najwy�sz� kwot�, z�o�onych w 2012 roku
*/

SELECT TOP 10 *
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '20120101' AND '20121231'
ORDER BY SubTotal DESC


/*
	7. Wy�wietl osoby o imieniu Ken i nazwisku zaczynaj�cym si� na M, 
	posortowane wg identyfikatora 
*/

SELECT * 
FROM Person.Person
WHERE (FirstName = 'Ken' AND LastName LIKE 'M%')
ORDER BY BusinessEntityID


USE Filmy

/*
	8. Wy�wietl filmy, kt�rych j�zyk oryginalny jest polski, 
	czas trwania d�u�szy ni� 2 godziny, kt�re mia�y premier� po 2010 roku,
	posortowane wg tytu�u oryginalnego
*/
SELECT * 
FROM Film
WHERE JezykOryginalny = 'pl' AND CzasTrwaniaMin > 120 AND Premiera > '20101231'
ORDER BY TytulOryginalny


/*
	9. Wy�wietl filmy, kt�rych j�zyk oryginalny jest polski, francuski lub niemiecki 
	i kt�rych tytu� oryginalny zaczyna si� na liter� C lub M 
*/
SELECT * 
FROM Film
WHERE JezykOryginalny IN ('pl', 'fr', 'de') 
	AND (TytulOryginalny LIKE 'C%' OR TytulOryginalny LIKE 'M%')


/*
	10. Odczytaj filmy, kt�rych tytu� zaczyna si� na 'Star Wars', 
	posortowane wg daty premiery, w dodatkowej - pierwszej kolumnie wy�wietl liczb�  
	sekund kt�re trwa film
*/

SELECT CzasTrwaniaMin*60 AS CzasTrwaniaSec, *
FROM Film WHERE Tytul LIKE 'Star Wars%'
ORDER BY Premiera