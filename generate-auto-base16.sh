#!/bin/bash
#
# auto-base16-generate.sh
#
# Author: Lain Musgrove (lain.proliant@gmail.com)
# Date: Wednesday March 24, 2021
#
# Distributed under terms of the MIT license.
#

./schemer2 -format img::colors -in `nextbg -P` -out colors.txt
mkdir -p ./schemes/auto-base16
python3 ./auto-base16-theme/AutoBase16Theme.py ./auto-base16-theme/templates/base16-template.yaml ./schemes/auto-base16/auto-base16.yaml --inputColorPaletteFile colors.txt
./apply.sh auto-base16
