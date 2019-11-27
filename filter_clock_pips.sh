#!/bin/bash

START_LINE=$(($(grep -n "^INT" ${1}_clock_pips_unfiltered${2}.txt | head -n 1 | cut -d: -f 1) - 2))
echo "Removing first $(($START_LINE - 1)) lines from ${1}_clock_pips_unfiltered${2}..."
cat ${1}_clock_pips_unfiltered${2}.txt | tail -n +$START_LINE > ${1}_clock_pips${2}.txt
