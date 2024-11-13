#!/bin/bash

# Download the tokenizer file
git clone https://github.com/llm-jp/llm-jp-tokenizer

# checkout this branch
git checkout llm-jp-mac

# initilize sentencepiece module
git submodule update --init       

# build sentencepiece
cd sentencepiece
mkdir build
cd build
export CXX=g++-14
cmake ..
make
cd ../..
ln -s sentencepiece/build/src/libsentencepiece.0.dylib

# build
make

# download a weight file (1.8B model)
curl -O https://galaxy.u-aizu.ac.jp/2024/llama3/llm-jp-3-1.8b_q8.bin
