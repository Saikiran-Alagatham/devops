#!/usr/bin/env bash

source common.sh

echo -e "\e[32mInstalling Nginx ....\e[0m "
yum install nginx -y &>>$log
status_check $?

echo  "\e[32mEnabling  Nginx ....\e[0m "
systemctl enable nginx &>>$log
status_check $?

echo  "\e[32mStarting Nginx ....\e[0m "
systemctl start nginx &>>$log
status_check $?


