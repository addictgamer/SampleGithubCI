#!/bin/bash

# 1) Fetch the dependencies

if [ -z $TESTLIB_PASSWORD ]; then
	echo "Error! No password provided for TESTLIB zip. Aborting."
	exit 1
fi

mkdir ../dependencies
cd ..
export TESTLIB_DIR=$(pwd)/dependencies/
cd dependencies

wget https://github.com/addictgamer/SampleGithubCI-Deps/files/4935989/testlib.zip -O testlib.zip

cp ../../SampleGithubCI-Deps/testlib.zip ./
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "Fetching TESTLIB failed. Aborting."
  exit $RESULT
fi

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
