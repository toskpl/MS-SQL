/*

	RODZAJE INDEKSÓW
	C: Indeks nieklastrowy

*/


--> Setup

USE AdventureWorks2017
GO


--indeks klastrowy
CREATE UNIQUE CLUSTERED INDEX IDX_CL_People_ID ON People (ID)
GO


SET STATISTICS IO ON
GO

--logical reads 659
-- index IDX_CL_People_ID scan
SELECT * FROM People


--logical reads 659
-- index IDX_CL_People_ID scan
SELECT * FROM People WHERE FirstName = 'Kevin'

--logical reads 659
-- index IDX_CL_People_ID scan
SELECT * FROM People WHERE Country = 'France'

--logical reads 3
-- index IDX_CL_People_ID seek
SELECT * FROM People WHERE ID = 1771

--logical reads 659
-- index IDX_CL_People_ID scan
SELECT * FROM People ORDER BY ID

--logical reads 659
-- index IDX_CL_People_ID scan
SELECT * FROM People ORDER BY ID DESC


/*
	NONCLUSTERED INDEX
	
*/

-- DROP INDEX IDX_NCL_People_Country ON People
CREATE NONCLUSTERED INDEX IDX_NCL_People_Country ON People (Country)
GO

-- index size 768 KB powiekszylo sie o index niesklastrowany
EXEC sp_spaceused 'People'


-- logical reads 659
-- plan zapytania : IDX_NCL_People_ID scan
SELECT * FROM People

-- odczyt calej tabeli 
-- logical reads 659
-- plan zapytania : IDX_NCL_People_ID scan
SELECT * FROM People WHERE FirstName = 'Kevin'

-- index dla country = wynik 1 811 row x 3 poziomy = 5 433 logical reads
-- index IDX_NCL_People_Country zignorowany 
-- szybciej odczytac cala tabele 
-- plan zapytania : IDX_NCL_People_ID scan 
-- logical reads 659
SELECT * FROM People WHERE Country = 'France'

--logical reads 9
--plan zapytania : IDX_NCL_People_ID seek
SELECT * FROM People WHERE ID = 1771

-- uzyje indeksu niesklastrowanego IDX_NCL_People_Country
-- logical reads 9
-- plan zapytania: IDX_NCL_People_Country seek + operator aggregate
SELECT count(*) FROM People WHERE Country = 'France'


-- zwroci 1 811 wierszy
-- uzyje indeksu niesklastrowanego IDX_NCL_People_Country seek
-- logical reads 9
-- plan zapytania: IDX_NCL_People_Country seek

SELECT ID FROM People WHERE Country = 'France'

-- dodano do selecta kolumny FirstName, LastName
-- uzyje index klastrowy IDX_NCL_People_ID, zignoruje index nieklastrowy IDX_NCL_People_Country
-- logical reads 659
-- plan zapytania: IDX_NCL_People_ID scan
SELECT ID, FirstName, LastName FROM People WHERE Country = 'France'



-- uzyje index nieklastrowy IDX_NCL_People_Country
-- 84 logical reads
-- plan zapytania : IDX_NCL_People_Country + aggregate 
SELECT Country, COUNT(*)
FROM People
GROUP BY Country


/*
	NONCLUSTERED INDEX
	2nd
*/


-- DROP INDEX IDX_NCL_People_City ON People
CREATE NONCLUSTERED INDEX IDX_NCL_People_City ON People (City)
GO

--statytsyka indeksow dla tabeli People
-- 3 indeksy:
-- IDX_CL_People_ID CLUSTERED
-- IDX_NCL_People_Country NONCLUSTERED
-- IDX_NCL_People_City NONCLUSTERED
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')


-- index_id = 5 pokazuje id indeksu dla IDX_NCL_People_City
SELECT index_id FROM sys.indexes WHERE name = 'IDX_NCL_People_City'

-- rozmiar indeksu: 74 strony
-- DB_ID() - aktualna baza danych
-- OBJECT_ID('People') tabela People
-- 5 index_id
SELECT page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),5,NULL,'LIMITED')


-- uzyto indeks IDX_NCL_People_City
-- 76 logical reads
-- plan zapytania : IDX_NCL_People_City scan + aggregate + sort 
SELECT City, COUNT(*)
FROM People
GROUP BY City
ORDER BY count(*) DESC


