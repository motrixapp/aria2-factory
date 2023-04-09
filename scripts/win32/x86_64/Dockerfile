# Dockerfile to build aria2 Windows binary using ubuntu mingw-w64
# cross compiler chain.
#
# $ sudo docker build -t aria2-mingw - < Dockerfile.mingw
#
# After successful build, windows binary is located at
# /aria2/src/aria2c.exe.  You can copy the binary using following
# commands:
#
# $ id=$(sudo docker create aria2-mingw)
# $ sudo docker cp $id:/aria2/src/aria2c.exe <dest>
# $ sudo docker rm -v $id

FROM ubuntu:22.04

# Change HOST to x86_64-w64-mingw32 to build 64-bit binary
ENV HOST x86_64-w64-mingw32

# It would be better to use nearest ubuntu archive mirror for faster
# downloads.
# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list

# Install libs
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y --no-install-recommends \
        git wget curl binutils autoconf automake autotools-dev libtool \
        patch ca-certificates make \
        pkg-config dpkg-dev gcc-mingw-w64 g++-mingw-w64 \
        autopoint libcppunit-dev libxml2-dev libgcrypt20-dev lzip

RUN curl https://raw.githubusercontent.com/q3aql/aria2-static-builds/master/build-scripts/mingw-config/aria2-x86_64-w64-mingw-build-libs | bash

ADD https://api.github.com/repos/aria2/aria2/git/refs/heads/master version.json

# Clone source code
RUN git clone https://github.com/aria2/aria2.git && \
    cd aria2 && \
    mkdir patches && \
    cd patches && \
    wget https://raw.githubusercontent.com/motrixapp/aria2-factory/master/patches/0001-options-unlock-connection-per-server-limit.patch && \
    wget https://raw.githubusercontent.com/motrixapp/aria2-factory/master/patches/0002-download-retry-on-slow-speed-and-reset.patch && \
    wget https://raw.githubusercontent.com/motrixapp/aria2-factory/master/patches/0003-option-add-option-to-retry-on-http-4xx.patch && \
    cd .. && \
    git apply patches/*.patch && \
    autoreconf -i && \
    curl https://raw.githubusercontent.com/q3aql/aria2-static-builds/master/build-scripts/mingw-config/aria2-x86_64-w64-mingw-config | bash

RUN cd aria2 && \
    make -j$(cat /proc/cpuinfo| grep "processor"| wc -l) && \
    $HOST-strip -s src/aria2c.exe
