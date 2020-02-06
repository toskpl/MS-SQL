/*
	KursySQL.pl

	��CZENIE TABEL
	Z Zadania rozwi�zanie

*/


USE adventureworks2017

/*
	1. Wy�wietl produkty wraz z podkategoriami (wszystkie kolumny)
	Po��cz tabel� Production.Product z Production.ProductSubcategory
*/ 

SELECT p.*,psub.*
FROM production.product p
JOIN production.productsubcategory psub
ON P.productsubcategoryid = psub.productsubcategoryid

/*
	2 Zmodyfikuj zapytanie 1:
	Poka� tylko kolumny: ProductID, Name, Color (Production.Product)
	oraz Name - alias 'SubCategoryName'(Production.ProductSubcategory)
*/

SELECT p.productid,p.NAME,p.color,psub.NAME AS subcategoryname
FROM production.product p
JOIN production.productsubcategory psub
ON P.productsubcategoryid = psub.productsubcategoryid

/*
	3. Zmodyfikuj zapytanie 2:
	- dodaj trzeci� tabel� Production.ProductCategory 
	- wy�wietl w wyniku dodatkowo nazw� kategorii 
	(Name, alias CategoryName) 
*/

SELECT p.productid,p.NAME,p.color,psub.NAME AS subcategoryname,pc.NAME AS categoryname
FROM production.product p
JOIN production.productsubcategory psub ON p.productsubcategoryid = psub.productsubcategoryid
JOIN production.productcategory pc ON psub.productcategoryid = pc.productcategoryid

/*
	4. Wy�wietl dane pracownik�w - stanowisko, login, imi� i nazwisko
*/

SELECT e.businessentityid,e.jobtitle,e.loginid,p.firstname,p.lastname
FROM person.person p
JOIN humanresources.employee e ON p.businessentityid = e.businessentityid

/*
	5. Dodaj do wynik�w poprzedniego zapytania (lista pracownik�w) 
	informacj� o mie�cie i kraju w kt�rym mieszkaj�
*/

SELECT e.businessentityid,e.jobtitle,e.loginid,p.firstname,p.lastname, pa.city,cr.name
FROM person.person p
JOIN humanresources.employee e ON p.businessentityid = e.businessentityid
JOIN person.businessentity pb ON p.businessentityid = pb.businessentityid
JOIN person.businessentityaddress pba ON pb.businessentityid = pba.businessentityid
JOIN person.address pa ON pba.addressid = pa.addressid
JOIN person.stateprovince psp ON psp.stateprovinceid = pa.stateprovinceid
JOIN person.countryregion cr ON cr.countryregioncode = psp.countryregioncode

/*
	6. Wy�wietl liczb� pracownik�w z poszczeg�lnych miast/ kraj�w
*/

SELECT cr.name, pa.city,COUNT(*) AS manypeople
FROM person.person p
JOIN humanresources.employee e ON p.businessentityid = e.businessentityid
JOIN person.businessentity pb ON p.businessentityid = pb.businessentityid
JOIN person.businessentityaddress pba ON pb.businessentityid = pba.businessentityid
JOIN person.address pa ON pba.addressid = pa.addressid
JOIN person.stateprovince psp ON psp.stateprovinceid = pa.stateprovinceid
JOIN person.countryregion cr ON cr.countryregioncode = psp.countryregioncode
GROUP BY cr.name,pa.city

/*
	7. Wy�wietl dane o produktach i nazwy przypisanych do nich zdj��
*/

SELECT p.productid, p.name, pp.largephotofilename
FROM production.product AS p
JOIN production.productproductphoto AS ppp ON ppp.productid = p.productid
JOIN production.productphoto AS pp ON pp.productphotoid = ppp.productphotoid

/*
	8. Zsumuj rozmiar zdj�� produkt�w (Production.ProductPhoto.LargePhoto) 
	w poszczeg�lnych kategoriach i zaokr�glij go do kilobajt�w
*/


SELECT pc.name, SUM(datalength (pp.largephoto))/1024
FROM production.product p
JOIN production.productproductphoto ppp ON p.productid = ppp.productid
JOIN production.productphoto pp ON pp.productphotoid = ppp.productphotoid
JOIN production.productsubcategory psub ON p.productsubcategoryid = psub.productsubcategoryid
JOIN production.productcategory pc ON psub.productcategoryid = pc.productcategoryid
GROUP BY pc.name

/* OUTER JOIN */

