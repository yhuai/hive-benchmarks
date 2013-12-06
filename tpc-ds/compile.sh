#!/bin/bash

OS=$1
cp ./conf/Makefile.$OS ./tpcds-kit/tools/makefile
cd ./tpcds-kit/tools/
make
