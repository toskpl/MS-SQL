/*
	KursySQL.pl

	PIERWSZE ZAPYTANIA
	A: Podstawy

*/


USE AdventureWorks2017
GO


/* SELECT STAR FROM TABELA */

SELECT * FROM Production.Product





-- komentarz

/* Komentarz blokowy */







/* Schematy */

-- NAZWA_SCHEMATU.NAZWA_TABELI
SELECT * FROM Production.Product

SELECT * FROM Person.Person


-- brakuje nazwy schematu
SELECT * FROM Person


SELECT * FROM dbo.DatabaseLog

-- schemat dbo to domyślny schemat
SELECT * FROM DatabaseLog





/* Inna baza danych */

SELECT * FROM Filmy.dbo.Film

USE Filmy 
GO

SELECT * FROM Film

USE AdventureWorks2017
GO


/* Batch = wsad */


SELECT * FROM Production.Product

SELECT * FROM Production.ProductSubcategory

SELECT * FROM Production.ProductCategory
GO


SELECT * FROM Production.Product
GO

SELECT * FROM Production.ProductSubcategory
GO

SELECT * FROM Production.ProductCategory
GO


-- błędy składniowe

SELECT * FROM Production.Product

SELECT * FRM Production.ProductSubcategory

SELECT * FROM Production.ProductCategory
GO


SELECT * FROM Production.Product
GO

SELECT * FRM Production.ProductSubcategory
GO

SELECT * FROM Production.ProductCategory
GO


-- pętla

SELECT * FROM Production.ProductCategory
GO 3





/* Nazwy kolumn */

SELECT ProductID, Name, Color, Size 
FROM Production.Product
-- ProductID = klucz główny (PRIMARY KEY, PK)


SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person


-- aliasy kolumn

SELECT ProductID AS ID, Name AS Nazwa, Color AS Kolor, Size AS Rozmiar
FROM Production.Product
ORDER BY Name

SELECT 
	BusinessEntityID AS ID, 
	FirstName AS Imie, 
	LastName AS Nazwisko
FROM Person.Person





/* Nawiasy kwadratowe */

-- zwykle opcjonalne...
SELECT * FROM [Person].[Person]

SELECT 
	[BusinessEntityID] AS ID, 
	[FirstName] AS Imie, 
	[LastName] AS Nazwisko
FROM Person.Person

-- SSMS: SELECT x FROM tabela...

-- słowa zastrzeżone
SELECT BusinessEntityID, FirstName AS From, LastName 
FROM Person.Person

SELECT BusinessEntityID, FirstName AS [From], LastName 
FROM Person.Person

SELECT BusinessEntityID, FirstName AS File, LastName 
FROM Person.Person

SELECT BusinessEntityID, FirstName AS [File], LastName 
FROM Person.Person


-- Google: "sql reserver keywords"
-- https://docs.microsoft.com/en-us/sql/t-sql/language-elements/reserved-keywords-transact-sql?view=sql-server-ver15


-- nazwy obiektów ze spacją

SELECT * FROM HumanResources.JobCandidate

-- zmiana nazwy...
sp_rename 'HumanResources.JobCandidate', 'Job Candidate'


--!
SELECT * FROM HumanResources.Job Candidate

-- nawiasy kwadratowe - obowiązkowe
SELECT * FROM [HumanResources].[Job Candidate]


-- powrót do oryginalnej nazwy
sp_rename 'HumanResources.Job Candidate', 'JobCandidate'





/* Wyrażenie */

SELECT * FROM Production.Product

-- operacje na wartościach liczbowych
SELECT ProductID, Name, ListPrice FROM Production.Product

SELECT ProductID, Name, ListPrice, ListPrice*0.9 AS ListPricePromo
FROM Production.Product


-- łączenie łańcuchów znaków
SELECT FirstName + ' ' + LastName AS Fullname, * FROM Person.Person

SELECT CONCAT(FirstName, ' ', LastName) AS Fullname, * FROM Person.Person


SELECT UPPER(LastName) AS Fullname, * FROM Person.Person



SELECT 1+4

SELECT 'Jan' + ' ' + 'Nowak' 

SELECT UPPER('Nowak')





/* Baza Filmy */

USE Filmy
GO

SELECT * FROM Film

SELECT FilmID, Tytul, TytulOryginalny, Opis
FROM Film


SELECT FilmID, UPPER(Tytul), TytulOryginalny, Opis
FROM Film

SELECT 
	FilmID, 
	UPPER(Tytul) AS Tytul, 
	TytulOryginalny AS [Tytul Oryginalny], 
	Opis AS [Opis Filmu]
FROM Film






