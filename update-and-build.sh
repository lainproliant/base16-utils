#!/bin/sh
rm -rf ./output ./schemes ./sources ./templates
pybase16 update -c
pybase16 build
