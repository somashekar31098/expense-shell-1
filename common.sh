#!/bin/bash

set -e
 
handle_error(){
    echo "error occured at line number: $1 , error command: $2"
}

trap 'handle_error ${LINENO} "$BASH_COMMAND"' ERR

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"


Validate(){
    if [ $1 -ne 0 ]
  then 
    echo -e "$2 is ....$R failure $N"
    exit 1
 else
    echo -e "$2 is ....$G sucess $N"
    fi
}

check_root(){
    if [ $USERID -ne  0 ]
then 
   echo "run the script with root access"
   exit 1
else
   echo "you are super user"
fi
}