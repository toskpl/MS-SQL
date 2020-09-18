/*

	RODZAJE INDEKSÓW
	F: Brakujące i nieużywane indeksy

*/

--> Setup

USE AdventureWorks2017


/*

	sys.indexes
	sys.index_columns

*/
/*pokazuje indeksy na tabeli People*/

SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')

/*
2 indeksy
*/

CREATE UNIQUE CLUSTERED INDEX CL_People ON People (ID) 
CREATE NONCLUSTERED INDEX IDX_People_Country ON People (Country, City) 

SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')


SELECT * FROM sys.index_columns

/*pokazuje kolumny zaindeksowane na tabeli People
index_id - id indeksu
index_column_id -  id kolumny indeksu
column_id - id kolumny
*/

SELECT * FROM sys.index_columns AS ic
WHERE ic.object_id = OBJECT_ID('People')

SELECT * FROM sys.index_columns AS ic
WHERE ic.object_id = OBJECT_ID('People') AND ic.index_id = 2

/*pokazuje nazwy kolumn zaindeksowanych na tabeli People*/
SELECT * FROM sys.index_columns AS ic
JOIN sys.columns AS c ON c.object_id = ic.object_id AND ic.column_id = c.column_id
WHERE ic.object_id = OBJECT_ID('People') AND ic.index_id = 2 







/*

	sys.dm_db_index_usage_stats

	statystyki użycia kiedy i ile razy uzyto indeks

	statystka resetowana przy restarcie serwera MS SQL

	tylko dla uzywanych indeksów sa informacje
*/


SELECT * FROM sys.dm_db_index_usage_stats

SELECT DB_NAME(database_id), * FROM sys.dm_db_index_usage_stats

/*
user_seek - ile razy przeszukiwany
user_scans - ile razy skanowany
user_lookups - ile razy doczytywano dane
user_update - ile razy byl aktualizowany indeks
*/

SELECT 
	DB_NAME(database_id), 
	OBJECT_NAME(object_id), * 
FROM sys.dm_db_index_usage_stats
WHERE DB_NAME(database_id) = 'AdventureWorks2017'

SELECT * FROM sys.indexes

/*
idx_name - nazwa indeksu
*/

SELECT 
	OBJECT_NAME(idx_usage.object_id) AS table_name, 
	idx.name AS idx_name,
	*
FROM sys.dm_db_index_usage_stats AS idx_usage
JOIN sys.indexes AS idx ON idx.object_id = idx_usage.object_id AND idx.index_id = idx_usage.index_id
WHERE database_id = DB_ID()
ORDER BY table_name, idx_usage.index_id



-- People idxs stats
/*
user_seek = 0- ile razy przeszukiwany
user_scans = 0 - ile razy skanowany
user_lookups = 0- ile razy doczytywano dane
user_update = 0 - ile razy byl aktualiznowany indeks
*/
SELECT idx.name AS idx_name, *
FROM sys.dm_db_index_usage_stats AS idx_usage
JOIN sys.indexes AS idx ON idx.object_id = idx_usage.object_id AND idx.index_id = idx_usage.index_id
WHERE database_id = DB_ID() AND OBJECT_NAME(idx_usage.object_id) = 'People'
ORDER BY idx_usage.index_id


SELECT * FROM People --scan
SELECT * FROM People WHERE ID = 1   --seek
SELECT * FROM People WHERE ID = 111 --seek
SELECT * FROM People WHERE ID = 112 --seek


-- People idxs stats
/*
user_seek = 3- ile razy przeszukiwany
user_scans = 1 - ile razy skanowany
user_lookups = 0- ile razy doczytywano dane
user_update = 0 - ile razy byl aktualiznowany indeks
*/
SELECT idx.name AS idx_name, idx_usage.*
FROM sys.dm_db_index_usage_stats AS idx_usage
JOIN sys.indexes AS idx ON idx.object_id = idx_usage.object_id AND idx.index_id = idx_usage.index_id
WHERE database_id = DB_ID() AND OBJECT_NAME(idx_usage.object_id) = 'People'
ORDER BY idx_usage.index_id


