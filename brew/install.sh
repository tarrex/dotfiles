#!/bin/sh

cat formula.list | xargs brew install --formula
cat cask.list    | xargs brew install --cask
