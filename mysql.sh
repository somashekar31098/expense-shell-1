#!/bin/bash 

source ./common.sh

check_root

echo "please provide db password"
read  mysql_root_password

dnf install mysql-server -y &>>LOGFILE
Validate $? "installing MYSQL-SERVER"

systemctl enable mysqld &>>LOGFILE
Validate $? "enabling MYSQL"

systemctl start mysqld &>>LOGFILE
Validate $? "STARTING MYSQL"

# mysql_secure_installation --set-root-pass ExpenseApp@1
# Validate $? "SETTING ROOT PASSWORD OF MYSQL"

#idempotancy nature code
 mysql -h db.daws1998.online -uroot -p${mysql_root_password} -e 'SHOW DATABASES;'
 if [ $? -ne 0 ]
   then 
      mysql_secure_installation --set-root-pass ${mysql_root_password} &>>LOGFILE
      Validate $? "root password setup"
   else
      echo -e " root password already setup .... $G SKIPPING $N"     
fi 
