$fileDir = Split-Path -Parent $MyInvocation.MyCommand.Path
cd $fileDir
java '-Dtalend.component.manager.m2.repository=%cd%/../lib' '-Xms512M' '-Xmx2048M' -cp '.;../lib/routines.jar;../lib/dom4j-1.6.1.jar;../lib/ini4j-0.5.1.jar;../lib/log4j-1.2.17.jar;../lib/postgresql-42.2.5.jar;../lib/talendcsv.jar;promote_to_final_0_1.jar;' order_etl.promote_to_final_0_1.promote_to_final  --context=Default %*