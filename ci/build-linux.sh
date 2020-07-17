#!/bin/bash

# 1) Fetch the dependencies

if [$TESTLIB_PASSWORD -eq ""]; then
	echo "Error! No password provided for TESTLIB zip. Aborting."
	exit 1
fi

mkdir ../dependencies
cd ..
export TESTLIB_DIR=$(pwd)/dependencies/
cd dependencies
cp ../../SampleGithubCI-Deps/testlib.zip ./
unzip -P $TESTLIB_PASSWORD testlib.zip

# 2) Build from source

mkdir -p ../build/release
cd ../build/release

cmake -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../..
if [ $RESULT -ne 0 ]; then
  echo "CMAKE generation failed. Aborting."
  exit 1
fi

make -j
if [ $RESULT -ne 0 ]; then
  echo "Compilation failed. Aborting."
  exit 1
fi
