#!/bin/bash

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib/ 
#export PYTHONPATH=/lockard_ai/lib/

echo "copy binary files to /lockard_ai/bin"
BIN_PATH=/lockard_ai/bin/
CONF_PATH=/lockard_ai/conf/
LIB_PATH=/lockard_ai/lib/
PY_PATH=/lockard_ai/lib/python/
LOG_PATH=/lockard_ai/log/
FILE_PATH=/lockard_ai/files/
COMMON_PATH=$PY_PATH/common/
SENSITIVE_PATH=$PY_PATH/sensitive/
ENCRYPTION_PATH=$PY_PATH/encryption/
MALWARE_PATH=$PY_PATH/malware/
STEGANO_PATH=$PY_PATH/stegano/
URL_PATH=$PY_PATH/url/
YOLO_PATH=$PY_PATH/yolov4/
QR_PATH=$PY_PATH/qrcode/
CODE_PATH=$PY_PATH/chatgpt_code/
DAEMON_PATH=$PY_PATH/daemon/

mkdir -p $BIN_PATH
mkdir -p $CONF_PATH
mkdir -p $LIB_PATH
mkdir -p $LOG_PATH
mkdir -p $FILE_PATH
mkdir -p $PY_PATH
mkdir -p $DAEMON_PATH

bin() {
    yes | cp -a  ./daemon/src/lai_analyzer/lai_analyzer      $BIN_PATH
    yes | cp -a  ./daemon/src/ai_file/ai_file                $BIN_PATH
    yes | cp -a  ./daemon/src/lai_collector/lai_collector    $BIN_PATH
    yes | cp -a  ./daemon/src/laic_sftp/laic_sftp            $BIN_PATH

    yes | cp -a  ./ai_src/daemon/lai_predict.py              $BIN_PATH


    #yes | cp -a  ./daemon/script/sftp_check.sh               $BIN_PATH
    #yes | cp -a  ./daemon/script/sftp_download.sh            $BIN_PATH
}

conf() {
    echo "copy configure files to /lockard_ai/conf"
    yes | cp -a  ./daemon/conf/lai_analyzer.json      $CONF_PATH
    yes | cp -a  ./daemon/conf/lai_collector.json     $CONF_PATH
    yes | cp -a  ./ai_src/conf/py_conf.json           $CONF_PATH
    yes | cp -a  ./tools/lai_disk_cleaner/conf/lai_disk.json   $CONF_PATH
}

lib() {
    echo "copy python library files to /lockard_ai/lib/"
    yes | cp -a  ./ai_src/common/sd_conf.py       $COMMON_PATH
    yes | cp -a  ./ai_src/common/sd_psql.py       $COMMON_PATH
    yes | cp -a  ./ai_src/common/sd_util.py       $COMMON_PATH
    yes | cp -a  ./ai_src/common/sd_debug.py      $COMMON_PATH
    yes | cp -a  ./ai_src/common/sd_tools.py      $COMMON_PATH
    yes | cp -a  ./ai_src/common/sd_redis.py      $COMMON_PATH

    yes | cp -a  ./ai_src/url/url_predict/up_run.py        $URL_PATH

    yes | cp -a  ./ai_src/sensitive/image_predict.py             $SENSITIVE_PATH
    yes | cp -a  ./ai_src/sensitive/image_sensitive_predict.py   $SENSITIVE_PATH

    yes | cp -a  ./ai_src/encryption/encryption_predict.py  $ENCRYPTION_PATH
    yes | cp -a  ./ai_src/encryption/dataProcessing         $ENCRYPTION_PATH

    yes | cp -a  ./ai_src/malware/malware_predict.py        $MALWARE_PATH
    yes | cp -a  ./ai_src/malware/malware_processing.py     $MALWARE_PATH

    yes | cp -a  ./ai_src/stegano/stegano_predict.py  $STEGANO_PATH
    yes | cp -a  ./ai_src/stegano/aletheialib  $STEGANO_PATH

    yes | cp -a  ./ai_src/yolov4/predetect_yolov4.py  $YOLO_PATH

    yes | cp -a  ./ai_src/qrcode/qrcode_detection.py  $QR_PATH

    yes | cp -a  ./ai_src/chatgpt_code/code_classification.py  $CODE_PATH
    yes | cp -a  ./ai_src/chatgpt_code/code_detection_regex.py $CODE_PATH
    yes | cp -a  ./ai_src/chatgpt_code/guess.py                $CODE_PATH
    yes | cp -a  ./ai_src/chatgpt_code/model.py                $CODE_PATH

    yes | cp -a  ./ai_src/daemon/daemon.py                     $DAEMON_PATH
}

case "$1" in
    bin)
        bin;;
    conf)
        conf;;
    lib)
        lib;;
    *)
        echo "Invalid function name"
        exit 1;;
esac