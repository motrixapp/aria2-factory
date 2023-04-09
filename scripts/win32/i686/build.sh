#!/bin/sh -e

# Create output directory if it doesn't exist
directory="./output/"

if [ ! -d "$directory" ]; then
  mkdir -p "$directory"
fi

# Docker build image
docker build -t aria2-win32-i686 - < Dockerfile

# Docker create container
id=$(docker create aria2-win32-i686)

# Copy output bin
docker cp $id:/aria2/src/aria2c.exe ./

# Docker remove container
docker rm -v $id
