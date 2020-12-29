#!/bin/sh

cat formula.txt | xargs brew install --formula
cat cask.txt    | xargs brew install --cask
