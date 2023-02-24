#!/bin/bash

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib/ 

BIN_PATH=/example/bin/
CONF_PATH=/example/conf/
LIB_PATH=/example/lib/
LOG_PATH=/example/log/
FILE_PATH=/example/files/

mkdir -p $BIN_PATH
mkdir -p $CONF_PATH
mkdir -p $LIB_PATH
mkdir -p $LOG_PATH
mkdir -p $FILE_PATH

yes | cp -a  ./daemon/src/...				$BIN_PATH
# ...

echo "copy configure files to //"
yes | cp -a  ./daemon/conf/...              $CONF_PATH
# ...

echo "copy python library files to //"
yes | cp -a  ./ai_src/text_ai/...           $LIB_PATH
# ...

echo "redis-server start..."
service redis-server start
