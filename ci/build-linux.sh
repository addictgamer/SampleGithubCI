#!/bin/bash

# 1) Fetch the dependencies

if [ -z $TESTLIB_PASSWORD ]; then
	echo "Error! No password provided for TESTLIB zip. Aborting."
	exit 1
fi

# 1.a) Create dependencies directory.
mkdir ../dependencies
cd ..
export TESTLIB_DIR=$(pwd)/dependencies/
cd dependencies

# 1.b) Fetch TESTLIB dependency.
wget https://github.com/addictgamer/SampleGithubCI-Deps/files/4935989/testlib.zip -O testlib.zip
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "Fetching TESTLIB failed. Aborting."
  exit $RESULT
fi

# 1.c) Provision TESTLIB dependency. (password protected, pass in through an environment variable!!)
unzip -P $TESTLIB_PASSWORD testlib.zip
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "Unzipping TESTLIB failed. Aborting."
  exit $RESULT
fi

# 2) Build from source

mkdir -p ../build/release
cd ../build/release

cmake -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../..
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "CMAKE generation failed. Aborting."
  exit $RESULT
fi

make -j
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "Compilation failed. Aborting."
  exit $RESULT
fi
