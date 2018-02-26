#!/bin/sh

if [ "$1" = "travis" ]
then
    psql -U postgres -c "CREATE DATABASE myspace_test;"
    psql -U postgres -c "CREATE USER myspace PASSWORD 'myspace' SUPERUSER;"
else
    [ "$1" != "test" ] && sudo -u postgres dropdb --if-exists myspace
    [ "$1" != "test" ] && sudo -u postgres dropdb --if-exists myspace_test
    [ "$1" != "test" ] && sudo -u postgres dropuser --if-exists myspace
    sudo -u postgres psql -c "CREATE USER myspace PASSWORD 'myspace' SUPERUSER;"
    [ "$1" != "test" ] && sudo -u postgres createdb -O myspace myspace
    sudo -u postgres createdb -O myspace myspace_test
    LINE="localhost:5432:*:myspace:myspace"
    FILE=~/.pgpass
    if [ ! -f $FILE ]
    then
        touch $FILE
        chmod 600 $FILE
    fi
    if ! grep -qsF "$LINE" $FILE
    then
        echo "$LINE" >> $FILE
    fi
fi
