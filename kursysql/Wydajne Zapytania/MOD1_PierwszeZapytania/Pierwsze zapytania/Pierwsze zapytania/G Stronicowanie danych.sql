/*
	KursySQL.pl

	PIERWSZE ZAPYTANIA
	G Stronicowanie danych

*/


USE AdventureWorks2017
GO


SELECT ProductID, Name, Color FROM Production.Product
ORDER BY Name ASC 

-- SQL2012+
SELECT ProductID, Name, Color FROM Production.Product
ORDER BY Name ASC OFFSET 100 ROWS 
FETCH NEXT 100 ROWS ONLY



WITH Paging_CTE AS
(
	SELECT 
		ProductID, Name, Color
		,ROW_NUMBER() OVER (ORDER BY Name) AS RowNumber
	FROM Production.Product
)
SELECT 
ProductID, Name, Color FROM Paging_CTE 
WHERE RowNumber > 100 AND RowNumber <= 200



SELECT ProductID, Name, Color 
FROM Production.Product
ORDER BY Name ASC OFFSET 0 ROWS 
FETCH NEXT 100 ROWS ONLY
-- taki sam wynik
SELECT TOP 100 ProductID, Name, Color 
FROM Production.Product
ORDER BY Name ASC 



