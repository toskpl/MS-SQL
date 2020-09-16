/*
	
	RODZAJE INDEKSÓW
	E: Fragmentacja

*/

USE AdventureWorks2017
GO

--> Setup 

/*
  HEAP
*/

SELECT * FROM People

--HEAP
--pamatery funkcji dm_db_index_physical_stats:
-- DB_ID() baza danych
-- OBJECT_ID('People') tabela People
-- NULL - wszystkie indkesy
-- NULL,
--'DETAILED' - tryb uruchomienia

--result:HEAP	
--pages_count 657
--record_count: 18774
--forwarded_record_count 0
SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),NULL,NULL,'DETAILED')



--licznosc AddressLine2
SELECT LEN(AddressLine2), count(*)
FROM People
GROUP BY LEN(AddressLine2)
ORDER BY 2 DESC

--SELECT CONVERT(varchar(255), NEWID())
--Symulacja fragmentacji 

--
--CASE 1
--tabela jako HEAP uruchamiamy pelte
--trwala ona ponad 160 sek (2min 40 sek)
SET NOCOUNT ON;

DECLARE @i int = 0;

WHILE @i < 10000 BEGIN
	UPDATE People SET AddressLine2 = CONCAT(AddressLine2, ' ', CONVERT(varchar(255), NEWID()))
	WHERE ID = @i

	IF @i % 100 = 0 PRINT @i;
  SET @i += 1;
  --SET @i = @i + 1;
END;
GO

SELECT * FROM People


--result:HEAP	
--pages_count 752
--record_count: 20996
--forwarded_record_count 2222
SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),NULL,NULL,'DETAILED')



--przebudowa HEAP i pozbycie sie fragemntacji
ALTER TABLE dbo.People REBUILD;


--result:HEAP	
--pages_count 747
--record_count: 18774
--forwarded_record_count 0

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),NULL,NULL,'DETAILED')


/*
  CLUSTERED INDEX
*/


-- > Setup

--CASE 2
--tabela z indeksem klastrowym i uruchamiamy pelte
--trwala ok 1 sek 

ALTER TABLE People ADD CONSTRAINT PK_People PRIMARY KEY (ID)

--sprawdzenie fragmentacji

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),NULL,NULL,'DETAILED')
GO
/*
--result:CLUSTERED INDEX about index_depth: 3	
-- index_level:0	avg_fragmentation_in_percent:19,26	pages_count:655
-- index_level:1	avg_fragmentation_in_percent:1	    pages_count:2
-- index_level:2	avg_fragmentation_in_percent:1	    pages_count:1
*/


SET STATISTICS IO OFF

SET NOCOUNT ON;

DECLARE @i int = 0;

WHILE @i < 10000 BEGIN
	UPDATE People SET AddressLine2 = CONCAT(AddressLine2, ' ', CONVERT(varchar(255), NEWID()))
	WHERE ID = @i

	IF @i % 100 = 0 PRINT @i;
  SET @i += 1;
END;
GO

--sprawdzenie fragmentacji

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),NULL,NULL,'DETAILED')

/*
--result:CLUSTERED INDEX about index_depth:3
--index_level:0	avg_fragmentation_in_percent:69,86	pages_count:655
--index_level:1	avg_fragmentation_in_percent:66,66	pages_count:3
--index_level:2	avg_fragmentation_in_percent:0	    pages_count:1
*/


--reogranizacja tabeli
--REBUILD blokuje dostep do tabeli !!! (w transakcji)

ALTER INDEX ALL ON People REBUILD

-- BOL: When ALL is specified, all indexes 
--		on the table are dropped and rebuilt in a single transaction
-- https://docs.microsoft.com/en-us/sql/relational-databases/indexes/reorganize-and-rebuild-indexes




SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),NULL,NULL,'DETAILED')

/*
--result:CLUSTERED INDEX about index_depth:3 
--index_level:0	avg_fragmentation_in_percent:0,93	pages_count:747 avg_page_space_used_in_precent: 97,8475908080059 
--index_level:1	avg_fragmentation_in_percent:100	pages_count:3   avg_page_space_used_in_precent: 39,9678774400791
--index_level:2	avg_fragmentation_in_percent:0	    pages_count:1   avg_page_space_used_in_precent: 0,457128737336299
*/




/*

  REORGANIZE

*/

--ALTER INDEX ALL ON People REORGANIZE

--REORGANIZE NIE blokuje dostep do tabeli !!! (trwa dluzej niż BUILD)
ALTER INDEX PK_People ON People REORGANIZE


SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),NULL,NULL,'DETAILED')

/*
	avg_fragmentation_in_percent: 0,402684563758389
	page_count: 746
*/


/*
  FILL FACTOR - stopien zapelnieani stion - default = 0, pages are in 100% fill
*/

SET STATISTICS IO ON

-- 751 reads (CI scan)
SELECT * FROM People WHERE Country = 'France'


SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')

--przebudowa z opcja FILLFACTOR
ALTER INDEX PK_People ON People
REBUILD WITH (FILLFACTOR = 70)
GO  

-- 1021 reads (CI scan)
SELECT * FROM People WHERE Country = 'France'



--> Setup
--CASE 3
--tabela z indeksem klastrowym fill factor 70% i uruchamiamy pelte
--trwala ok 1 sek 
SET STATISTICS IO ON
ALTER TABLE People ADD CONSTRAINT PK_People PRIMARY KEY (ID)
GO
-- logical reads 660
SELECT * FROM People WHERE Country = 'France'


ALTER INDEX PK_People ON People
REBUILD WITH (FILLFACTOR = 70)
GO  

-- logical reads 902
SELECT * FROM People WHERE Country = 'France'

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),NULL,NULL,'DETAILED')

/*
--result:CLUSTERED INDEX about index_depth:3
--index_level:0	avg_fragmentation_in_percent:0,78	pages_count:896 avg_page_space_used_in_precent: 71,36
--index_level:1	avg_fragmentation_in_percent:100	pages_count:4   avg_page_space_used_in_precent: 35,95
--index_level:2	avg_fragmentation_in_percent:0	    pages_count:1   avg_page_space_used_in_precent: 0,61
*/


--> WHILE @i < 10000 BEGIN ...

SET STATISTICS IO OFF

SET NOCOUNT ON;

DECLARE @i int = 0;

WHILE @i < 10000 BEGIN
	UPDATE People SET AddressLine2 = CONCAT(AddressLine2, ' ', CONVERT(varchar(255), NEWID()))
	WHERE ID = @i

	IF @i % 100 = 0 PRINT @i;
  SET @i += 1;
END;
GO


SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),NULL,NULL,'DETAILED')

/*
--result:CLUSTERED INDEX about index_depth:3
--index_level:0	avg_fragmentation_in_percent:0,78	pages_count:896  avg_page_space_used_in_precent: 81,57
--index_level:1	avg_fragmentation_in_percent:100	pages_count:4    avg_page_space_used_in_precent: 35,95
--index_level:2	avg_fragmentation_in_percent:0	    pages_count:1    avg_page_space_used_in_precent: 0,61
*/
