/*
	KursySQL.pl

	TWORZENIE OGRANICZEŃ
	E: FOREIGN KEY
*/


SELECT * FROM Film
GO

EXEC sp_help 'Film'


-- is_system_named
SELECT * FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('Film')


ALTER TABLE Film DROP CONSTRAINT FK__Film__KrajID__286302EC


ALTER TABLE Film ADD CONSTRAINT FK_Film_KrajID_Kraj FOREIGN KEY (KrajID) REFERENCES Kraj(ID)
GO

-- is_system_named
SELECT * FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('Film')



SELECT * FROM Kraj


INSERT INTO Kraj (KrajNazwa) VALUES ('Korea Południowa')
GO
SELECT SCOPE_IDENTITY()

INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Parasite', 3, '20190521', 'Kiedy Ki-woo dostaje pracę jako korepetytor córki zamożnego małżeństwa, wymyśla sposób na zapewnienie zatrudnienia również reszcie swojej rodziny')


SELECT f.ID, f.Tytul, f.KrajID, k.KrajNazwa
FROM Film f
JOIN Kraj k ON k.ID = f.KrajID

-- !
DELETE FROM Kraj WHERE KrajNazwa = 'Korea Południowa'







/* trusted/not trusted */


ALTER TABLE Film DROP CONSTRAINT FK_Film_KrajID_Kraj


DELETE FROM Kraj WHERE KrajNazwa = 'Korea Południowa'


SELECT f.ID, f.Tytul, f.KrajID, k.KrajNazwa
FROM Film f
LEFT JOIN Kraj k ON k.ID = f.KrajID


-- !
ALTER TABLE Film ADD CONSTRAINT FK_Film_KrajID_Kraj FOREIGN KEY (KrajID) REFERENCES Kraj(ID)
GO


-- WITH NOCHECK
ALTER TABLE Film WITH NOCHECK ADD CONSTRAINT FK_Film_KrajID_Kraj FOREIGN KEY (KrajID) REFERENCES Kraj(ID)
GO


SELECT f.ID, f.Tytul, f.KrajID, k.KrajNazwa
FROM Film f
LEFT JOIN Kraj k ON k.ID = f.KrajID


-- is_not_trusted
SELECT * FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('Film')



-- !
INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Służąca', 3, '20160514', 'Za namową oszusta dziewczyna zatrudnia się jako służąca arystokratki, by pomóc mu ją w sobie rozkochać')




-- próba sprawdzenia istniejących danych
ALTER TABLE Film WITH CHECK CHECK CONSTRAINT FK_Film_KrajID_Kraj
GO



SET IDENTITY_INSERT  Kraj ON

INSERT INTO Kraj (ID, KrajNazwa) VALUES (3, 'Korea Południowa')

SET IDENTITY_INSERT  Kraj OFF
GO

SELECT *FROM Kraj


-- próba sprawdzenia istniejących danych
ALTER TABLE Film WITH CHECK CHECK CONSTRAINT FK_Film_KrajID_Kraj
GO

-- is_not_trusted
SELECT * FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('Film')


SELECT f.ID, f.Tytul, f.KrajID, k.KrajNazwa
FROM Film f
LEFT JOIN Kraj k ON k.ID = f.KrajID

INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Służąca', 3, '20160514', 'Za namową oszusta dziewczyna zatrudnia się jako służąca arystokratki, by pomóc mu ją w sobie rozkochać')





/* wyłączenie (disable) */

ALTER TABLE Film NOCHECK CONSTRAINT FK_Film_KrajID_Kraj

INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Wilcze echa', 4, '20190117', 'Załoga supernowoczesnego okrętu podwodnego wykonuje misję wojskową u wybrzeży Syrii. W pewnym momencie specjalista obsługi sonaru melduje niezidentyfikowany dźwięk dobiegający z morskich głębin')



SELECT f.ID, f.Tytul, f.KrajID, k.KrajNazwa
FROM Film f
LEFT JOIN Kraj k ON k.ID = f.KrajID


-- ponowne włączenie FK
ALTER TABLE Film CHECK CONSTRAINT FK_Film_KrajID_Kraj
GO


-- kolejny film z krajID 4

INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Leon zawodowiec', 4, '19940914', 'Płatny morderca ratuje dwunastoletnią dziewczynkę, której rodzina została zabita przez skorumpowanych policjantów.')


ALTER TABLE Film WITH CHECK CHECK CONSTRAINT FK_Film_KrajID_Kraj
GO


DELETE FROM Film WHERE Tytul = 'Wilcze echa'


ALTER TABLE Film WITH CHECK CHECK CONSTRAINT FK_Film_KrajID_Kraj
GO






ALTER TABLE Film DROP CONSTRAINT FK_Film_KrajID_Kraj



/* ON DELETE/ UPDATE SET NULL */

ALTER TABLE Film ALTER COLUMN KrajID int NULL


ALTER TABLE Film ADD CONSTRAINT FK_Film_KrajID_Kraj FOREIGN KEY(KrajID) REFERENCES Kraj(ID)
  ON DELETE SET NULL
  ON UPDATE SET NULL
GO


SELECT f.ID, f.Tytul, f.KrajID, k.KrajNazwa
FROM Film f
LEFT JOIN Kraj k ON k.ID = f.KrajID


--! Cannot update identity column 'ID'.
UPDATE Kraj SET ID = 4 WHERE KrajNazwa = 'Korea Południowa'

DELETE FROM Kraj WHERE KrajNazwa = 'Korea Południowa'


SELECT f.ID, f.Tytul, f.KrajID, k.KrajNazwa
FROM Film f
LEFT JOIN Kraj k ON k.ID = f.KrajID



SET IDENTITY_INSERT  Kraj ON
INSERT INTO Kraj (ID, KrajNazwa) VALUES (3, 'Korea Południowa')
SET IDENTITY_INSERT  Kraj OFF
GO

UPDATE Film SET KrajID = 3 WHERE KrajID IS NULL





/* ON DELETE/ UPDATE CASCADE */


ALTER TABLE Film DROP CONSTRAINT FK_Film_KrajID_Kraj

ALTER TABLE Film ADD CONSTRAINT FK_Film_KrajID_Kraj FOREIGN KEY(KrajID) REFERENCES Kraj(ID)
  ON DELETE CASCADE
  ON UPDATE CASCADE
GO

SELECT f.ID, f.Tytul, f.KrajID, k.KrajNazwa
FROM Film f
LEFT JOIN Kraj k ON k.ID = f.KrajID


DELETE FROM Kraj WHERE KrajNazwa = 'Korea Południowa'



SELECT f.ID, f.Tytul, f.KrajID, k.KrajNazwa
FROM Film f
LEFT JOIN Kraj k ON k.ID = f.KrajID




ALTER TABLE Film DROP CONSTRAINT FK_Film_KrajID_Kraj

-- domyslnie:
ALTER TABLE Film ADD CONSTRAINT FK_Film_KrajID_Kraj FOREIGN KEY(KrajID) REFERENCES Kraj(ID)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
GO