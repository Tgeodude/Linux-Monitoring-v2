#!/bin/bash

function s21_create_folders {
COUNT_ROOT_FOLDERS=`ls -l -d /* 2>/dev/null | wc -l`
LIST_OF_DIR=`ls -l -d /* | awk '{printf "%s ", $9 }'`
EXEPT_FOLDRS='\/[s]?bin'
for var in $LIST_OF_DIR
do
  if ! [[ $var =~ $EXEPT_FOLDRS ]]
  then 
    RESULT_PATH=$var
    for (( i=1; i<=$COUNT_OF_FOLDERS; i++ ))
    do
      FREE_SIZE_2=`df -h -BM $var | grep '/' | awk '{ print $4 }' | awk -F "M" '{ print $1 }'`
      if [[ $FREE_SIZE_2 -le $SIZE_OF_FILES ]]
      then
        break
      fi
        s21_create_folder_name
        s21_create_files
        RESULT_PATH+="/"
        RESULT_PATH+=$RESULT_FOLDER_NAME
     done
  fi
done
}

function s21_create_folder_name {
  RESULT_FOLDER_NAME=$LIST_OF_LETTERS
  COUNT_LETTERS=${#LIST_OF_LETTERS}
  LAST_LETTER=${LIST_OF_LETTERS:(-1)}

  if [[ $COUNT_LETTERS -lt 5 ]]
  then
    DIFFERENCE=$(( 5 - $COUNT_LETTERS ))

    for (( i=1; i<=$DIFFERENCE; i++ ))
    do
      RESULT_FOLDER_NAME+=$LAST_LETTER    
    done
  fi
    LIST_FOLDER_LETTER+=$LAST_LETTER
    RESULT_FOLDER_NAME+=$LIST_FOLDER_LETTER
    RESULT_FOLDER_NAME+="_"
    RESULT_FOLDER_NAME+=`date +"%d%m%y"`
    mkdir $RESULT_PATH/$RESULT_FOLDER_NAME 2>/dev/null
    echo "$RESULT_PATH"/"$RESULT_FOLDER_NAME | $(date +'%H:%M:%S %Y-%m-%d') |"  >> $HOME_PATH/log.txt
}

function s21_create_files {
  COUNT_OF_FILES=` echo $(( $RANDOM % 500 + 10 )) `
  LIST_FILES_LETTER=""

  for (( j=1; j<=$COUNT_OF_FILES; j++ ))
  do  
    s21_create_file_name
    fallocate -l $SIZE_OF_FILES"MB" $RESULT_PATH/$RESULT_FOLDER_NAME/$RESULT_FILE_NAME 2>/dev/null
    echo "$RESULT_PATH"/"$RESULT_FOLDER_NAME"/"$RESULT_FILE_NAME | $(date +'%H:%M:%S %Y-%m-%d') | $SIZE_OF_FILES"Mb"" >> $HOME_PATH/log.txt
    FREE_SIZE=`df -h -BM / | grep '/' | awk '{ print $4 }' | awk -F "M" '{ print $1 }' `

    if [[ FREE_SIZE -le 1024 ]]
    then
        echo "free size less or equal 1GB"
        END=`date +"%H:%M:%S %d/%m/%Y"`
        END_2=`date +"%M:%S"`
        s21_work_time
        exit 1
    fi
  done
}

function s21_create_file_name {
  FILE_NAME="`echo $LIST_FOR_FILE | awk -F "." '{ print $1 }'`"
  FILE_TYPE="`echo $LIST_FOR_FILE | awk -F "." '{ print $2 }'`"
  COUNT_FILE_LETTERS=${#FILE_NAME}
  RESULT_FILE_NAME=$FILE_NAME
  LAST_FILE_LETTER=${FILE_NAME:(-1)}
  
  if [[ $COUNT_FILE_LETTERS -lt 5 ]]
  then
    DIFFERENCE_FILE_LETTERS_COUNT=$(( 5 - $COUNT_FILE_LETTERS ))
    for (( i=1; i<=$DIFFERENCE_FILE_LETTERS_COUNT; i++ ))
    do
        RESULT_FILE_NAME+=$LAST_FILE_LETTER
    done
  fi
  LIST_FILES_LETTER+=$LAST_FILE_LETTER
  RESULT_FILE_NAME+=$LIST_FILES_LETTER
  RESULT_FILE_NAME+="_"
  RESULT_FILE_NAME+=`date +"%d%m%y"`
  RESULT_FILE_NAME+="." 
  RESULT_FILE_NAME+=$FILE_TYPE
}

function s21_create {
  HOME_PATH=`pwd`
  LIST_FOLDER_LETTER=""
  COUNT_OF_FOLDERS=` echo $(( $RANDOM % 100 + 1 )) `

  for (( k=1; k<=$COUNT_OF_FOLDERS; k++ ))
  do
      RESULT_PATH=""
      cd /
      s21_create_folders
  done
}

function s21_work_time {
  MIN_BEGIN=`echo $BEGIN_2 | awk -F ":" '{print $1}'`
  SEC_BEGIN=`echo $BEGIN_2 | awk -F ":" '{print $2}'`
  
  MIN_END=`echo $END_2 | awk -F ":" '{print $1}'`
  SEC_END=`echo $END_2 | awk -F ":" '{print $2}'`

  RUNNING_TIME=$(( 10#$MIN_END - 10#$MIN_BEGIN ))
  RUNNING_TIME=$(( $RUNNING_TIME * 60 ))
  RUNNING_TIME=$(( $RUNNING_TIME + 10#$SEC_END ))
  RUNNING_TIME=$(( $RUNNING_TIME - 10#$SEC_BEGIN ))
  
  SHOW_START=`echo "The start time: $BEGIN"`
  SHOW_END=`echo "The end time: $END"`
  SHOW_DIFF=`echo "Total running time of the script: $RUNNING_TIME seconds"`
  echo $SHOW_START
  echo $SHOW_END
  echo $SHOW_DIFF
  echo $SHOW_START >> $HOME_PATH/log.txt
  echo $SHOW_END >> $HOME_PATH/log.txt
  echo $SHOW_DIFF >> $HOME_PATH/log.txt
}