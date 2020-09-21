/*
	RODZAJE INDEKSÓW
	H: Zadania
*/


/*
	Zadanie 1 - tworzenie indeksów klastrowych i nieklastrowych

	1. Włącz wyświetlanie statystyk liczby odczytanych stron (1 strona = 8KB) 
	i porównaj wydajność poniższych zapytań 
	(liczbę odczytanych wierszy i stron) – zanotuj uzyskane wartości.

	Korzystając z interfejsu graficznego Management Studio utwórz odpowiednie indeksy 
	i powtórz sprawdzenie liczby odczytywanych stron

*/

USE AdventureWorks2017
GO

SELECT * INTO Orders FROM Sales.SalesOrderHeader



SET STATISTICS IO ON

-- liczba odczytów
-- przed: 785 (HEAP)
-- po: 2 
-- po: 11
SELECT SalesOrderID, OrderDate, Status, CustomerID, TotalDue
FROM Orders
ORDER BY OrderDate DESC
OFFSET 0 ROWS FETCH NEXT 100 ROWS ONLY

-- liczba odczytów
-- przed: 785 (HEAP)
-- po: 5 (OPCJA A)
-- po: 24 (OPCJA B)
SELECT SalesOrderID, OrderDate, Status, CustomerID, TotalDue
FROM Orders
ORDER BY OrderDate DESC
OFFSET 500 ROWS FETCH NEXT 100 ROWS ONLY

-- liczba odczytów
-- przed: 785 (HEAP)
-- po: 2 (OPCJA A)
-- po: 9 (OPCJA B)
SELECT SalesOrderID, OrderDate, Status, CustomerID, TotalDue
FROM Orders
WHERE OrderDate BETWEEN '20130101' AND '20130120'
ORDER BY OrderDate DESC

-- liczba odczytów
-- przed: 785 (HEAP)
-- po:3 (OPCJA A)
-- po:2 (OPCJA B)
SELECT SalesOrderID, OrderDate, Status, CustomerID, TotalDue
FROM Orders WHERE SalesOrderID = 75086

-- liczba odczytów
-- przed: 785 (HEAP)
-- po: 2 (OPCJA A)
-- po: 2 (OPCJA B)
SELECT SalesOrderID, OrderDate, Status, CustomerID, TotalDue
FROM Orders WHERE CustomerID = 11619


/* OPCJA A*/

CREATE UNIQUE CLUSTERED INDEX [CL_IDX_Order_SalesOrderID] ON [dbo].[Orders] (SalesOrderID ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Order_OrderDate] ON [dbo].[Orders] (OrderDate ASC)
INCLUDE(Status,CustomerID,TotalDue) 
GO


CREATE NONCLUSTERED INDEX [IDX_Order_CustomerID] ON [dbo].[Orders](	CustomerID ASC)
INCLUDE(OrderDate,Status,TotalDue) 
GO



/****** Object:  Index [IDX_Order_CustomerId]    Script Date: 23.05.2020 00:07:54 ******/
DROP INDEX [CL_IDX_Order_SalesOrderID] ON [dbo].[Orders]
GO

DROP INDEX [IDX_Order_OrderDate] ON [dbo].[Orders]
GO

DROP INDEX [IDX_Order_CustomerID] ON [dbo].[Orders]
GO


/*****************************************************************************************/

/* OPCJA B*/

CREATE CLUSTERED INDEX [CL_IDX_Order_OrderDate] ON [dbo].[Orders](	OrderDate ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Order_SalesOrderID] ON [dbo].[Orders] (SalesOrderID ASC)
INCLUDE(Status,CustomerID,TotalDue) 
GO

CREATE NONCLUSTERED INDEX [IDX_Order_CustomerId] ON [dbo].[Orders](	CustomerID ASC)
INCLUDE(SalesOrderID,Status,TotalDue) 
GO

/****** Object:  Index [IDX_Order_CustomerId]    Script Date: 23.05.2020 00:07:54 ******/
DROP INDEX [CL_IDX_Order_OrderDate] ON [dbo].[Orders]
GO

DROP INDEX [IDX_Order_SalesOrderID] ON [dbo].[Orders]
GO

DROP INDEX [IDX_Order_CustomerId] ON [dbo].[Orders]
GO

/*
	Zadanie 2 - Wyszukiwanie fragmentacji indeksów

	Napisz skrypt, który wyszuka w bazie danych AW wszystkie indeksy, 
	składające się przynajmniej z 100 stron, 
	które mają fragmentację powyżej 10%

*/



select * from sys.dm_db_index_physical_stats(DB_ID('AdventureWorks2017'), NULL,NULL,NULL,'LIMITED')
where page_count > 100 and avg_fragmentation_in_percent > 10

select SCHEMA_NAME(obj.schema_id),obj.name,ix.name,ix.type_desc, ips.page_count,ips.avg_fragmentation_in_percent 
from sys.dm_db_index_physical_stats(DB_ID('AdventureWorks2017'), NULL,NULL,NULL,'LIMITED') as ips
join sys.indexes AS ix on ix.object_id = ips.object_id and ix.index_id = ips.index_id
join sys.objects AS obj on obj.object_id = ips.object_id
where page_count > 100 and avg_fragmentation_in_percent > 10