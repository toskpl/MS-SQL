/*
	KursySQL.pl

	ŁĄCZENIE TABEL
	F: UNION - EXCEPT - INTERSECT

*/


USE AdventureWorks2017
GO



SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Firstname = 'Carlos' 
UNION
SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Firstname = 'Kim' 
UNION
SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Lastname = 'Akers' 


SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Firstname = 'Carlos' 
UNION ALL
SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Firstname = 'Kim' 
UNION ALL
SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Lastname = 'Akers' 



SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Firstname = 'Carlos' 
ORDER BY LastName DESC, FirstName ASC -- !!!
UNION ALL
SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Firstname = 'Kim' 
UNION ALL
SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Lastname = 'Akers' 



SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Firstname = 'Carlos' 
UNION ALL
SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Firstname = 'Kim' 
UNION ALL
SELECT BusinessEntityID, FirstName, LastName FROM Person.Person WHERE Lastname = 'Akers' 
ORDER BY LastName DESC, FirstName ASC


-- trzy różne zapytania
SELECT SalesOrderID, SalesOrderDetailID, ModifiedDate FROM Sales.SalesOrderDetail WHERE SalesOrderID = 43659
UNION
SELECT BusinessEntityID, EmailPromotion, ModifiedDate FROM Person.Person WHERE LastName = 'Akers'
UNION
SELECT SalesOrderID, RevisionNumber, OrderDate FROM Sales.SalesOrderHeader WHERE SalesOrderID = 43660

-- trzy różne zapytania - problem z typem danych
SELECT SalesOrderID, SalesOrderDetailID, ModifiedDate FROM Sales.SalesOrderDetail WHERE SalesOrderID = 43659
UNION
SELECT BusinessEntityID, EmailPromotion, ModifiedDate FROM Person.Person WHERE LastName = 'Akers'
UNION
SELECT BusinessEntityID, EmailPromotion, LastName FROM Person.Person WHERE LastName = 'Akers'




/* INTERSECT - część wspólna zbiorów */
SELECT ProductID  FROM Production.Product

SELECT ProductID 
FROM Production.Product
INTERSECT
SELECT ProductID 
FROM Production.WorkOrder


/* EXCEPT - różnica zbiorów */
SELECT ProductID 
FROM Production.Product
EXCEPT
SELECT ProductID 
FROM Production.WorkOrder


SELECT ProductID 
FROM Production.WorkOrder
EXCEPT
SELECT ProductID 
FROM Production.Product 




