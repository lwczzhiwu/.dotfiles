#!/bin/sh
if [ -z "$1" ]
then
    echo -e -n '==>please input python codename\n'
else
    conf=~/.pylint.conf
    if [[ "$1" == *.py ]];then
        echo -e -n '======check coding======\n'
        if [ -z "$2" ]
        then
            pylint --rcfile=$conf --reports=n $1
        else
            pylint --rcfile=$conf --reports=y $1
        fi
    else
        echo -e -n '======check list ids======\n'
        pylint --rcfile=$conf --list | grep $1
    fi
fi
