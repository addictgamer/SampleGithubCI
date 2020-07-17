#!/bin/bash

# 1) Fetch the dependencies

mkdir ../dependencies
export TESTLIB_DIR=$(pwd)/../dependencies/

# 2) Build from source

mkdir -p ../build/release
cd ../build/release

cmake -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../..
if [ $RESULT -ne 0 ]; then
  echo "CMAKE generation failed, aborting."
  exit 1
fi

make -j
if [ $RESULT -ne 0 ]; then
  echo "Compilation failed, aborting."
  exit 1
fi
