%~d0
cd %~dp0
java -Dtalend.component.manager.m2.repository=%cd%/../lib -Xms3072M -Xmx5120M -Dfile.encoding=UTF-8 -cp .;../lib/routines.jar;../lib/dom4j-1.6.1.jar;../lib/ini4j-0.5.1.jar;../lib/log4j-1.2.17.jar;../lib/mysql-connector-java-5.1.30-bin.jar;../lib/postgresql-42.2.5.jar;../lib/talendcsv.jar;old_rl_etl_0_1.jar; order_etl.old_rl_etl_0_1.OLD_RL_ETL  %*