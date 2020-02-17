/*
	KursySQL.pl

	TWORZENIE OGRANICZEŃ
	D: PRIMARY KEY
*/



USE BazaFilmy
GO

SELECT * FROM Film
GO

EXEC sp_help 'Film'


SELECT * FROM sys.key_constraints WHERE parent_object_id = OBJECT_ID('Film')


--! nie uda się skasować klucza, jeśli jest FK, który wskazuje na ten klucz
ALTER TABLE Film DROP CONSTRAINT PK__Film__3214EC2752BC28C0
GO


ALTER TABLE FilmGatunek DROP CONSTRAINT FK__FilmGatun__IDFil__2B3F6F97


-- tym razem się udało
ALTER TABLE Film DROP CONSTRAINT PK__Film__3214EC2752BC28C0
GO


SELECT * FROM sys.key_constraints WHERE parent_object_id = OBJECT_ID('Film')



ALTER TABLE Film ADD CONSTRAINT PK_Film PRIMARY KEY (ID)
GO

/*

ALTER TABLE Film ADD PRIMARY KEY (ID)
GO

*/


SELECT * FROM sys.key_constraints WHERE parent_object_id = OBJECT_ID('Film')




-- PK można ustawiać także za pomocą diagramów i edytora (Design)


