#!/bin/bash

# June 30th: trend test for typed data for QC cleared individuals and SNPs

for chr in {1..22}
do

../../plink-1.07-i686/plink  --bfile eur-"$chr" --keep discovery-id.txt --extract clean-hwe-eur-snps.txt --logistic --beta
cp plink.model eur-$chr.model

../../plink-1.07-i686/plink  --bfile lat-"$chr" --keep discovery-id.txt --extract clean-hwe-lat-snps.txt --logistic --beta
cp plink.model lat-$chr.model

../../plink-1.07-i686/plink  --bfile afr-"$chr" --keep discovery-id.txt --extract clean-hwe-afr-snps.txt --logistic --beta
cp plink.model afr-$chr.model

echo chromosome $chr done
done


