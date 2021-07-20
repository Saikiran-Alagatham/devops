#!/usr/bin/env bash

source common.sh

echo  "Installing Nginx .... "
yum install nginx -y &>>$log
status_check $?

echo  "Enabling  Nginx .... "
status=$( systemctl enable nginx &>>$log)
echo $status
status_check status

echo  "Starting Nginx .... "
status=$( systemctl start nginx &>>$log )
status_check status


