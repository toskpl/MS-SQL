/*
	KursySQL.pl

	GRUPOWANIE DANYCH
*/ 

USE AdventureWorks2017 

/*
	1. Wy�wietl liczb� wszystkich produkt�w (wierszy w Production.Product)
*/

SELECT COUNT (*) AS cnt
FROM Production.Product 

/*
	2. Wy�wietl liczb� wszystkich produkt�w koloru niebieskiego
*/

SELECT COUNT(*) AS Cnt
FROM Production.Product
WHERE Color = 'Blue' 

/*
	3. Wy�wietl liczb� produkt�w przypisanych do poszczeg�lnych kolor�w
*/

SELECT COUNT (*) AS cnt,
               Color AS cnt
  FROM Production.Product
GROUP BY Color 

/*
	4. Wy�wietl liczb� produkt�w przypisanych do kolor�w, kt�re zaczynaj� si� na litery B lub S
*/

SELECT COUNT (*) AS cnt,
             Color AS cnt
FROM Production.Product
WHERE Color LIKE 'B%'
  OR Color LIKE 'S%'
GROUP BY Color 

/*
	5. Wy�wietl liczb� produkt�w poszczeg�lnych rozmiar�w,
	pomijaj�c produkty bez przypisanego rozmiaru
*/

SELECT COUNT (*) AS cnt,
             SIZE
FROM Production.Product
WHERE SIZE IS NOT NULL
GROUP BY SIZE

/*
	6. Wy�wietl najwy�sze ceny produkt�w poszczeg�lnych rozmiar�w
*/

SELECT max(ListPrice) AS maxPrice,
       SIZE
FROM Production.Product
GROUP BY SIZE 

/*
	7. Wy�wietl �redni� ceny produkt�w poszczeg�lnych rozmiar�w
*/

SELECT avg(ListPrice) AS maxPrice,
       SIZE
FROM Production.Product
GROUP BY SIZE 

/*
	8. Wy�wietl liczb� i �redni� cen� produkt�w przypisanych
	do poszczeg�lnych kolor�w i rozmiar�w
*/

SELECT Color,
       SIZE,
       count(*) AS cnt,
       avg(ListPrice) AS avgPrice
FROM Production.Product
GROUP BY Color,
         SIZE 
		 
/*
	9. Wy�wietl liczb� produkt�w przypisanych do poszczeg�lnych kolor�w,
	ogranicz wynik do tych produkt�w, kt�rych jest ponad 50
*/

SELECT Color,
       count(*) AS cnt
FROM Production.Product
GROUP BY Color
HAVING COUNT (*) > 50 

/*
	10. Wy�wietl �redni� ceny produkt�w poszczeg�lnych rozmiar�w
	ogranicz wynik do tych produkt�w, kt�rych �rednia cena jest ponad 1000
*/

SELECT SIZE,
       AVG (ListPrice) AS avgPrice
FROM Production.Product
GROUP BY SIZE
HAVING AVG (ListPrice) > 1000 

/*
	11. Wy�wietl liczb� produkt�w przypisanych do poszczeg�lnych
	podkategorii (ProductSubcategoryID) i okre�lonych kolor�w
*/

SELECT ProductSubcategoryID,
       Color,
       COUNT (*) AS cnt
FROM Production.Product
GROUP BY ProductSubcategoryID,
         Color 
		 
/*
	12. Dodaj do poprzedniego zapytania operator ROLLUP
*/

SELECT ProductSubcategoryID,
       Color,
       COUNT (*) AS cnt
FROM Production.Product
GROUP BY rollup(ProductSubcategoryID, Color) 

/*
	13. Dodaj do poprzedniego zapytania dwie kolumny:
	GroupBySubcategory, GroupByColor wskazuj�ce wyniki funkcji count()
*/

SELECT ProductSubcategoryID,
       Color,
       GROUPING_ID(ProductSubcategoryID),
       GROUPING_ID (Color),
       COUNT (*) AS cnt
FROM Production.Product
GROUP BY rollup(ProductSubcategoryID, Color) 

/*
	14. Zlicz produkty poszczeg�lnych kolor�w
*/

SELECT Color,
       COUNT (*) AS cnt
FROM Production.Product
WHERE Color IN ('Black',
                'Red',
                'Blue',
                'Silver')
GROUP BY Color 

/*
	15. Korzystaj�c z operatora PIVOT - wy�wietl liczb� produkt�w
	nast�puj�cych kolor�w: Black, Blue, Red, Silver
*/

SELECT 'NumberProducts' AS NumberProducts,
       [Black],
       [Blue],
       [Red],
       [Silver]
FROM
  (SELECT Color
   FROM Production.Product) AS SourceTable --where Color in ('Black','Red','Blue','Silver') group by Color
PIVOT (COUNT (Color)
       FOR Color IN ([Black], [Blue], [Red], [Silver])) AS PivotTable 
	   
/*
	16. Korzystaj�c z operatora PIVOT - wy�wietl liczb� produkt�w
	nast�puj�cych kolor�w: Black, Blue, Red, Silver dla poszczeg�lnych rozmiar�w
	Podpowied�: zmodyfikuj poprzednie zapytanie dodaj�c tylko kolumn� Size w DW�CH miejscach
*/

SELECT 'NumberProducts' AS NumberProducts,
       [Black],
       [Blue],
       [Red],
       [Silver],
       [Size]
FROM
  (SELECT Color,
          SIZE
   FROM Production.Product) AS SourceTable --where Color in ('Black','Red','Blue','Silver') group by Color
PIVOT (COUNT (Color)
       FOR Color IN ([Black], [Blue], [Red], [Silver])) AS PivotTable 

/*
	17. Korzystaj�c z operatora PIVOT - wy�wietl liczb� produkt�w
	poszczeg�lnych kolor�w i rozmiar�w: S, M, L, XL
*/

SELECT [Color],
       [XL],
       [L],
       [S],
       [M]
FROM
  (SELECT Color,
          SIZE
   FROM Production.Product) AS SourceTable --where Color in ('Black','Red','Blue','Silver') group by Color
PIVOT (count(SIZE)
       FOR SIZE IN ([XL], [L], [S], [M])) AS PivotTable 
	   
/*
	18. Korzystaj�c SELECT INTO zapisz wynik poprzedniego zapytania do tabeli
	ProductsPivot. Korzystaj�c z operatora UNPIVOT wy�wietl trzy kolumny:
	Color, Size, ProductsCnt
*/
DROP TABLE IF EXISTS ProductsPivot;

SELECT [Color],
       [XL],
       [L],
       [S],
       [M] INTO ProductsPivot
FROM
  (SELECT Color,
          SIZE
   FROM Production.Product) AS SourceTable --where Color in ('Black','Red','Blue','Silver') group by Color
PIVOT (count(SIZE)
       FOR SIZE IN ([XL], [L], [S], [M])) AS PivotTable;


SELECT *
FROM ProductsPivot

SELECT Color,
       SIZE,
       ProductCnt
FROM ProductsPivot UNPIVOT (ProductCnt
                           FOR SIZE IN ([XL], [L], [S], [M])) AS un