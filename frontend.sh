#!/usr/bin/env bash

source common.sh

echo  "Installing Nginx .... "
yum install nginx -y &>>$log
status_check $?

echo  "Enabling  Nginx .... "
systemctl enable nginx &>>$log
status_check $?

echo  "Starting Nginx .... "
systemctl start nginx &>>$log
status_check $?


