#!/bin/bash

#Create some .log files for practice 
#touch -d "2024-08-01" example.log  --> -d <date> Sets the file's modification time to specific date

SOURCE_DIR="/home/ec2-user/app-logs"

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

mkdir -p $SOURCE_DIR
mkdir -p $LOGS_FOLDER
echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +10)
echo "Files to be deleted: $FILES_TO_DELETE"

while read -r filepath # here filepath is the variable name
do
    echo "Deleting file: $filepath" &>>$LOG_FILE_NAME
    rm -rf $filepath
    echo "Deleted file: $filepath"
done <<< $FILES_TO_DELETE  # <<< = it provides a string or variable as input