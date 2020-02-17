USE master
GO

ALTER DATABASE BazaFilmy SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

DROP DATABASE IF EXISTS  BazaFilmy
GO

CREATE DATABASE BazaFilmy
GO


USE BazaFilmy
GO


CREATE TABLE Kraj (
  ID int PRIMARY KEY IDENTITY,
  KrajNazwa nvarchar(100))
GO

INSERT INTO Kraj (KrajNazwa) VALUES ('Polska')
INSERT INTO Kraj (KrajNazwa) VALUES ('USA')
GO

CREATE TABLE Gatunek (
  ID int PRIMARY KEY IDENTITY,
  NazwaGatunku nvarchar(50))
GO

INSERT INTO Gatunek (NazwaGatunku) VALUES ('Dramat')
INSERT INTO Gatunek (NazwaGatunku) VALUES ('Przygodowy')
INSERT INTO Gatunek (NazwaGatunku) VALUES ('Sci-Fi')
INSERT INTO Gatunek (NazwaGatunku) VALUES ('Kryminał')
GO



CREATE TABLE Film (
  ID int PRIMARY KEY IDENTITY,
  Tytul nvarchar(100) NOT NULL,
  KrajID int NOT NULL REFERENCES Kraj(ID),
  PremieraData date NOT NULL,
  OpisFilmu nvarchar(500) NULL)
GO


CREATE TABLE FilmGatunek (
	IDFilmu int REFERENCES Film(ID), 
	IDGatunku int REFERENCES Gatunek(ID), 
	CONSTRAINT PK_FilmGatunek PRIMARY KEY (IDFilmu, IDGatunku))
GO

INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu) 
VALUES ('Joker', 2, '20190831', '')

INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu) 
VALUES ('Gwiezdne Wojny: Skywalker: Odrodzenie', 2, '20191219', NULL)

INSERT INTO Film (Tytul, KrajID, PremieraData) 
VALUES ('Osierocony Brooklyn', 2, '20191220')
GO


INSERT INTO FilmGatunek (IDFilmu, IDGatunku) VALUES (1, 1) -- Joker
INSERT INTO FilmGatunek (IDFilmu, IDGatunku) VALUES (2, 2) -- SW
INSERT INTO FilmGatunek (IDFilmu, IDGatunku) VALUES (2, 3) -- SW

INSERT INTO FilmGatunek (IDFilmu, IDGatunku) VALUES (3, 1) -- OB
INSERT INTO FilmGatunek (IDFilmu, IDGatunku) VALUES (3, 4) -- OB
GO

SELECT f.ID, f.Tytul, f.PremieraData, k.KrajNazwa, g.NazwaGatunku
FROM Film AS f
JOIN Kraj AS k ON k.ID = f.KrajID
LEFT JOIN FilmGatunek AS fk ON fk.IDFilmu = f.ID
LEFT JOIN Gatunek AS g ON g.ID = fk.IDGatunku
