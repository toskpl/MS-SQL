/*
	KursySQL.pl

	TWORZENIE OGRANICZEŃ
	G: DEFAULT
*/


--! Cannot insert the value NULL into column 'OpisFilmu',
INSERT INTO Film (Tytul, KrajID, PremieraData)
VALUES ('Le Mans', 2, '20190830')


ALTER TABLE Film ADD DEFAULT '' FOR OpisFilmu


--! Cannot insert the value NULL into column 'OpisFilmu',
INSERT INTO Film (Tytul, KrajID, PremieraData)
VALUES ('Le Mans', 2, '20190830')


-- is_system_named
SELECT * FROM sys.default_constraints

ALTER TABLE Film DROP CONSTRAINT DF__Film__OpisFilmu__440B1D61




ALTER TABLE Film ADD CONSTRAINT DF_Film_OpisFilmu DEFAULT '' FOR OpisFilmu

ALTER TABLE Film ADD CONSTRAINT DF_Film_PremieraData DEFAULT GETDATE() FOR PremieraData



-- is_system_named
SELECT * FROM sys.default_constraints

