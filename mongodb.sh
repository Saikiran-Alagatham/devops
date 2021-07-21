#!/usr/bin/env bash

source common.sh
# Downloading MongoDB from its git repo and setting up
printf  "Setting up the repo MongoDB"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
status_check $?

printf  "Installing MongoDB"
yum install -y mongodb-org &>>$log
status_check $?

printf "Updating the Ip address, so that MongoDB will listen to all"
sed -i -e 's/127.0.0.1/0.0.0.0' /etc/mongod.conf &>>$log
status_check $?



printf  "Enabling  MongoDB"
systemctl enable mongod &>>$log
status_check $?

printf  "Starting MongoDB"
systemctl start mongod &>>$log
status_check $?

printf "Downloading the schema into MongoDB"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$log
status_check $?

printf "Loading the schema into MongoDB"
cd /tmp &>>$log && unzip -o mongodb.zip &>>$log && cd mongodb-main &>>$log && mongo < catalogue.js &>>$log && mongo < users.js &>>$log
status_check $?
