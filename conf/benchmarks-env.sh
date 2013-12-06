#!/bin/bash

# The url to this repo
REPO_URL="github.com/yhuai/hive-benchmarks.git"

# The dir of the dbgen tool in every benchmark
DBGEN_DIR=dbgenTools

# Ths ssh options
SSH_OPTS="-o StrictHostKeyChecking=no -o ServerAliveInterval=30"
SSH="ssh ${SSH_OPTS}"

# The version of Hive
HIVE_VERSION="0_13"
