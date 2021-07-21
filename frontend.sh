#!/usr/bin/env bash

source common.sh

printf  "Installing Nginx"
yum install nginx -y &>>$log
status_check $?

printf "Downloading the frontend content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$log
status_check $?

printf "Removing default content from Nginx"
cd /usr/share/nginx/html &>>$log && rm -rf * &>>$log
status_check $?

printf "Extracting the content"
unzip /tmp/frontend.zip &>>$log && mv frontend-main/* . &>>$log && mv static/* . &>>$log && rm -rf frontend-master static &>>$log
status_check $?

printf "Updating Roboshop Config by moving it to Nginx default d file"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$log
status_check $?

printf "Update Roboshop Config"
sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/' -e '/user/ s/localhost/user.roboshop.internal/'  -e '/cart/ s/localhost/cart.roboshop.internal/' -e '/shipping/ s/localhost/shipping.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
status_check $?

printf  "Enabling  Nginx"
systemctl enable nginx &>>$log
status_check $?

printf  "Starting Nginx"
systemctl start nginx &>>$log
status_check $?


