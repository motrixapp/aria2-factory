# Dockerfile to build aria2 Linux binary using Ubuntu compiler chain.
#
# $ sudo docker build -t aria2-linux - < Dockerfile
#
# After successful build, Linux binary is located at
# /aria2/src/aria2c.  You can copy the binary using following
# commands:
#
# $ id=$(sudo docker create aria2-linux)
# $ sudo docker cp $id:/aria2/src/aria2c <dest>
# $ sudo docker rm -v $id

FROM ubuntu:22.04

# It would be better to use nearest ubuntu archive mirror for faster
# downloads.
# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list

# Install libs
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git wget curl build-essential ca-certificates autopoint autoconf \
        gettext libtool pkg-config libcppunit-dev

RUN curl https://raw.githubusercontent.com/q3aql/aria2-static-builds/master/build-scripts/gnu-linux-config/aria2-x86_64-gnu-linux-build-libs | bash

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
    curl https://raw.githubusercontent.com/q3aql/aria2-static-builds/master/build-scripts/gnu-linux-config/aria2-x86_64-gnu-linux-config | bash

RUN cd aria2 && \
    make -j$(cat /proc/cpuinfo| grep "processor"| wc -l) && \
    strip src/aria2c
