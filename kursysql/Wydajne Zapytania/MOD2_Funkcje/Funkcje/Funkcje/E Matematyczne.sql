/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	FUNKCJE
	E: Matematyczne

*/



USE AdventureWorks2017
GO

-- zaokrąglanie
SELECT CAST(ROUND(ListPrice, 0) AS int), ListPrice, * 
FROM Production.Product WHERE ListPrice <> 0

-- zaokrąglanie w dół
SELECT FLOOR(ListPrice), ListPrice, * FROM Production.Product WHERE ListPrice <> 0

-- zakrąglanie w górę
SELECT CEILING(ListPrice), ListPrice, * FROM Production.Product WHERE ListPrice <> 0




SELECT RAND()


-- przedział 10 - 20
SELECT 10 + CONVERT(INT, (20-10+1) * RAND())
-- Przedział 0-10
SELECT 0 + CONVERT(INT, (10-0+1) * RAND())

-- deterministyczna
SELECT 
	RAND(), 
	10 + CONVERT(INT, (20-10+1) * RAND()), 
	* 
FROM Person.Person

SELECT 
	RAND(), 
	10 + CONVERT(INT, (20-10+1) * RAND()), 
	RAND(CHECKSUM(NEWID())), 
	10 + CONVERT(INT, (20-10+1) * RAND(CHECKSUM(NEWID()))), 
	* 
FROM Person.Person





