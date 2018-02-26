#!/bin/sh

BASE_DIR=$(dirname $(readlink -f "$0"))
if [ "$1" != "test" ]
then
    psql -h localhost -U myspace -d myspace < $BASE_DIR/myspace.sql
fi
psql -h localhost -U myspace -d myspace_test < $BASE_DIR/myspace.sql
