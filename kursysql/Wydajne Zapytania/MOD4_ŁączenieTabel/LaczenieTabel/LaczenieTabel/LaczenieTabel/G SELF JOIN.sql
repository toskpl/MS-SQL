/*
	KursySQL.pl

	£¥CZENIE TABEL
	G: SELF JOIN

*/


USE AdventureWorks2017;  
GO  

-- https://docs.microsoft.com/en-us/sql/relational-databases/tables/lesson-1-converting-a-table-to-a-hierarchical-structure?view=sql-server-ver15

DROP TABLE IF EXISTS  HumanResources.EmployeeOldSchool 

 SELECT emp.BusinessEntityID AS EmployeeID, emp.LoginID, emp.JobTitle, emp.HireDate,
  (SELECT  man.BusinessEntityID FROM HumanResources.Employee man 
	    WHERE emp.OrganizationNode.GetAncestor(1)=man.OrganizationNode OR 
		    (emp.OrganizationNode.GetAncestor(1) = 0x AND man.OrganizationNode IS NULL)) AS ManagerID
INTO HumanResources.EmployeeOldSchool
FROM HumanResources.Employee emp
GO

ALTER TABLE HumanResources.EmployeeOldSchool 
ADD CONSTRAINT PK_EmployeeOldSchool PRIMARY KEY (EmployeeID)

ALTER TABLE HumanResources.EmployeeOldSchool 
ADD CONSTRAINT FK_EmployeeOldSchool_ManagerID
FOREIGN KEY (ManagerID)
REFERENCES HumanResources.EmployeeOldSchool(EmployeeID)


SELECT * FROM HumanResources.EmployeeOldSchool


SELECT *
FROM HumanResources.EmployeeOldSchool AS emp
JOIN HumanResources.EmployeeOldSchool AS mgr 
ON mgr.EmployeeID = emp.ManagerID

SELECT emp.*, mgr.EmployeeID, mgr.LoginID, mgr.JobTitle
FROM HumanResources.EmployeeOldSchool AS emp
JOIN HumanResources.EmployeeOldSchool AS mgr 
ON mgr.EmployeeID = emp.ManagerID



-- + CEO
SELECT emp.*, mgr.EmployeeID, mgr.LoginID, mgr.JobTitle
FROM HumanResources.EmployeeOldSchool AS emp
LEFT JOIN HumanResources.EmployeeOldSchool AS mgr 
ON mgr.EmployeeID = emp.ManagerID


