Na podstawie:

"SQL Server Integration Services"


https://www.kursysql.pl/szkolenie-sql-server-integration-services/

---------------------------------------------------------------------------------------------------------

SSIS_Lab

 Wykorzystano Kreator Exportu i Importu – dostępny w ramach SSMS.

 Wyeksportowno tabelę: Production.Product

 Zapisano jako pakiet *dstx

 Zaimportowano pakiet (lab02c_wizard.dtsx) w SSIS.
 
---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab02d_introduction.dtsx).

Stworzono połaczenie na projekcie (AW.conmgr).

Stworzono prosty przepływ danych z tabeli:

Sales.SalesOrderHeader połaczono z Person.Person do nowo utworzonej tabeli Orders.

**[SSIS review](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab02d_introduction.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab03b_profiler.dtsx).

Stworzono połaczenie na poziomie pakietu (localhost.AdventureWorks2017) + połaczenie do pliku XML z danymi profilera (profiler_results.xml)

Stworzono prosty profiler:

**[SSIS review profiler](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab03b_profiler.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab03c_etl.dtsx).

Stworzono przepływ ETL wykorzystano:
Derived Column,Lookup,Multicast,Split,Flat File Destination,OLE DB Destination

**[SSIS ETL](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab03c_etl.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab03d_etl_cache.dtsx).

Stworzono przepływ ETL wykorzystano:
Derived Column,Lookup,Multicast,Split,Flat File Destination,OLE DB Destination + wykorzystano transformacje cache

**[SSIS ETL Cache](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab03d_etl_cache.png)**


---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab03d_etl.dtsx).

Stworzono przepływ ETL wykorzystano:
Derived Column,Lookup,Multicast,Split,Flat File Destination,OLE DB Destination - użyto pojedyńczy LOOKUP (zastąpiono 2 inne lookup)

**[SSIS ETL LookUp](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab03d_etl_one_lookup.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab03e_debug.dtsx).

Stworzono przepływ ETL wykorzystano:
Derived Column,Lookup,Multicast,Split,Flat File Destination,OLE DB Destination + obsługa błedów przekirowanie błędów do tabeli [ErrorDRVProfit] i debugowanie

**[SSIS ETL Debug](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab03e_debug.png)**
