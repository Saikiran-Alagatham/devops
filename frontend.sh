#!/usr/bin/env bash

source common.sh

echo -n -e "\e[32mInstalling Nginx ....\e[0m \t"
yum install nginx -y &>>$log
status_check $?

echo  -n -e "\e[32mEnabling  Nginx ....\e[0m "
systemctl enable nginx &>>$log
status_check $?

echo  -n -e "\e[32mStarting Nginx ....\e[0m "
systemctl start nginx &>>$log
status_check $?


