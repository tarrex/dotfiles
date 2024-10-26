#!/usr/bin/env bash

for file in ./*.ts
do
    echo 'processing ${file}'
    ffmpeg -i ${file}.ts -c:v libx264 -c:a copy ${file}.mp4
done
echo 'finish!'
