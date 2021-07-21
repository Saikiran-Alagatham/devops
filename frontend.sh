#!/usr/bin/env bash

source common.sh

printf  "Installing Nginx .... "
yum install nginx -y &>>$log
status_check $?

printf "Downloading the frontend content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$log
status_check $?

printf "Removing default content fro Nginx"
cd /usr/share/nginx/html &>>$log && rm -rf * &>>$log

printf " Extracting the content "
unzip /tmp/frontend.zip &>>$log && mv frontend-main/* . &>>$log && mv static/* . &>>$log && rm -rf frontend-master static &>>$log

printf " Updating Roboshop Config by moving it to Nginx default d filr"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$log


printf  "Enabling  Nginx .... "
systemctl enable nginx &>>$log
status_check $?

printf  "Starting Nginx .... "
systemctl start nginx &>>$log
status_check $?


