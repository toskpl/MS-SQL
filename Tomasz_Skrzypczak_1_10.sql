--zad1
SELECT prot_id,
	prot_no,
	assigment,
	status_id
FROM dbo.protocol
WHERE assigment IN (
		'Parallel',
		'Single Group'
		)
	AND status_id = 'Approved';



 --zad2
SELECT prot_id,
	description,
	conditions,
	status_id,
	primary_compl_date
FROM dbo.protocol
WHERE primary_compl_date >= '2015-06-01'
ORDER BY primary_compl_date ASC;



 --zad3
SELECT prot_id,
	prot_no,
	assigment,
	status_id,
	primary_compl_date,
	last_upload_rt,
	ISNULL(primary_compl_date, last_upload_rt) AS new_primary_compl_date
FROM dbo.protocol


 --zad4

SELECT UPPER(CHARINDEX('@', resp_party_email)) AS 'find@',
	UPPER(resp_party_email) AS resp_party_email,
	UPPER(SUBSTRING(resp_party_email, CHARINDEX('@', resp_party_email) + 1, 7)) AS pocz_email,
	UPPER(LEFT(resp_party_email, CHARINDEX('@', resp_party_email) - 1)) AS kon_email
FROM dbo.protocol


 --zad5

SELECT UPPER(CHARINDEX('@', resp_party_email)) AS 'find@',
	UPPER(resp_party_email) AS resp_party_email,
	UPPER(SUBSTRING(resp_party_email, CHARINDEX('@', resp_party_email) + 1, 7)) AS pocz_email,
	UPPER(LEFT(resp_party_email, CHARINDEX('@', resp_party_email) - 1)) AS kon_email,
	REPLACE(UPPER(resp_party_email), 'GLOBAL', 'LOCAL') AS new_emial
FROM dbo.protocol



 --zad6

SELECT product_id,
	genericname,
	price,
	price * 0.15 + price AS new_price,
	ROUND(price * 0.15 + price, 0) new_price2
FROM dbo.product
ORDER BY new_price DESC

--zad7
SELECT DATENAME(dw, GETDATE()) AS dzien_tygodnia,
    DAY(GETDATE()) as dzien_miesiaca,
	DATENAME(ISO_WEEK, GETDATE()) AS tydzien_roku,
	DATENAME(m, GETDATE()) AS miesiac,
	DATENAME(QUARTER, GETDATE()) AS kwartal,
	DATENAME(YEAR, GETDATE()) AS rok,
	GETDATE() AS TIMESTAMPE;

--zad8
SELECT prot_id,
	approved_date,
	upd_date,
	DATEDIFF(YY, approved_date, upd_date) AS rok,
	DATEDIFF(MM, approved_date, upd_date) AS miesiac,
	DATEDIFF(DD, approved_date, upd_date) AS dzien,
	CONVERT(VARCHAR, upd_date, 112) AS upd_date,
	FORMAT(approved_date, 'yyyyMMdd') AS approved_date,
	DATEDIFF(DD, upd_date, GETDATE()) AS day_from_last_upd,
	GETDATE() as timestampe,
	EOMONTH(DATEADD(mm, 1, GETDATE())) AS last_day_next_month
FROM protocol;



--zad9
--a)
SELECT TOP(2) PERCENT prot_id,
	gender,
	CASE 
		WHEN gender = 'B'
			THEN 'Both'
		WHEN gender = 'F'
			THEN 'Female'
		WHEN gender = 'M'
			THEN 'Male'
		ELSE 'Others'
		END AS new_gender
FROM protocol
ORDER BY NEWID();


--b)

SELECT TOP (2) PERCENT PROT_ID,
	GENDER,
	iif(GENDER = 'B', 'Both', 
	   iif(GENDER = 'F', 'Female', 
	       iif((GENDER = 'M'), 'Male', 'Others'))) AS new_gender
FROM PROTOCOL
ORDER BY NEWID();

---zad10

SELECT prot_id,
	CASE 
		WHEN prot_id LIKE 'BO%'
			THEN REPLACE(prot_id, 'BO', 'NEW') + gender
		ELSE prot_id
		END AS new_prot_id
FROM protocol
WHERE prot_id LIKE 'BO%'