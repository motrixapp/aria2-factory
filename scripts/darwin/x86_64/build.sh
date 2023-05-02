#!/bin/sh -e

# Git clone aria2 repo
mkdir tmp && cd tmp
git clone https://github.com/aria2/aria2.git
cd aria2

# Download patches and apply
mkdir patches
cd patches
wget https://raw.githubusercontent.com/motrixapp/aria2-factory/master/patches/common/0001-options-unlock-connection-per-server-limit.patch
wget https://raw.githubusercontent.com/motrixapp/aria2-factory/master/patches/common/0002-download-retry-on-slow-speed-and-reset.patch
wget https://raw.githubusercontent.com/motrixapp/aria2-factory/master/patches/common/0003-option-add-option-to-retry-on-http-4xx.patch
wget https://raw.githubusercontent.com/motrixapp/aria2-factory/master/patches/darwin/fix_darwin_x86_64_deps.patch
cd ..
git apply patches/*.patch

# Create python venv and install sphinx
python3 -m venv build-release
. build-release/bin/activate
pip3 install -U sphinx

autoreconf -i

rm -f Makefile
ln -s ./makerelease-osx.mk Makefile

NON_RELEASE=1 make -j$(sysctl -n hw.ncpu)