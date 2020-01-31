/*
	KursySQL.pl
	Tomasz Libera | libera@kursysql.pl

	FUNKCJE
	B: Data i czas

*/



SELECT GETDATE()

SELECT SYSDATETIME()


SELECT YEAR(GETDATE())
SELECT MONTH(GETDATE())
SELECT DAY(GETDATE())



-- DATENAME ( datepart , date )
-- returns string
SELECT DATENAME(year, GETDATE())
SELECT DATENAME(WEEKDAY, GETDATE())
SELECT DATENAME(MONTH, GETDATE())



SET LANGUAGE Polish
SELECT DATENAME(WEEKDAY, GETDATE())
SELECT DATENAME(MONTH, GETDATE())
SET LANGUAGE English


-- DATEPART ( datepart , date )
-- returns integer

SELECT DATEPART(year, GETDATE()) AS _year
    ,DATEPART(month, GETDATE()) AS _month
    ,DATEPART(day, GETDATE()) AS _day 
    ,DATEPART(dayofyear, GETDATE()) AS _dayofyear
    ,DATEPART(weekday, GETDATE()) AS _weekday




-- DATEDIFF ( datepart , startdate , enddate )
-- returns the same date type as datepart param

SELECT DATEDIFF(day, '20200101', '20200301')

SELECT DATEDIFF(day, '20200101 10:00', '20200301 12:30')

-- 60*24
SELECT DATEDIFF(hour, '20200101', '20200301')

-- 60*24+2
SELECT DATEDIFF(hour, '20200101 10:00', '20200301 12:30')



-- DATEADD (datepart , number , date )
-- returns the same date type as date param


SELECT DATEADD(day, 23, '20200101')
SELECT DATEADD(hour, 23, '20200101')
SELECT DATEADD(year, 2, '20200101')
SELECT DATEADD(week, 2, '20200101')

SELECT DATEADD(week, -2, '20200101')



-- EOMONTH ( start_date [, month_to_add ] )
SELECT EOMONTH(GETDATE())

SELECT EOMONTH(GETDATE(), 1) -- nastepny miesiac
SELECT EOMONTH(GETDATE(), -1) -- poprzedni miesiac

-- przed SQL2012
SELECT DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE())+1,0))
