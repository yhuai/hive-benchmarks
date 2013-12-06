#!/bin/bash

# TPC-DS

# The url of git repo
REPO_URL="https://github.com/yhuai/tpcds-kit.git"
# The path to data gen
DBGEN_TOOL_DIR="tpcds-kit/tools"
# Compiling command
COMPILE_CMD="make"

# Scale factor
SCALE=300

# The root directory of external tables
EXTERNAL_DIR="/user/hive/external/tpcds"

# Tables in this benchmark
TABLES="call_center household_demographics store_returns catalog_page income_band store_sales catalog_returns inventory time_dim catalog_sales item warehouse customer promotion web_page customer_address reason web_returns customer_demographics ship_mode web_sales date_dim store web_site"

# The total number of chunks. The entire dataset will be divided into this number of chunks.
CHUNK_NUM=100