-- zwroci 30 rekordow
-- 30 row x 3 poziomy = 90 + kilka stron z klastra = 102 logical reads
-- oplacalo sie uzyc IDX_NCL_People_City
--  plan zapytania : IDX_NCL_People_City seek + nested loops doczytanie danych z Key Lookup klastrowanego  (IDX_NCL_People_ID)
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'Croix'

-- zwroci 420 rekordow
-- 420 row x 3 poziomy = 1260 logical reads
-- lepiej uzyc indeksu klastrowanego IDX_NCL_People_ID (659 logical reads)
-- NIE uzyto IDX_NCL_People_City, a uzyto IDX_NCL_People_ID scan
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'London'

--wymuszenie uzycia IDX_NCL_People_City
-- odczytano 1300 logical reads
SELECT ID, FirstName, LastName 
FROM People WITH (INDEX (IDX_NCL_People_City))
WHERE City = 'London'




/*
	NONCLUSTERED INDEX
	INCLUDE - opcja tylko przy indeksch nieklastrowych

	mozna powiedziec ze w indeksach klastrowych opcja jest domyslna
*/

-- DROP INDEX IDX_NCL_People_City ON People
CREATE NONCLUSTERED INDEX IDX_NCL_People_City ON People (City)
INCLUDE (Firstname, Lastname)
WITH DROP_EXISTING -- !!!
GO

-- rozmiar indeksu: 74 -> 137 strony
-- przez uzycie include zwiekszylo  sie do 137 stron
SELECT page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),5,NULL,'LIMITED')


-- teraz uzyto IDX_NCL_People_City z include
-- logical reads 6
-- indeks pokrywajacy
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'London'


-- teraz uzyto IDX_NCL_People_City z include
-- logical reads 6
-- indeks pokrywajacy
--plan zpytania: IDX_NCL_People_City seek + sort
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'London'
ORDER BY Lastname, FirstName



--nowy indeks z kolumnami City, Lastname, Firstname
CREATE NONCLUSTERED INDEX IDX_NCL_People_City 
ON People (City, Lastname, Firstname)
WITH DROP_EXISTING -- !!!
GO


-- teraz uzyto IDX_NCL_People_City
-- dane sa juz posortowane w indeksie wiec nie trzeba ich sortowac w planie zapytania
-- logical reads 6
-- indeks pokrywajacy
-- plan zapytania: IDX_NCL_People_City seek , ale nie ma sort !!!
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'London'
ORDER BY Lastname, FirstName



-- teraz uzyto IDX_NCL_People_City ale uzyto sort (w planie zapytania)
-- logical reads 6
-- indeks pokrywajacy
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'London'
ORDER BY Lastname, FirstName DESC -- !!

SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'London'
ORDER BY FirstName,Lastname





/*
	RID LOOKUP vs KEY LOOKUP
	
*/


CREATE NONCLUSTERED INDEX IDX_NCL_People_City ON People (City)
WITH DROP_EXISTING -- !!!
GO

-- key lookup
-- uzyto IDX_NCL_People_City + nested loops doczytanie z KEY Lookup (indeks IDX_CL_People_ID)
-- logical reads 125

SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'Croix'

--usuwamy indeks sklastrowany
--nastepuje przebudowa i powstaje HEAP
DROP INDEX IDX_CL_People_ID ON People
GO

-- rid lookup
-- uzyto IDX_NCL_People_City + nested loops doczytanie z RID Lookup (HEAP)
-- logical reads 32
SELECT ID, FirstName, LastName 
FROM People 
WHERE City = 'Croix'



/*
	Kolejnosć kolumn w kluczu indeksu
	
*/

CREATE UNIQUE CLUSTERED INDEX IDX_CL_People_ID ON People (ID)
GO

--statytsyka indeksow dla tabeli People
-- 3 indeksy:
-- IDX_CL_People_ID CLUSTERED
-- IDX_NCL_People_Country NONCLUSTERED
-- IDX_NCL_People_City NONCLUSTERED
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')


CREATE NONCLUSTERED INDEX IDX_NCL_People_Lastname_Firstname ON People (Lastname, Firstname)
--WITH DROP_EXISTING -- !!!
GO

