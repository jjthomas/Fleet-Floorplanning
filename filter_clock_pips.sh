#!/bin/bash

START_LINE=$(($(grep -n "^INT" kernel_clock_pips_unfiltered${1}.txt | head -n 1 | cut -d: -f 1) - 2))
echo "Removing first $(($START_LINE - 1)) lines from kernel_clock_pips_unfiltered${1}..."
cat kernel_clock_pips_unfiltered${1}.txt | tail -n +$START_LINE > kernel_clock_pips${1}.txt
