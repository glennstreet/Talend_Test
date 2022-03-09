%~d0
cd %~dp0
java -Dtalend.component.manager.m2.repository=%cd%/../lib -Xms512M -Xmx2048M -Dfile.encoding=UTF-8 -cp .;../lib/routines.jar;../lib/dom4j-1.6.1.jar;../lib/log4j-1.2.17.jar;../lib/postgresql-42.2.5.jar;oms_etl_0_1.jar; order_etl.oms_etl_0_1.OMS_ETL  %*