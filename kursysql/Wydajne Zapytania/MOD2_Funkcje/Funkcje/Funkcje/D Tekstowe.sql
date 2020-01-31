/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	FUNKCJE
	D: Tekstowe

*/



SELECT '     Pięć spacji z przodu'

SELECT LTRIM('     Pięć spacji z przodu')
SELECT RTRIM('Pięć spacji z tyłu     ')

SELECT RTRIM(LTRIM('     Pięć spacji z przodu i z tyłu  '))

-- SQL Server 2017+
SELECT TRIM('     Pięć spacji z przodu i z tyłu  ')


-- CHARINDEX ( expressionToFind ,expressionToSearch [ , start_location ] )
SELECT CHARINDEX('@', 'kontakt@kursysql.pl')
SELECT CHARINDEX('.', 'kontakt@kursysql.pl')
SELECT CHARINDEX('Q', 'kontakt@kursysql.pl')


-- pierwsza kropka w domenie
SELECT CHARINDEX('.', 'test.kontakt@kursysql.pl', CHARINDEX('@', 'test.kontakt@kursysql.pl'))


-- SUBSTRING ( expression ,start , length )
SELECT SUBSTRING('kontakt@kursysql.pl', 2, 3)


-- tylko domena
SELECT SUBSTRING(
	'kontakt@kursysql.pl', 
	CHARINDEX('@', 'kontakt@kursysql.pl')+1, 
	CHARINDEX('@', REVERSE('kontakt@kursysql.pl'))
	) 


SELECT REVERSE('kontakt@kursysql.pl')



SELECT REVERSE('SQL Server')


SELECT REVERSE('zaraz') AS palindrom1
SELECT REVERSE('kajak') AS palindrom2

SELECT REVERSE('Może jutro ta dama da tortu jeżom') AS palindrom3





-- STUFF ( character_expression , start , length , replaceWith_expression )
--  inserts a string into another string

SELECT STUFF('abcdef', 2, 3, 'ijklmn')


USE AdventureWorks2017
GO


SELECT *
FROM Production.ProductCategory 


SELECT ', ' + Name 
FROM Production.ProductCategory FOR XML PATH ('')

SELECT STUFF((SELECT ', ' + Name 
FROM Production.ProductCategory FOR XML PATH ('')), 1, 2, '') AS CategoriesList

-- SQL Server 2017+
SELECT STRING_AGG(Name, ', ') AS CategoriesList
FROM Production.ProductCategory

-- SQL Server 2017+
-- STRING_SPLIT - "odwrotność" funkcji STRING_AGG
SELECT * FROM STRING_SPLIT('Chisel Epic Epic EVO Epic FSR Epic Hardtail Riprock', ' ')
GO


-- REPLICATE ( string_expression ,integer_expression ) 

SELECT REPLICATE('sql-', 300)

SELECT LEN(REPLICATE('sql-', 300))





-- REPLACE ( string_expression , string_pattern , string_replacement )
SELECT REPLACE('abcdefghicde','cde','XXXXX')






SELECT  DATALENGTH(  'Ala ma kota' ) , 
	DATALENGTH( N'Ala ma kota' ) as DataLen,
	LEN (  'Ala ma kota' ) as ASCIILen, 
	LEN ( N'Ala ma kota' ) as UNICODELen

