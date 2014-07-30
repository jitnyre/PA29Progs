#!/bin/bash

awk '{if($5 < 0.001 || $5 > 0.6) print $0}' all-chips-controls.frq > controls-lohi-maf.txt

awk '{if($9 < 0.00000000001) print $0}' all-chips-controls.hwe > controls-lohweP.txt

exit
