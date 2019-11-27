#!/bin/bash

./verify_clear_int_tiles.sh cl_with_holes.dcp

java -Xmx2G edu.stanford.fleet.rw.MergeShellKernel $1
