#!/bin/bash

find schemes -name \*.yaml | xargs -I {} basename {} .yaml | sort | uniq
