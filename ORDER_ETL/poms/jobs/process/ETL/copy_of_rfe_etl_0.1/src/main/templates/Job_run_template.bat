%~d0
cd %~dp0
java -Dtalend.component.manager.m2.repository=%cd%/../lib -Xms256M -Xmx1024M -Dfile.encoding=UTF-8 -cp .;../lib/routines.jar;../lib/dom4j-1.6.1.jar;../lib/jtds-1.3.1-patch.jar;../lib/log4j-1.2.17.jar;../lib/postgresql-42.2.5.jar;../lib/talend_DB_mssqlUtil-1.2-20171017.jar;copy_of_rfe_etl_0_1.jar; order_etl.copy_of_rfe_etl_0_1.Copy_of_RFE_ETL  %*