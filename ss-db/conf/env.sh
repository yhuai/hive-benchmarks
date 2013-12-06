#!/bin/bash

# SS-DB

# The url of git repo
REPO_URL="https://github.com/yhuai/SS-DB-MySQL.git"
# The path to data gen
DBGEN_TOOL_DIR="SS-DB-MySQL"
# Compiling command
COMPILE_CMD="cmake ./ && make"

# Scale factor
SCALE="large"

# The root directory of external tables
EXTERNAL_DIR="/user/hive/external/ssdb"

# Tables in this benchmark
TABLES="cycle"

# In SS-DB, the entire dataset comprises multiple images and several images form a cycle.
# Here is detailed information for every scale.
# tiny: the tiny dataset has totally 10 cycles and every cycle has 1 image (10 images in total).
# small: the small dataset has 8 cycles and every cycle has 20 images (160 images in total).
# normal: the normal dataset has 20 cycles and every cycle has 20 images (400 images in total).
# large: the large dataset has 50 cycles and every cycle has 20 images (1000 images in total).

# The total number of chunks. The entire dataset will be divided into this number of chunks.
# In SS-DB, 1 image is a chunk. So, this number should be set according to the total number
# of images. 
CHUNK_NUM=1000

IMAGES_PER_CYCLE_TINY=1
IMAGES_PER_CYCLE_SMALL=20
IMAGES_PER_CYCLE_NORMAL=20
IMAGES_PER_CYCLE_LARGE=20
# The number of images in a cycle. This number should be set according to the scale factor.
IMAGES_PER_CYCLE=$IMAGES_PER_CYCLE_LARGE
