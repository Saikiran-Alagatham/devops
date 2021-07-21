#!/usr/bin/env bash

source common.sh

printf  "Installing NodeJS"
yum install nodejs make gcc-c++ -y &>>$log
status_check $?


printf  "Adding roboshop daemon user "
useradd roboshop &>>$log
status_check $?

# yum install nodejs make gcc-c++ -y
# useradd roboshop
#$ curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
#$ cd /home/roboshop
#$ unzip /tmp/catalogue.zip
#$ mv catalogue-main catalogue
#$ cd /home/roboshop/catalogue
#$ npm install