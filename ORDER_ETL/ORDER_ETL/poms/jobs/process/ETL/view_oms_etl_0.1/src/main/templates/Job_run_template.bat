%~d0
cd %~dp0
java -Dtalend.component.manager.m2.repository=%cd%/../lib -Xms512M -Xmx2048M -Dfile.encoding=UTF-8 -cp .;../lib/routines.jar;../lib/dom4j-1.6.1.jar;../lib/ini4j-0.5.1.jar;../lib/log4j-1.2.17.jar;../lib/postgresql-42.2.5.jar;../lib/talendcsv.jar;view_oms_etl_0_1.jar; order_etl.view_oms_etl_0_1.View_OMS_ETL  %*