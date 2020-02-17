/*
	KursySQL.pl

	TWORZENIE OGRANICZEŃ
	C: UNIQUE
*/




/* Kilka sposobów tworzenia */


-- podczas tworzenia tabeli
CREATE TABLE Film2 (
  ID int PRIMARY KEY IDENTITY,
  Tytul nvarchar(100) UNIQUE,
  KrajID int,
  PremieraData date ,
  OpisFilmu nvarchar(500) 
)
GO


SELECT * FROM sys.objects 
WHERE parent_object_id = OBJECT_ID('Film2')

SELECT * FROM sys.key_constraints 
WHERE parent_object_id = OBJECT_ID('Film2')


ALTER TABLE Film2 DROP CONSTRAINT UQ__Film2__C01AE43FB19AED27

-- kolumna  is_system_named
SELECT * FROM sys.key_constraints 
WHERE parent_object_id = OBJECT_ID('Film2')

-- modyfikując tabelę
ALTER TABLE Film2 ADD CONSTRAINT UQ_Film2_Tytul UNIQUE (Tytul)

-- modyfikująca tebalę ver.2
ALTER TABLE Film ADD UNIQUE (Tytul)
GO


-- kolumna is_system_named
SELECT * FROM sys.key_constraints 
WHERE parent_object_id = OBJECT_ID('Film2')



SELECT * FROM Film2


INSERT INTO Film2 (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Star Wars', 1, '20191219', NULL)

-- !
INSERT INTO Film2 (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Star Wars', 1, '20191219', NULL)

-- NULL się uda
INSERT INTO Film2 (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES (NULL, 1, '20191219', NULL)

-- ... ale tylko raz
INSERT INTO Film2 (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES (NULL, 1, '20191219', NULL)



/* Jedna kolumna czy dwie */



SELECT * FROM Film

sp_help 'Film'


ALTER TABLE Film ADD CONSTRAINT UQ_Film_Tytul UNIQUE (Tytul)



SELECT * FROM sys.key_constraints WHERE parent_object_id = OBJECT_ID('Film')



-- jak sprawdzić, która kolumna?
SELECT c.*
FROM sys.indexes AS i
JOIN sys.index_columns AS ic ON i.index_id = ic.index_id AND i.object_id = ic.object_id
JOIN sys.columns AS c ON c.column_id = ic.column_id AND c.object_id = i.object_id
WHERE i.object_id = OBJECT_ID('Film') AND i.is_unique_constraint = 1


SELECT * FROM sys.key_constraints WHERE name = 'UQ_Film_Tytul'
SELECT * FROM sys.indexes WHERE name = 'UQ_Film_Tytul'



SELECT * FROM Film


INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Joker', 2, '20150114', 'Uzależniony od hazardu ochroniarz Nick Wild wykorzystuje zabójcze umiejętności, aby pomścić pobitą przez mafioza przyjaciółkę')



ALTER TABLE Film DROP CONSTRAINT UQ_Film_Tytul 



ALTER TABLE Film ADD CONSTRAINT UQ_Film_Tytul UNIQUE (Tytul, PremieraData)

SELECT c.*
FROM sys.indexes AS i
JOIN sys.index_columns AS ic ON i.index_id = ic.index_id AND i.object_id = ic.object_id
JOIN sys.columns AS c ON c.column_id = ic.column_id AND c.object_id = i.object_id
WHERE i.object_id = OBJECT_ID('Film') AND i.is_unique_constraint = 1


INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Joker', 2, '20150114', 'Uzależniony od hazardu ochroniarz Nick Wild wykorzystuje zabójcze umiejętności, aby pomścić pobitą przez mafioza przyjaciółkę')



SELECT * FROM Film



