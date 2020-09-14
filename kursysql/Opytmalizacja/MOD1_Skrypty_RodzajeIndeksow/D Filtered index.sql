/*

	RODZAJE INDEKSÓW
	D: Indeks filtrujący

*/



USE AdventureWorks2017
GO

-- > Setup

--stworzenie indeksow:
-- IDX_CL_People_ID CLUSTERED
-- IDX_NCL_People_Country NONCLUSTERED
-- IDX_NCL_People_City NONCLUSTERED
CREATE CLUSTERED INDEX IDX_CL_People_ID ON People (ID)
GO

CREATE NONCLUSTERED INDEX IDX_NCL_People_Country ON People (Country)
GO

CREATE NONCLUSTERED INDEX IDX_NCL_People_City ON People (City)
GO




SELECT * FROM People


--selektywnosc kolumny PersonType
SELECT PersonType, count(*) 
FROM People 
GROUP BY PersonType

--selektywnosc kolumny EmailPromotion
SELECT EmailPromotion, count(*) 
FROM People 
GROUP BY EmailPromotion



SET STATISTICS IO ON

-- uzyto IDX_CL_People_ID CLUSTERED
-- logical reads 662
-- plan zapytania: IDX_CL_People_ID scan

SELECT ID, FirstName, LastName
FROM People 
WHERE Country = 'United States' AND EmailPromotion = 2



-- wymuszenie indeksu IDX_NCL_People_Country
-- logical reads 24 867
-- plan zapytania: IDX_NCL_People_Country seek + nested loops Key Loopkup (IDX_CL_People_ID)
SELECT ID, FirstName, LastName
FROM People WITH (INDEX (IDX_NCL_People_Country))
WHERE Country = 'United States' AND EmailPromotion = 2 



-- indeks IDX_NCL_People_Country_EmailPromotion NONCLUSTERED
-- opcja INCLUDE
-- indeks filtrowany po EmailPromotion = 1

-- DROP INDEX IDX_NCL_People_Country_EmailPromotion  ON People
CREATE NONCLUSTERED INDEX IDX_NCL_People_Country_EmailPromotion
ON People (Country)
INCLUDE (Firstname, Lastname)
WHERE EmailPromotion = 1
WITH DROP_EXISTING
GO

-- uzyto IDX_NCL_People_Country_EmailPromotion NONCLUSTERED
-- logical reads 21
-- plan zapytania: IDX_NCL_People_Country_EmailPromotion seek
SELECT ID, FirstName, LastName
FROM People 
WHERE Country = 'United States'  AND EmailPromotion = 1



-- uzyto IDX_CL_People_ID CLUSTERED
-- logical reads 663
-- IDX_NCL_People_Country_EmailPromotion nie uzyto bo ma filtr na EmailPromotion = 1
-- plan zapytania: IDX_CL_People_ID scan
SELECT ID, FirstName, LastName
FROM People 
WHERE Country = 'United States'  AND EmailPromotion = 2



SELECT * FROM People
GO

-- ! Incorrect syntax near the keyword 'with'. If this statement is a common table expression [..]
-- NIE działa warnek OR
CREATE NONCLUSTERED INDEX IDX_NCL_People_EmailPromotion
ON People (EmailPromotion)
INCLUDE (Firstname, Lastname)
WHERE (EmailPromotion = 1 OR EmailPromotion = 2)
WITH DROP_EXISTING
GO


--dziala operator IN
CREATE NONCLUSTERED INDEX IDX_NCL_People_EmailPromotion
ON People (EmailPromotion)
INCLUDE (Firstname, Lastname)
WHERE (EmailPromotion) IN (1, 2)
WITH DROP_EXISTING

--uzyto IDX_NCL_People_EmailPromotion NONCLUSTERED
-- logical reads 52
-- plan zapytania IDX_NCL_People_EmailPromotion seek
SELECT FirstName, LastName
FROM People 
WHERE EmailPromotion IN (1,2)

--uzyto IDX_NCL_People_EmailPromotion NONCLUSTERED
-- logical reads 29
-- plan zapytania IDX_NCL_People_EmailPromotion seek
SELECT FirstName, LastName
FROM People 
WHERE EmailPromotion = 1

-- uzyto IDX_CL_People_ID CLUSTERED
-- logical reads 663
-- IDX_NCL_People_Country_EmailPromotion nie uzyto bo ma filtr na EmailPromotion IN (1,2)
-- plan zapytania: IDX_CL_People_ID scan
SELECT FirstName, LastName
FROM People 
WHERE EmailPromotion = 3


