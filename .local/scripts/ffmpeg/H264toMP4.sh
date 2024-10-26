#!/usr/bin/env bash

for file in ./*.h264
do
    echo 'processing ${file}'
    ffmpeg -framerate 24 -i ${file}  -c copy ${file}.mp4
done
echo 'finish!'
