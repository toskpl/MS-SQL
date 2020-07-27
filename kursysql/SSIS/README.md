Na podstawie:

"SQL Server Integration Services"


https://www.kursysql.pl/szkolenie-sql-server-integration-services/

---------------------------------------------------------------------------------------------------------

SSIS_Lab

 Wykorzystano Kreator Exportu i Importu – dostępny w ramach SSMS.

 Wyeksportowno tabelę: Production.Product

 Zapisano jako pakiet *dstx

 Zaimportowano pakiet (lab02c_wizard.dtsx) w SSIS.
 
 **[SSIS import from wizard](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab02c_wizard.png)**
 
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

|Typ | Jak działa |
| ------------- |:-------------:|
Full cache | cała tabela ładowana do pamieci| 
Partial cache | czesc tabeli jest w cache, jeśli nie ma w cache danych to siega do bazy danych i doczytuje brakujace dane| 
No cache | zawsze siega do bazy danych, nie ma danych w cache| 

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

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab04b_controlflow.dtsx).

Stworzono przepływ ETL wykorzystano:
Flat File Source odczyt pojedyńczego pliku i załadowanie danych do tabeli [Countries]

**[SSIS ETL Flat File Source](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab04b_controlflow.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab04b_controlflow_file_system_task.dtsx).

Stworzono przepływ ETL wykorzystano:
File System Task skopiowanie z katalogu źródłowego do katalogu docelowego pojedyńczego pliku .txt i załadowanie danych do tabeli [Countries], usunięcie pliku w katalogu docelowym

**[SSIS ETL File System Task](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab04b_controlflow_file_system_task.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab04b_controlflow_for_loop.dtsx).

Stworzono przepływ ETL wykorzystano:
2 pętle For Loop i For Foreach Loop Container.
File System Task skopiowanie z katalogu źródłowego do katalogu docelowego wszystkich plików .txt i załadowanie danych do tabeli [Countries], usunięcie pliku w katalogu docelowym

**[SSIS ETL For Loop](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab04b_controlflow_for_loop.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab04c_breakpoint.dtsx).

Stworzono przepływ ETL wykorzystano:
2 pętle For Loop i For Foreach Loop Container.
File System Task skopiowanie z katalogu źródłowego do katalogu docelowego wszystkich plików .txt i załadowanie danych do tabeli [Countries], usunięcie pliku w katalogu docelowym
Dane źródłowe błędne przez co proces ETL kończy się błędem - breakpoint do analizy błędu.

**[SSIS ETL Breakpoint](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab04c_breakpoints.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab05b_SQLTask.dtsx).

Stworzono przepływ ETL wykorzystano:
Execute SQL
Foreach Loop Container: - Execute Process Task, Execute SQL, Bulk Insert Task,File System Task + zmienne pakietowe + parametr projektu

**[SSIS ETL SQLTask](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab05b_SQLTask.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab05c_bulk.dtsx).

Stworzono przepływ ETL wykorzystano:
Execute SQL Task
Foreach Loop Container: - Execute Process Task,Execute SQL Task,Bulk Insert Task,File System Task + zmienne pakietowe + parametr projektu

**[SSIS ETL Bulk](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab05c_bulk.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab5d_maintenence).

Stworzono przepływ ETL wykorzystano:
Rebuild Index Task,Update Statistics Task,Back Up Database Task,Maintenance Cleanup Task

**[SSIS ETL Maintenence](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab05d_mantenance.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab6b_fuzzylookup).

Stworzono przepływ ETL wykorzystano:
OLE DB Source,Lookup, Fuzzy Lookup, Multicast

**[SSIS ETL Fuzzy Lookup](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab06b_fuzzyloop.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab06c_merge_join).

Stworzono przepływ ETL wykorzystano:
OLE DB Source,Sort, Merge Join, Multicast

**[SSIS ETL Merge Join](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab06c_merge_join.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab06d_unionall).

Stworzono przepływ ETL wykorzystano:
OLE DB Source, UnionAll, Row Count, Scrpit Task Editor + zmienne systemowe + zmienna pakietowa

**[SSIS ETL UnionAll](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab06d_unionall.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab06e_merge).

Stworzono przepływ ETL wykorzystano:
OLE DB Source, Merge, Row Count, Scrpit Task Editor + zmienne systemowe + zmienna pakietowa

**[SSIS ETL Merge](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab06e_merge.png)**

---------------------------------------------------------------------------------------------------------
 
Stworzono nowy pakiet  (lab06f_cmd).

Stworzono przepływ ETL wykorzystano:
OLE DB Source, LookUp, Derived Column, UnionAll, OLE DB Command

**[SSIS ETL CMD](https://github.com/toskpl/MS-SQL/blob/master/kursysql/SSIS/MOD1/MOD1_lab06f_cmd.png)**

