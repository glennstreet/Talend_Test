#!/bin/sh
cd `dirname $0`
ROOT_PATH=`pwd`
java -Dtalend.component.manager.m2.repository=$ROOT_PATH/../lib -Xms256M -Xmx1024M -Dfile.encoding=UTF-8 -cp .:$ROOT_PATH:$ROOT_PATH/../lib/routines.jar:$ROOT_PATH/../lib/dom4j-1.6.1.jar:$ROOT_PATH/../lib/ini4j-0.5.1.jar:$ROOT_PATH/../lib/log4j-1.2.17.jar:$ROOT_PATH/../lib/ojdbc7.jar:$ROOT_PATH/../lib/postgresql-42.2.5.jar:$ROOT_PATH/../lib/talendcsv.jar:$ROOT_PATH/tf_etl_0_1.jar: order_etl.tf_etl_0_1.TF_ETL  "$@"