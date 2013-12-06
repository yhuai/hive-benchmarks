#!/bin/bash

# TPC-H

# The url of git repo
REPO_URL="https://github.com/yhuai/tpch-kit.git"
# The path to data gen
DBGEN_TOOL_DIR="tpch-kit/dbgen"
# Compiling command
COMPILE_CMD="make"

# Scale factor
SCALE=300

# The root directory of external tables
EXTERNAL_DIR="/user/hive/external/tpch"

# Tables in this benchmark
TABLES="customer nation part region lineitem orders partsupp supplier"

# The total number of chunks. The entire dataset will be divided into this number of chunks.
CHUNK_NUM=100