#!/usr/bin/env bash

source common.sh

printf  "Installing Nginx .... "
yum install nginx -y &>>$log
status_check $?

printf  "Enabling  Nginx .... "
systemctl enable nginx &>>$log
status_check $?

printf  "Starting Nginx .... "
systemctl start nginx &>>$log
status_check $?


