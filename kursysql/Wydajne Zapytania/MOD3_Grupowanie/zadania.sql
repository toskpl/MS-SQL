/*
	KursySQL.pl

	GRUPOWANIE DANYCH
*/ 

USE AdventureWorks2017 

/*
	1. Wyœwietl liczbê wszystkich produktów (wierszy w Production.Product)
*/

SELECT COUNT (*) AS cnt
FROM Production.Product 

/*
	2. Wyœwietl liczbê wszystkich produktów koloru niebieskiego
*/

SELECT COUNT(*) AS Cnt
FROM Production.Product
WHERE Color = 'Blue' 

/*
	3. Wyœwietl liczbê produktów przypisanych do poszczególnych kolorów
*/

SELECT COUNT (*) AS cnt,
               Color AS cnt
  FROM Production.Product
GROUP BY Color 

/*
	4. Wyœwietl liczbê produktów przypisanych do kolorów, które zaczynaj¹ siê na litery B lub S
*/

SELECT COUNT (*) AS cnt,
             Color AS cnt
FROM Production.Product
WHERE Color LIKE 'B%'
  OR Color LIKE 'S%'
GROUP BY Color 

/*
	5. Wyœwietl liczbê produktów poszczególnych rozmiarów,
	pomijaj¹c produkty bez przypisanego rozmiaru
*/

SELECT COUNT (*) AS cnt,
             SIZE
FROM Production.Product
WHERE SIZE IS NOT NULL
GROUP BY SIZE

/*
	6. Wyœwietl najwy¿sze ceny produktów poszczególnych rozmiarów
*/

SELECT max(ListPrice) AS maxPrice,
       SIZE
FROM Production.Product
GROUP BY SIZE 

/*
	7. Wyœwietl œredni¹ ceny produktów poszczególnych rozmiarów
*/

SELECT avg(ListPrice) AS maxPrice,
       SIZE
FROM Production.Product
GROUP BY SIZE 

/*
	8. Wyœwietl liczbê i œredni¹ cenê produktów przypisanych
	do poszczególnych kolorów i rozmiarów
*/

SELECT Color,
       SIZE,
       count(*) AS cnt,
       avg(ListPrice) AS avgPrice
FROM Production.Product
GROUP BY Color,
         SIZE 
		 
/*
	9. Wyœwietl liczbê produktów przypisanych do poszczególnych kolorów,
	ogranicz wynik do tych produktów, których jest ponad 50
*/

SELECT Color,
       count(*) AS cnt
FROM Production.Product
GROUP BY Color
HAVING COUNT (*) > 50 

/*
	10. Wyœwietl œredni¹ ceny produktów poszczególnych rozmiarów
	ogranicz wynik do tych produktów, których œrednia cena jest ponad 1000
*/

SELECT SIZE,
       AVG (ListPrice) AS avgPrice
FROM Production.Product
GROUP BY SIZE
HAVING AVG (ListPrice) > 1000 

/*
	11. Wyœwietl liczbê produktów przypisanych do poszczególnych
	podkategorii (ProductSubcategoryID) i okreœlonych kolorów
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
	GroupBySubcategory, GroupByColor wskazuj¹ce wyniki funkcji count()
*/

SELECT ProductSubcategoryID,
       Color,
       GROUPING_ID(ProductSubcategoryID),
       GROUPING_ID (Color),
       COUNT (*) AS cnt
FROM Production.Product
GROUP BY rollup(ProductSubcategoryID, Color) 

/*
	14. Zlicz produkty poszczególnych kolorów
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
	15. Korzystaj¹c z operatora PIVOT - wyœwietl liczbê produktów
	nastêpuj¹cych kolorów: Black, Blue, Red, Silver
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
	16. Korzystaj¹c z operatora PIVOT - wyœwietl liczbê produktów
	nastêpuj¹cych kolorów: Black, Blue, Red, Silver dla poszczególnych rozmiarów
	PodpowiedŸ: zmodyfikuj poprzednie zapytanie dodaj¹c tylko kolumnê Size w DWÓCH miejscach
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
	17. Korzystaj¹c z operatora PIVOT - wyœwietl liczbê produktów
	poszczególnych kolorów i rozmiarów: S, M, L, XL
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
	18. Korzystaj¹c SELECT INTO zapisz wynik poprzedniego zapytania do tabeli
	ProductsPivot. Korzystaj¹c z operatora UNPIVOT wyœwietl trzy kolumny:
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