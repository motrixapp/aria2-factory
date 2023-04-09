#!/bin/sh -e

# Create output directory if it doesn't exist
directory="./output/"

if [ ! -d "$directory" ]; then
  mkdir -p "$directory"
fi

# Docker build image
sudo docker build -t aria2-linux-x86_64 - < Dockerfile

# Docker create container
id=$(sudo docker create aria2-linux-x86_64)

# Copy output bin
sudo docker cp $id:/aria2/src/aria2c $directory

# Docker remove container
sudo docker rm -v $id
