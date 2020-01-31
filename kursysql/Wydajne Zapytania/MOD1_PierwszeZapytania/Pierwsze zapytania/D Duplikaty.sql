/*
	KursySQL.pl

	PIERWSZE ZAPYTANIA
	D Usuwanie duplikatów

*/


USE AdventureWorks2017
GO


SELECT * FROM Production.Product
GO

SELECT Color FROM Production.Product
GO

SELECT DISTINCT Color FROM Production.Product
GO



SELECT Color, ReorderPoint FROM Production.Product
GO

SELECT DISTINCT Color, ReorderPoint FROM Production.Product
GO



SELECT DISTINCT * FROM Production.Product

