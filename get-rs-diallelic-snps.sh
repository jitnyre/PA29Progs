#!/bin/bash

# June 16th: this code gives only rs and nondiallelic SNPs

for chr in {1..25}
do

grep 'rs' eur-$chr.bim | grep -v "-" >  eur-rs-nondi-$chr.txt

grep 'rs' afr-$chr.bim | grep -v "-" >  afr-rs-nondi-$chr.txt

grep 'rs' lat-$chr.bim | grep -v "-" >  lat-rs-nondi-$chr.txt

grep 'rs' eas-$chr.bim | grep -v "-" >  eas-rs-nondi-$chr.txt

echo $chr done
done

exit


