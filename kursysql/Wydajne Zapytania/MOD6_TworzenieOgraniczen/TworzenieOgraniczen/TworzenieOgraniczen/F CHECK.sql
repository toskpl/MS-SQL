/*
	KursySQL.pl

	TWORZENIE OGRANICZEŃ
	F: CHECK
*/


USE BazaFilmy
GO

SELECT * FROM Film


-- 
ALTER TABLE Film ADD CHECK (PremieraData<GETDATE())

-- is_system_named
SELECT *FROM sys.check_constraints


INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Matix 4', 2, '20250422', '')



ALTER TABLE Film DROP CONSTRAINT CK__Film__PremieraDa__3F466844
GO


ALTER TABLE Film ADD CONSTRAINT CK_Film_PremieraData CHECK (PremieraData<GETDATE())

SELECT *FROM sys.check_constraints



ALTER TABLE Film NOCHECK CONSTRAINT CK_Film_PremieraData


-- is_disabled, is_not_trusted
SELECT *FROM sys.check_constraints


INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Matix 4', 2, '20250422', '')


ALTER TABLE Film CHECK CONSTRAINT CK_Film_PremieraData


INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Matix 5', 2, '20250422', '')


-- is_disabled, is_not_trusted
SELECT *FROM sys.check_constraints


DELETE FROM Film WHERE PremieraData > GETDATE()


ALTER TABLE Film WITH CHECK CHECK CONSTRAINT CK_Film_PremieraData


-- is_disabled, is_not_trusted
SELECT *FROM sys.check_constraints



--! Subqueries are not allowed in this context. Only scalar expressions are allowed.
ALTER TABLE Film ADD CONSTRAINT CK_Film_NieZaDuzoTegoSamegoKraju 
CHECK ((SELECT count(*) FROM Film WHERE KrajID=KrajID)>3)
GO


CREATE FUNCTION PoliczFilmy (@KrajID int)
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(*) FROM Film WHERE KrajID = @KrajID)
END
GO

ALTER TABLE Film ADD CONSTRAINT CK_Film_NieZaDuzoTegoSamegoKraju 
CHECK (dbo.PoliczFilmy(KrajID)>3)
GO


INSERT INTO Film (Tytul, KrajID, PremieraData, OpisFilmu)
VALUES ('Matix', 2, '19990324', '')


SELECT *FROM Film
