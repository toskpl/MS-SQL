/*
	KursySQL.pl

	TWORZENIE OGRANICZEŃ
	B: NOT NULL
*/

USE BazaFilmy
GO

-- Sprawdzenie które kolumny nie mogą zawierać NULL

sp_help 'Film' -- Nullable
GO


SELECT * 
FROM sys.columns AS c
JOIN sys.tables AS t ON t.object_id = c.object_id
WHERE t.name = 'Film' AND c.is_nullable = 1


SELECT * FROM Film WHERE OpisFilmu IS NULL

-- !
ALTER TABLE Film ALTER COLUMN OpisFilmu nvarchar(500) NOT NULL


UPDATE Film SET OpisFilmu = '' WHERE OpisFilmu IS NULL


-- teraz się uda
ALTER TABLE Film ALTER COLUMN OpisFilmu nvarchar(500) NOT NULL


-- można zmieniać także za pomocą diagramów




