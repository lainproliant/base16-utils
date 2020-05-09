#!/bin/bash

find ./templates -maxdepth 1 -type d -printf "%f\n" | sort
