#!/bin/bash

# June 3rd: this code calculates MAF and HWE of each SNP 
# June 4th: rereunning this code on the clean sex, heterozygosity, call rate individuals: clean_het_callrate_id.txt 77,262 individuals

#rm all-chips-common.frq
#rm all-chips-common.hwe

#rm eur-*.frq
#rm lat-*.frq
#rm afr-*.frq
#rm eas-*.frq

#rm eur-*.hwe
#rm lat-*.hwe
#rm afr-*.hwe
#rm eas-*.hwe

for chr in {1..22}

#for chr in 23 25
do
../../plink-1.07-i686/plink  --bfile eur-"$chr" --keep clean_het_callrate_id.txt --extract eur-rs.txt --freq
mv plink.frq eur.frq
../../plink-1.07-i686/plink  --bfile eur-"$chr" --keep clean_het_callrate_id.txt --extract eur-rs.txt --hardy2
grep 'ALL' plink.hwe > eur.hwe
#rm plink.hwe

../../plink-1.07-i686/plink  --bfile lat-"$chr" --keep clean_het_callrate_id.txt --extract lat-rs.txt --freq 
mv plink.frq lat.frq
../../plink-1.07-i686/plink  --bfile lat-"$chr" --keep clean_het_callrate_id.txt --extract lat-rs.txt --hardy2
grep 'ALL' plink.hwe > lat.hwe
#rm plink.hwe

../../plink-1.07-i686/plink  --bfile afr-"$chr" --keep clean_het_callrate_id.txt --extract afr-rs.txt --freq
mv plink.frq afr.frq
../../plink-1.07-i686/plink  --bfile afr-"$chr" --keep clean_het_callrate_id.txt --extract afr-rs.txt --hardy2
grep 'ALL' plink.hwe > afr.hwe
#rm plink.hwe

../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep clean_het_callrate_id.txt --extract eas-rs.txt --freq
mv plink.frq eas.frq
../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep clean_het_callrate_id.txt --extract eas-rs.txt --hardy2
grep 'ALL' plink.hwe > eas.hwe
#rm plink.hwe

rm maf_*.txt
rm hwe_*.txt
R CMD BATCH 3chips-maf-hwe.R
cat maf_*.txt > maf-$chr.txt 
cat hwe_*.txt > hwe-$chr.txt

echo chromosome $chr done
done



