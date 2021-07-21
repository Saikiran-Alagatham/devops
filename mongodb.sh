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
yum install -y mongodb-org
status_check $?





printf  "Enabling  Nginx"
systemctl enable mongod &>>$log
status_check $?

printf  "Starting Nginx"
systemctl start mongod &>>$log
status_check $?
