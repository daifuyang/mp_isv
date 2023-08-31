#!/bin/bash 
# This is a very simple example

for name in  `ls -1`
do
    if [ ${name} != test.sh ];then
        mysql -uroot -p123456 -hlocalhost -P3306 < ${name}
    fi
done