#!/usr/bin/env bash

source common.sh

printf  "Installing NodeJS"
yum install nodejs make gcc-c++ -y &>>$log
status_check $?


printf  "Adding roboshop daemon user "
id roboshop &>>$log
if [ $? -ne 0 ] ; then
  useradd roboshop &>>$log
fi
status_check $?

printf "Downloading the Code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$log
status_check $?

printf "Extracting downloaded Code"
cd /home/roboshop && unzip /tmp/catalogue.zip &>>$log && rm -rf catalogue &>>$log && mv catalogue-main catalogue &>>$log
status_check $?

printf "Installing NodeJs dependencies"
cd /home/roboshop/catalogue && npm install --unsafe-perm &>>$log
status_check $?

printf "Fixing the permissions"
chown roboshop:roboshop /home/roboshop -R &>>$log
status_check $?

printf "Setting up SystemD file"
sed -i -e "s/MONGO_DNSNAME/mongodb.roboshop.internal/" /home/roboshop/catalogue/systemd.service && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>$log
status_check $?

printf "Starting the catalogue Service"
systemctl daemon-reload >>$log && systemctl start catalogue>>$log && systemctl enable catalogue>>$log
status_check $?