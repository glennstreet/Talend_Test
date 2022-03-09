%~d0
cd %~dp0
java -Dtalend.component.manager.m2.repository=%cd%/../lib -Xms256M -Xmx1024M -Dfile.encoding=UTF-8 -cp .;../lib/routines.jar;../lib/dom4j-1.6.1.jar;../lib/external_sort.jar;../lib/log4j-1.2.17.jar;../lib/talendcsv.jar;sorting_rows_0_1.jar; order_etl.sorting_rows_0_1.Sorting_rows  %*