--statytsyka indeksow dla tabeli People
-- 4 indeksy:
-- IDX_CL_People_ID CLUSTERED
-- IDX_NCL_People_Country NONCLUSTERED
-- IDX_NCL_People_City NONCLUSTERED
-- IDX_NCL_People_Lastname_Firstname NONCLUSTERED
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')


--indeks sklastrowany 659 logical reads 
SELECT * FROM People

--indeks niesklastrowany IDX_NCL_People_Lastname_Firstname
-- logical reads 8
--plan zpytania: IDX_NCL_People_Lastname_Firstname + nested loops

SELECT * FROM People
WHERE LastName = 'Sánchez' AND FirstName = 'Ken'

SELECT * FROM People
WHERE FirstName = 'Ken' AND LastName = 'Sánchez'


SELECT * FROM People
WHERE LastName = 'Sánchez' AND FirstName LIKE 'K%'

--indeks niesklastrowany IDX_NCL_People_Lastname_Firstname
-- logical reads 17
--plan zpytania: IDX_NCL_People_Lastname_Firstname seek + nested loops
SELECT * FROM People
WHERE LastName = 'Sánchez' 


--indeks niesklastrowany scan IDX_NCL_People_Lastname_Firstname + nested loops
-- w planie zapytania pogrubiona strzalka odczytac musial  18 744 rekordy , a tylko 3 pokazal
-- logical reads 102
--plan zpytania: IDX_NCL_People_Lastname_Firstname scan + nested loops
SELECT * FROM People
WHERE FirstName = 'Ken'

--indeks niesklastrowany IDX_NCL_People_Lastname_Firstname
-- logical reads 17
-- dane juz posortowane, nie ma w planie zapytania sorta
--plan zapytania: IDX_NCL_People_Lastname_Firstname seek + nested loops
SELECT * FROM People
WHERE LastName = 'Sánchez' 
ORDER BY FirstName



--indeks niesklastrowany IDX_NCL_People_Lastname_Firstname
-- logical reads 13
--plan zpytania: IDX_NCL_People_Lastname_Firstname seek + nested loops

SELECT * FROM People
WHERE LastName = 'Sánchez' AND FirstName IN ('Cesar', 'Ken')


-- Number of Rows Read, Actual number of Rows
-- "Missing index"
-- indeks niesklastrowany IDX_NCL_People_Lastname_Firstname + nested loops
-- w planie zapytania pogrubiona strzalka odczytac musial  2 058 rekordy , a tylko 2 pokazal
-- logical reads 19
--plan zpytania: IDX_NCL_People_Lastname_Firstname seek + nested loops
SELECT * FROM People 
WHERE LastName LIKE 'S%' AND FirstName = 'Ken'

-- 2058 rekordow
-- indeks klastrowy IDX_CL_People_ID 
-- logical reads 659
SELECT * FROM People 
WHERE LastName LIKE 'S%' 



/*
	Porządek sortowanie kolumn 
	
*/

--zmiana indeksu IDX_NCL_People_Lastname_Firstname oparta tylko na Lastname
CREATE NONCLUSTERED INDEX IDX_NCL_People_Lastname_Firstname ON People (Lastname)
WITH DROP_EXISTING

-- indeks niesklastrowany IDX_NCL_People_Lastname_Firstname scan
-- logical reads 61
-- plan zapytania IDX_NCL_People_Lastname_Firstname scan , nie ma operatora sort
SELECT ID FROM People
ORDER BY LastName

SELECT ID FROM People
ORDER BY LastName DESC


--zmiana indeksu IDX_NCL_People_Lastname_Firstname oparta  na Lastname, Firstname
CREATE NONCLUSTERED INDEX IDX_NCL_People_Lastname_Firstname ON People (Lastname, Firstname)
WITH DROP_EXISTING


-- indeks niesklastrowany IDX_NCL_People_Lastname_Firstname
-- logical reads 93
-- plan zapytania IDX_NCL_People_Lastname_Firstname scan , nie ma operatora sort
SELECT ID FROM People
ORDER BY LastName, FirstName

-- indeks niesklastrowany IDX_NCL_People_Lastname_Firstname
-- w planie zapytania dodatkowo operator sort
-- logical reads 93
SELECT ID FROM People
ORDER BY LastName, FirstName DESC


SELECT ID FROM People
ORDER BY LastName DESC, FirstName