/*
	9. Wy�wietl dwie kolumny: identyfikator klienta i numer zam�wienia,
	uwzgl�dniaj�c klient�w kt�rzy nie z�o�yli �adnego zam�wienia
	Zamie� z��czenie INNER JOIN na LEFT OUTER JOIN 
*/

SELECT sr.customerid, soh.salesorderid
FROM sales.customer AS sr
LEFT OUTER JOIN sales.salesorderheader AS soh ON soh.customerid = sr.customerid

/*
	10. Zmodyfikuj poprzednie zapytanie, dodaj warunek filtruj�cy WHERE, 
	aby ograniczy� wynik tylko do klient�w, kt�rzy nie z�o�yli �adnego zam�wienia 
*/

SELECT sr.customerid, soh.salesorderid
FROM sales.customer AS sr
LEFT OUTER JOIN sales.salesorderheader AS soh ON soh.customerid = sr.customerid
WHERE soh.customerid IS NULL

/*
	11. Zlicz produkty w poszczeg�lnych kategoriach i podkategoriach.
	Uwzgl�dnij produkty nie przypisane do �adnej podkategorii.
	Wynik posortuj po nazwie kategorii i podkategorii.
*/

SELECT pc.name,psub.name,COUNT(*)
FROM production.product p
LEFT OUTER JOIN production.productsubcategory psub ON p.productsubcategoryid = psub.productsubcategoryid
LEFT OUTER JOIN production.productcategory pc ON psub.productcategoryid = pc.productcategoryid
GROUP BY pc.name,psub.name
ORDER BY pc.name,psub.name

/*
	12. Zmodyfikuj poprzednie zapytanie dodaj�c ROLLUP w celu wy�wietlenia 
	liczby produkt�w w poszczeg�lnych kategoriach
*/

SELECT pc.name,psub.name,COUNT(*)
FROM production.product p
LEFT OUTER JOIN production.productsubcategory psub ON p.productsubcategoryid = psub.productsubcategoryid
LEFT OUTER JOIN production.productcategory pc ON psub.productcategoryid = pc.productcategoryid
GROUP BY ROLLUP(pc.NAME,psub.name)
ORDER BY pc.name,psub.name

/*
	13. Zmodyfikuj poprzednie zapytanie dodaj�c funkcj� GROUPING,
	wyr�niaj�c� liczb� wszystkich produkt�w
*/

SELECT pc.name,psub.name,GROUPING (pc.name),COUNT(*)
FROM production.product p
LEFT OUTER JOIN production.productsubcategory psub ON p.productsubcategoryid = psub.productsubcategoryid
LEFT OUTER JOIN production.productcategory pc ON psub.productcategoryid = pc.productcategoryid
GROUP BY ROLLUP(pc.name,psub.name)
ORDER BY pc.name,psub.name

/*
	14. Wy�wietl wszystkie informacje (kolumny) o klientach (Sales.Customer),
	kt�rzy z�o�yli przynajmniej jedno zam�wienie 
	- zastosuj podzapytanie i zapytanie z JOIN

*/

---------------------------------------------------------------------------------------
SELECT sr.customerid, soh.salesorderid
FROM sales.customer AS sr
JOIN sales.salesorderheader AS soh ON soh.customerid = sr.customerid

SELECT sr.*
FROM sales.customer AS sr WHERE 
EXISTS ( SELECT soh.salesorderid 
	   FROM sales.salesorderheader AS soh 
	   WHERE  soh.customerid = sr.customerid)
----------------------------------------------------------------------------------------

/*
	15. Wy�wietl informacje o wszystkich nazwach produkt�w, podkategorii i kategorii jako jeden zbi�r wynikowy
	- w dodatkowych kolumnach dodaj informacj� o rodzaju etykiety (nazwy)
*/

SELECT p.name, 1 AS 'IsProduct',0 AS 'IsCategory',0 AS 'IsSubCategory'
FROM production.product p
UNION
SELECT c.name, 0 AS 'IsProduct',1 AS 'IsCategory',0 AS 'IsSubCategory'
FROM production.productcategory c
UNION
SELECT s.name, 0 AS 'IsProduct',0 AS 'IsCategory',1 AS 'IsSubCategory'
FROM production.productsubcategory s

/*
	16. Wy�wietl identyfikatory zamawianych produkt�w
	- zastosuj operator INTERSECT, a nast�pnie zapytanie z JOIN
*/

SELECT productid FROM production.product
INTERSECT
SELECT productid FROM sales.salesorderdetail


SELECT DISTINCT sod.productid 
FROM production.product p
JOIN sales.salesorderdetail sod ON sod.productid = p.product.productid






