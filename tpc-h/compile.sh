#!/bin/bash

OS=$1
cp ./conf/makefile.$OS ./tpch-kit/dbgen/makefile
cd ./tpch-kit/dbgen/
make
