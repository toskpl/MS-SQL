/*
	KursySQL.pl

	Funkcje

*/

USE AdventureWorks2017
GO

/*
	1. Wy�wietl inicja�y os�b w odr�bnych kolumnach
	tabela Person.Person, funkcja LEFT()
*/


select LEFT(FirstName,1) as LeftF, LEFT(LastName,1) as LeftL ,* from person.Person

/*
	2. Wy�wietl inicja�y jako jedna kolumna 
	tabela Person.Person, funkcja LEFT()
*/

select LEFT(FirstName,1) + LEFT(LastName,1) as Inicialy ,* from person.Person

/*
	3. D�ugo�� adresu e-mail 
	tabela Person.EmailAddress, funkcja LEN()
*/

select LEN(EmailAddress) as EmailAddressLength,* from person.EmailAddress

/*
	4. Miejsce (pozycja) znaku @ w adresie e-mail 
	tabela Person.EmailAddress, funkcja CHARINDEX()
*/

select CHARINDEX('@',EmailAddress) as EmailAddressLength,* from person.EmailAddress

/*
	5. Trzecia litera imienia, u�yj wielkich liter 
	tabela Person.Person, funkcje SUBSTRING(), UPPER()
*/

select UPPER(SUBSTRING(FirstName,3,1)) as Letter_3, * from person.Person

/*
	6. Login z adresu e-mail (tekst przed znakiem @)
	tabela Person.EmailAddress, funkcje SUBSTRING(), CHARINDEX()
*/

select SUBSTRING(EmailAddress,1,CHARINDEX('@',EmailAddress)-1) as Letter_3, * from person.EmailAddress


/*
	7. Aktualna data i czas sformatowana jako: dd-mm-yy 
	funkcje GETDATE(), CONVERT()
*/

select CONVERT(nvarchar, GETDATE(), 5)

/*
	8. Data i czas- 13 miesi�cy p�niej po 1 stycznia 2020
	funkcje DATEADD()
*/

select DATEADD(MONTH, 13, '20200101')

/*
	9. 456 dni przed 1 stycznia 2020
	funkcje DATEADD()
*/

select DATEADD(day, -456, '20200101');

/*
	10. Liczba miesi�cy odk�d wiersz zosta� zmodyfikowany 
	tabela Person.Person, funkcja DATEDIFF()
*/

select DATEDIFF (month,ModifiedDate,GETDATE()), * from person.Person

------------------------
-- Funkcje konwersji
------------------------
/*
	11. Wy�wietl bie��c� dat� jako dd-mm-yyyy
	funkcje GETDATE, CONVERT
*/

select CONVERT(nvarchar, GETDATE(), 105)

/*
	12. Wy�wietl ostatni dzie� bie��cego miesi�ca
	funkcje GETDATE, EOMONTH
*/
select EOMONTH(GETDATE())

/*
	13. Wy�wietl ostatni dzie� lutego 2020
	funkcja EOMONTH
*/
select EOMONTH('20200201')

/*
	14. Wy�wietl ostatni dzie� lutego 2021
	funkcja EOMONTH
*/
select EOMONTH('20210201')

/*
	15. Wy�wietl nazw� dnia tygodnia
	funkcje GETDATE, DATENAME
*/

select DATENAME(dw,GETDATE()) as DayOfWeek

/*
	16. Wy�wietl nazw� dnia tygodnia ostatniego dnia grudnia 2019
	funkcje DATENAME, EOMONTH
*/

select DATENAME(dw,EOMONTH('20191201')) as LastDay_2019

/*
	17 Wy�wietl bie��cy numer tygodnia w roku
	funkcja GETDATE, DATEPART
*/

select DATEPART(wk,GETDATE()) as DayOfWeek

/*
	18. Wy�wietl informacj� o produktach - w dodatkowej pierwszej kolumnie wy�wietl 'bezcenny' 
	je�li produkt w kolumnie ListPrice ma warto�� 0, a w innym przypadku pusty �a�cuch znak�w
	tabela Production.Product, funkcja IIF
*/

select  IIF(ListPrice=0,'bezceonny',''),* from Production.Product

/*
	19. Wy�wietl informacj� o produktach - w dodatkowej pierwszej kolumnie wy�wietl 'bezcenny' 
	je�li produkt w kolumnie ListPrice ma warto�� 0, 
	a w przypadku ceny wy�szej ni� 0 - wy�wietl cen�
	tabela Production.Product, funkcja IIF
*/


select  IIF(ListPrice=0,'bezceonny',CAST (ListPrice as varchar)),* from Production.Product

/*
	20. Zast�p wszystkie pauzy (-) w numerze telefonu uko�nikami (/)
	tabela Person.PersonPhone, funkcja REPLACE
*/

select  replace (PhoneNumber,'-','/'),* from Person.PersonPhone

/*
	21. Zast�p w numerze telefonu drugi cz�on �a�cuchem 'XXX'
	tabela Person.PersonPhone, funkcja STUFF
*/

select  stuff (PhoneNumber,5,3,'XXXX'),* from Person.PersonPhone

/*
	22. Odwr�� numer telefonu
	tabela Person.PersonPhone, funkcja REVERSE
*/

select  reverse (PhoneNumber),* from Person.PersonPhone

/*
	23. Odczytaj warto�ci z kolumny SubTotal zaokr�glaj�c do pe�nego (dolara)
	tabela Sales.SalesOrderHeader, funkcja ROUND
*/

select ROUND(SUBTOTAL,0),* from Sales.SalesOrderHeader

/*
	24. Zlicz wszystkie rekordy w Sales.SalesOrderHeader
	tabela Sales.SalesOrderHeader, funkcja COUNT
*/

select count(*) from Sales.SalesOrderHeader

/*
	25. Zlicz wszystkie zam�wienia, z�o�one po 1 stycznia 2014
	tabela Sales.SalesOrderHeader, funkcja COUNT
*/

select count(*) from Sales.SalesOrderHeader where OrderDate >= '20140101'

/*
	26 Oblicz �redni� warto�� zam�wie� z�o�onych po 1 stycznia 2014
	tabela Sales.SalesOrderHeader, funkcje AVG, ISNULL
*/

select AVG(SubTotal) from Sales.SalesOrderHeader where OrderDate >= '20140101' 

USE Filmy
GO

/*
	27. Wy�wietl filmy, kt�rych tytu� jest d�u�szy ni� 50 znak�w
	tabela Film, funkcje LEN
*/

select len (TytulOryginalny) ,* from Film where  len (TytulOryginalny) >=50

/*
	28. Wylicz �redni bud�et film�w, z polskim j�zykiem oryginalnym z podanym bud�etem wi�kszym ni� 0
	tabela Film, funkcje AVG
*/

select avg (Budzet)  from Film where   JezykOryginalny ='pl' and Budzet > 0