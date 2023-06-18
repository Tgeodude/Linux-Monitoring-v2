#!/bin/bash

function s21_check {
    pattern_1='^[a-zA-Z]{1,7}$'
    pattern_2='^[a-zA-Z]{1,7}.[a-zA-Z]{1,3}$'
    pattern_3='^([1-9]|([1-9][0-9])|100)Mb$'

    if ! [[ $1 =~ $pattern_1 ]]
  then
    echo "ILLEGAL PARAMETERS: arg 3. Enter a list of English alphabet letters (no more than 7 characters). "
    return 2
  fi

    if ! [[ $2 =~ $pattern_2 ]]
  then 
    echo "ILLEGAL PARAMETERS: arg 5. Enter no more than 7 characters for the name, no more than 3 characters for the extension"
    return 2
  fi

    if ! [[ $3 =~ $pattern_3 ]]
  then 
    echo "ILLEGAL PARAMETERS: arg 6. Enter file size (in Mb, but not more than 100)"
    return 2
  fi
}