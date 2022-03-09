%~d0
cd %~dp0
java -Dtalend.component.manager.m2.repository=%cd%/../lib -Xms256M -Xmx1024M -Dfile.encoding=UTF-8 -cp .;../lib/routines.jar;../lib/dom4j-1.6.1.jar;../lib/log4j-1.2.17.jar;../lib/ojdbc7.jar;../lib/postgresql-42.2.5.jar;tf_etl_0_1.jar; order_etl.tf_etl_0_1.TF_ETL  %*