SELECT * FROM People WHERE Country = 'France' AND City = 'Croix' --seek


SELECT idx.name AS idx_name, idx_usage.*
FROM sys.dm_db_index_usage_stats AS idx_usage
JOIN sys.indexes AS idx ON idx.object_id = idx_usage.object_id AND idx.index_id = idx_usage.index_id
WHERE database_id = DB_ID() AND OBJECT_NAME(idx_usage.object_id) = 'People'
ORDER BY idx_usage.index_id





/*

	sys.dm_db_missing_index_details
	przechowuje informacje o proponowanych indeksach przez MS SQL (zielony komentarz)
*/

SELECT * FROM sys.dm_db_missing_index_details


SELECT ID, FirstName, LastName FROM People WHERE City = 'Minneapolis'


SELECT ID, FirstName, LastName FROM People WHERE City = 'Minneapolis'


SELECT * FROM sys.dm_db_missing_index_details


SELECT * 
FROM sys.dm_db_missing_index_details AS miss_idx
WHERE object_id = OBJECT_ID('People')



SELECT * FROM sys.dm_db_missing_index_group_stats


SELECT * FROM sys.dm_db_missing_index_groups

/*informacje o indeksach na podstawie danych systemowych*/

SELECT
	d.name AS database_name,
	mid.statement AS table_name,
	mid.equality_columns,
	mid.inequality_columns,
	mid.included_columns,
	migs.last_user_seek,
	migs.avg_total_user_cost,
	migs.avg_user_impact,
	migs.user_seeks,
	migs.user_scans
FROM sys.dm_db_missing_index_groups AS mig
INNER JOIN sys.dm_db_missing_index_group_stats AS migs ON migs.group_handle = mig.index_group_handle
INNER JOIN sys.dm_db_missing_index_details AS mid ON mig.index_handle = mid.index_handle
INNER JOIN sys.databases AS d ON d.database_id = mid.database_id
WHERE d.name = 'AdventureWorks2017'




-- sugerowany indeksy potrafią być bardzo duże
SELECT * FROM People WHERE City = 'Minneapolis'


/*
MS SQL podpowiada aby dodac wszystkie kolumny - przez co indeks jest "rozdmuchany"
*/
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[People] ([City])
--INCLUDE ([PersonType],[Title],[FirstName],[MiddleName],[LastName],[EmailPromotion],[rowguid],[ModifiedDate],[EmailAddress],[AddressTypeID],[AddressType],[AddressLine1],[AddressLine2],[PostalCode],[RegionName],[Country],[BirthDate],[Gender],[MaritalStatus])
--GO







/*

	sys.dm_db_index_physical_stats

*/
-- tryb DETAILED = dotyczy wszystkich poziomow indeksu 
---index_depth - glebokosc indeksu
-- index_level - poziom zaglebienia 0,1,2

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),NULL,NULL,'DETAILED')

SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Production.Product')

--dotyczy tylko lisci indeksu
SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('Production.Product'),1,NULL,'LIMITED')
SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('Production.Product'),NULL,NULL,DEFAULT)

--tryb SAMPLED pokazuje wszystkie wartosci w kolumnach - jest to TYLKO próbka danych
-- dotyczy tylko lisci indeksu 
SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('Production.Product'),1,NULL,'SAMPLED')

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('Production.Product'),1,NULL,'DETAILED')


/*

Ostatni parametr - MODE - poziom szczegółowości zwracanych danych, wpływa na wydajność (czas) funkcji

LIMITED/ DEFAULT - 12 kolumn, najszybszy tryb, skanuje tylko poziom liści indeksów

SAMPLED - 21 kolumn, szacowana wartość compressed_page_count, 
	statystyki na podstawie próbki 1% stron w indeksie/ stercie
	W przypadku indeksów mniejszych niż 10 000 stron - używany jest tryb DETAILED

DETAILED - 21 kolumn, skanuje wszystkie strony indeksu i wszystkie statystyki

*/






