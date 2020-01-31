/*
	KursySQL.pl

	PIERWSZE ZAPYTANIA

*/

USE AdventureWorks2017
GO

/*
	1. Wyœwietl identyfikator, datê zamówienia, identyfikator klienta i wartoœæ
	wszystkich zamówieñ posortowanych wg daty z³o¿enia
*/

SELECT SalesOrderID, OrderDate, CustomerID, SubTotal
FROM Sales.SalesOrderHeader
ORDER BY OrderDate


/*
	2. Wyœwietl zamówienia z³o¿one w maju 2014, posortowanych wg daty z³o¿enia
*/

SELECT *
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '20140501' AND '20140531'
ORDER BY OrderDate


/*
	3. Wyœwietl zamówienia z³o¿one po 1 czerwca 2014, które z³o¿yli klienci 11091 i 11277,
	posortowane wg daty z³o¿enia
*/

SELECT *
FROM Sales.SalesOrderHeader
WHERE OrderDate > '20140601' AND CustomerID IN (11091, 11277)
ORDER BY OrderDate


/*
	4. Wyœwietl podkategorie nale¿¹ce do podkategorii 2 i zaczynaj¹ce siê na literê B lub C
*/
SELECT * 
FROM Production.ProductSubcategory
WHERE ProductCategoryID = 2 AND (Name LIKE 'B%' OR Name LIKE 'C%')


/*
	5. Wyœwietl dane osób o identyfikatorze wiêkszym ni¿ 1000 i nieokreœlonym drugim imieniem,
	posortowane wg nazwiska i imienia
*/

SELECT * 
FROM Person.Person
WHERE BusinessEntityID > 1000 AND MiddleName IS NULL
ORDER BY LastName, FirstName


/*
	6. Wyœwietl 10 zamówieñ na najwy¿sz¹ kwotê, z³o¿onych w 2012 roku
*/

SELECT TOP 10 *
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '20120101' AND '20121231'
ORDER BY SubTotal DESC


/*
	7. Wyœwietl osoby o imieniu Ken i nazwisku zaczynaj¹cym siê na M, 
	posortowane wg identyfikatora 
*/

SELECT * 
FROM Person.Person
WHERE (FirstName = 'Ken' AND LastName LIKE 'M%')
ORDER BY BusinessEntityID


USE Filmy

/*
	8. Wyœwietl filmy, których jêzyk oryginalny jest polski, 
	czas trwania d³u¿szy ni¿ 2 godziny, które mia³y premierê po 2010 roku,
	posortowane wg tytu³u oryginalnego
*/
SELECT * 
FROM Film
WHERE JezykOryginalny = 'pl' AND CzasTrwaniaMin > 120 AND Premiera > '20101231'
ORDER BY TytulOryginalny


/*
	9. Wyœwietl filmy, których jêzyk oryginalny jest polski, francuski lub niemiecki 
	i których tytu³ oryginalny zaczyna siê na literê C lub M 
*/
SELECT * 
FROM Film
WHERE JezykOryginalny IN ('pl', 'fr', 'de') 
	AND (TytulOryginalny LIKE 'C%' OR TytulOryginalny LIKE 'M%')


/*
	10. Odczytaj filmy, których tytu³ zaczyna siê na 'Star Wars', 
	posortowane wg daty premiery, w dodatkowej - pierwszej kolumnie wyœwietl liczbê  
	sekund które trwa film
*/

SELECT CzasTrwaniaMin*60 AS CzasTrwaniaSec, *
FROM Film WHERE Tytul LIKE 'Star Wars%'
ORDER BY Premiera