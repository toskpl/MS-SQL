/*
	RODZAJE INDEKSÓW
	B: Sterta vs indeks klastrowy

*/

--> Setup


USE AdventureWorks2017
GO

-- 18 798 wierszy
-- Execution Plan = Ctrl + M
SELECT * FROM People



--pokazuje statstyki 
--rows - ile wierszy
--reserved - ile zajmuje tabela
--data - ile zajmuja dane
--index_size - ile zajmuje index (sterta zawiera IAM (index allocation map - 8KB) )
--inused - przestrzen na nowe dane nieuzywana ale zarezerwoana
EXEC sp_spaceused 'People'
GO

/*
	HEAP
	tabela jako sterta 
*/

--type_desc = HEAP index jako sterta
--index_id = 0
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')
GO


SET STATISTICS IO ON
GO

-- 656 logical reads
SELECT * FROM People

--CHECKPOINT
--DBCC DROPCLEANBUFFERS

SELECT * FROM People WHERE FirstName = 'Kevin'

SELECT * FROM People WHERE Country = 'France'

SELECT * FROM People WHERE ID = 1771

SELECT * FROM People ORDER BY ID



/*
	CLUSTERED INDEX
	
*/

-- DROP INDEX IDX_CL_People_ID ON People
CREATE CLUSTERED INDEX IDX_CL_People_ID ON People (ID)
GO


DROP INDEX IDX_CL_People_ID ON People
GO

-- klastrowy, unikalny
CREATE UNIQUE CLUSTERED INDEX IDX_CL_People_ID ON People (ID)
GO

--type_desc = CLUSTERED index
--index_id = 1
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')

--index_size wikesze 96KB
EXEC sp_spaceused 'People'


-- 658 logical reads
SELECT * FROM People

--rak operarora sortowania - bo index juz ma posortowane dane
SELECT * FROM People ORDER BY ID 

SELECT * FROM People WHERE FirstName = 'Kevin'

SELECT * FROM People WHERE Country = 'France'

--logical reads 3
SELECT * FROM People WHERE ID = 1771






/*
	SSMS
	- Properties: General, Fragmentation, liczba stron: 
	- kasowanie, tworzenie indeksu

*/

-- wyłączenie indeksu
ALTER INDEX IDX_CL_People_ID ON People DISABLE
GO

-- ! bald bo index wylaczony
SELECT * FROM People

-- przebudowa = włączenie
ALTER INDEX IDX_CL_People_ID ON People REBUILD
GO



SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')



-- sprawdzanie rozmiaru indeksu (poziom liści): 650 strony
SELECT page_count FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('People'),1,NULL,DEFAULT)



--! The operation failed because an index [...] already exists on table 'People'.
CREATE UNIQUE CLUSTERED INDEX IDX_CL_People_ID ON People (EmailAddress)
GO

-- zmiana istniejącego indeksu WITH DROP_EXISTING 

CREATE UNIQUE CLUSTERED INDEX IDX_CL_People_ID ON People (EmailAddress)
WITH DROP_EXISTING 
GO



/*
	IGNORE_DUP_KEY 
	
*/


SELECT TOP 6 ID, FirstName, LastName INTO People2
FROM People ORDER BY ID -- 18 774 wierszy

SELECT *FROM People2

CREATE UNIQUE CLUSTERED INDEX IDX_CL_People2_ID ON People2 (ID)


-- ignore_dup_key 0
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People2')

SELECT * FROM People2 -- 6 wierszy


-- error duplicate key row all transaction ends error
INSERT INTO People2 (ID, FirstName, LastName) VALUES 
	('1', 'Michael', 'Sullivan'),
	('2', 'David', 'Bradley'),
	('3', 'Margie', 'Shoop'),
	('100', 'Annik', 'Stahl')

SELECT * FROM People2 -- 6 wierszy


--enable option IGNORE_DUP_KEY

CREATE UNIQUE CLUSTERED INDEX IDX_CL_People2_ID ON People2 (ID) 
WITH (DROP_EXISTING = ON, IGNORE_DUP_KEY = ON)
GO

-- ignore_dup_key 1
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People2')


SELECT * FROM People2 -- 6 wierszy


-- not error duplicate key row all transaction ends only warrning
INSERT INTO People2 (ID, FirstName, LastName) VALUES 
	('1', 'Michael', 'Sullivan'),
	('2', 'David', 'Bradley'),
	('3', 'Margie', 'Shoop'),
	('100', 'Annik', 'Stahl')

SELECT * FROM People2 -- 7 wierszy






/*
	PRIMARY KEY = indeks unikalny (klastrowy) 
	
*/

-- jeśli istnieje już indeks klastrowy, to PK będzie indeksem nieklastrowym
ALTER TABLE People ADD CONSTRAINT PK_People PRIMARY KEY(ID)


SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')


DROP INDEX IDX_CL_People_ID ON People
GO

--  jeśli indeks został utworzony w wyniku utworzenia PK, trzeba skasować PK
--!  Cannot drop the index [..] It is being used for PRIMARY KEY constraint enforcement.
DROP INDEX PK_People ON People
GO

ALTER TABLE People DROP CONSTRAINT PK_People
GO




SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')

-- jeśli NIE istnieje indeks klastrowy, to PK będzie indeksem KLASTROWYM
ALTER TABLE People ADD CONSTRAINT PK_People PRIMARY KEY(ID)


SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('People')


ALTER TABLE People DROP CONSTRAINT PK_People
GO






-- SQL Server Best Practices Article : Clustered Indexes and Heaps + nonclustered
-- https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2005/administrator/cc917672(v=technet.10)



/*
	HEAP vs CLUSTERED INDEX
	
*/

DROP TABLE IF EXISTS People_heap 
DROP TABLE IF EXISTS People_ci 


SELECT * FROM People

--tabela HEAP
SELECT * INTO People_heap
FROM People WHERE 1=2


--tabela z indexem
SELECT * INTO People_ci
FROM People WHERE 1=2


--stworzenie indeksu dla People_ci
CREATE UNIQUE CLUSTERED INDEX IDX_CL_People_ID ON People_ci (ID)
GO


SET STATISTICS IO ON

INSERT INTO People_heap
SELECT * FROM People
-- Table 'People_heap'. Scan count 0, logical reads: 19423
GO

INSERT INTO People_ci
SELECT * FROM People
-- Table 'People_ci'. Scan count 0, logical reads 3309


--statystyki dla HEAP
--index size  8 KB
--reserved 5256 KB
EXEC sp_spaceused 'People_heap'


--statystyki dla index klastowsy
--index size 32 KB
--reserved 5448 KB
EXEC sp_spaceused 'People_ci'


