#!/bin/bash

source check.sh
source process.sh

timedatectl set-timezone Europe/Moscow
BEGIN=`date +"%H:%M:%S %d/%m/%Y"`
BEGIN_2=`date +"%M:%S"`

if [[ $# -ne 3 ]]
then
  echo "ILLEGAL PARAMETERS: enter 3 arguments"
else
    s21_check $1 $2 $3
    if [[ $? -ne 2 ]]
    then
    LIST_OF_LETTERS=$1
    LIST_FOR_FILE=$2
    SIZE_OF_FILES=`echo $3 | awk -F "Mb" '{print $1}'`
    s21_create
    fi
fi