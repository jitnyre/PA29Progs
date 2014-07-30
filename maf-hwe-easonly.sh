#!/bin/bash

# June 19th: this code calculates MAF and HWE of each SNP 


for chr in {1..22}

do
../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep clean_het_callrate_controls_id.txt --extract eas_only_snps.txt --freq
mv plink.frq eas-$chr.frq
../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep clean_het_callrate_controls_id.txt --extract eas_only_snps.txt --hardy2
grep 'ALL' plink.hwe > eas-$chr.hwe

echo chromosome $chr done
done


