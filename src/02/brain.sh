#!/bin/bash

source check.sh

function s21_clean_one {
  cp ../02/log.txt .
  LIST_OF_FOLDERS=`cat log.txt | awk -F " " '{ print $1 }'`
  for var in $LIST_OF_FOLDERS
  do
    rm -rf $var
  done
  rm -rf log.txt
}

function s21_clean_two {
  cp ../02/log.txt .
  read -p "Enter the date. For example: YYYY-MM-DD   " arg3
  read -p "Enter the time begin. For example: HH:MM  " arg1
  read -p "Enter the time end. For example: HH:MM  " arg2
  s21_check_date $arg1 $arg2 $arg3
  if [[ $? -ne 2 ]]
  then
    find / -newerct "$arg3 $arg1" ! -newerct "$arg3 $arg2" -type d  2>/dev/null | grep $(date +"%d%m%y") | sudo xargs rm -rf 2>/dev/null
  fi
  rm -rf log.txt
}

function s21_clean_three {
  read -p "Enter the folder name. For example: folder_031222  " arg1
  BEGIN_NAME=`echo $arg1 | awk -F "_" '{ print $1 }'`
  END_NAME=`echo $arg1 | awk -F "_" '{ print $2 }'`
  
  BEGIN_NAME+="*"
  BEGIN_NAME+="_"
  BEGIN_NAME+=$END_NAME
  find / -name $BEGIN_NAME -exec rm -rf {} \; 2>/dev/null
}