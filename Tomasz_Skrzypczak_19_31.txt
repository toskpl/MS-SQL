--Zad 19

SELECT p1.PROT_ID,
	p.PRODUCT_ID,
	p.PRICE
FROM protocol p1
INNER JOIN PRODUCT p
	ON p.PRODUCT_ID = p1.PRODUCT_ID
WHERE p.price > (
		SELECT avg(price)
		FROM PRODUCT
		)
ORDER BY PRICE DESC


--zad 20
SELECT pr.PROT_ID,
	p1.GENERICNAME,
	p1.RO_NUMBER,
	p1.PRICE,
	SUBSTRING(p1.RO_NUMBER, 1, 2) AS category,
	p2.*
FROM (
	SELECT SUM(price) AS SUM,
		MAX(price) AS MAX,
		AVG(price) AS AVG,
		MIN(price) AS MIN,
		COUNT(price) AS COUNT,
		SUBSTRING(RO_NUMBER, 1, 2) AS RO_NUMBER
	FROM PRODUCT p2
	GROUP BY SUBSTRING(RO_NUMBER, 1, 2)
	) p2
INNER JOIN PRODUCT p1
	ON SUBSTRING(p1.RO_NUMBER, 1, 2) = p2.RO_NUMBER
INNER JOIN protocol pr
	ON pr.PRODUCT_ID = p1.PRODUCT_ID
WHERE p1.GENERICNAME IS NOT NULL
ORDER BY pr.PROT_ID ASC

--------------------------------------------------------------------------------------------------------------------------
--zad 21
drop table RESEARCH
drop table PATIENT

CREATE TABLE PATIENT (
	ID INT PRIMARY KEY,
	FirstName VARCHAR(25),
	LastName VARCHAR(25),
	Age INT,
	Active CHAR(1),
	CONSTRAINT CHK_PATIENT CHECK (
		Age < 120
		AND Active IN (
			'N',
			'Y'
			)
		)
	)

CREATE TABLE RESEARCH (
	ID INT,
	StartDate DATE DEFAULT GetDate(),
	EndDAte DATE,
	Id_Patient INT,
	CONSTRAINT PK_RESEARCH PRIMARY KEY (id),
	CONSTRAINT CHK_RESEARCH CHECK (StartDate <= EndDate),
	CONSTRAINT Id_Patient_FK FOREIGN KEY (Id_Patient) REFERENCES PATIENT(ID)
	)

select * from RESEARCH

select * from PATIENT
--zad22
ALTER TABLE RESEARCH
ADD NAME VARCHAR(50);

--zad23
ALTER TABLE RESEARCH
ALTER COLUMN NAME VARCHAR(30)

--zad24
INSERT INTO PATIENT (ID,FirstName,LastName,Age,Active) VALUES  (1,'Adam','Nowak',56,'Y');
INSERT INTO PATIENT (ID,FirstName,LastName,Age,Active) VALUES  (2,'Ewa','KOwlaska',76,'N');

--zad25
UPDATE PATIENT
SET LastName = 'Kaczmarek'
WHERE id = 2

--zad26
DELETE PATIENT
WHERE id = 1;

--zad27
DELETE PATIENT

--zad28
DROP TABLE RESEARCH


--zad29
DECLARE @MaxID INT,
	    @Min_ID INT;

SELECT @MaxID = max(Product_id),
	   @Min_ID = min(Product_id)
FROM PRODUCT;

PRINT 'The value of @prot_id';
PRINT @MaxID;
PRINT 'The value of @description';
PRINT @Min_ID;


--zad30
DECLARE @Count INT = 65;
DECLARE @letter CHAR(1);

SET @letter = CHAR(65);

WHILE (@Count < 91)
BEGIN
	PRINT CHAR(@Count);

	SET @Count = @Count + 1;
END;


--zad31
drop TABLE DIM_DATES
CREATE TABLE DIM_DATES
(
ID_DATE INT IDENTITY(1,1),
DATE_YEAR_MONTH_DAY INT,
DATE_VALUE  DATETIME,
DATE_TEXT VARCHAR(8),
DATE_MONTH_TEXT VARCHAR(2), 
DATE_YEAR_TEXT VARCHAR(4),
DATE_YEAR_MONTH_TEXT VARCHAR(6),
DATE_QUARTER_TEXT VARCHAR(2)
)

BEGIN
	DECLARE @StartDate DATETIME
	DECLARE @EndDate DATETIME
	DECLARE @Counter INT

	SET @StartDate = '01/01/2010'
	SET @EndDate = '12/31/2099'
	SET @Counter = 1

	WHILE @StartDate <= @EndDate
	BEGIN
		INSERT INTO DIM_DATES (
			DATE_YEAR_MONTH_DAY,
			DATE_VALUE,
			DATE_TEXT,
			DATE_MONTH_TEXT,
			DATE_YEAR_TEXT,
			DATE_YEAR_MONTH_TEXT,
			DATE_QUARTER_TEXT
			)
		VALUES (
			CONCAT (
				format(@StartDate, 'yyyy'),
				format(@StartDate, 'MM'),
				format(@StartDate, 'dd')
				),
			@StartDate,
			format(@StartDate, 'yyyyMMdd'),
			format(@StartDate, 'MM'),
			format(@StartDate, 'yyyy'),
			format(@StartDate, 'yyyyMM'),
			'Q' + DATENAME(quarter, @StartDate)
			)

		SET @StartDate = DATEADD(d, 1, @StartDate)
		SET @Counter += 1;
	END
END

select *
 from  DIM_DATES