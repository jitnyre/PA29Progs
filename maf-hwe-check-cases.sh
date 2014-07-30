#!/bin/bash

# June 3rd: this code calculates MAF and HWE of each SNP 
# June 4th: rereunning this code on the clean sex, heterozygosity, call rate individuals: clean_het_callrate_id.txt 77,262 individuals

rm all-chips-cases.frq
rm all-chips-cases.hwe

rm eur-*.frq
rm lat-*.frq
rm afr-*.frq
rm eas-*.frq

rm eur-*.hwe
rm lat-*.hwe
rm afr-*.hwe
rm eas-*.hwe

for chr in {1..22}

#for chr in 23 25
do
../../plink-1.07-i686/plink  --bfile eur-"$chr" --keep clean_cases.txt --extract eur-rs.txt --freq
mv plink.frq eur-$chr.frq
../../plink-1.07-i686/plink  --bfile eur-"$chr" --keep clean_cases.txt --extract eur-rs.txt --hardy2
mv plink.hwe eur-$chr.hwe

../../plink-1.07-i686/plink  --bfile lat-"$chr" --keep clean_cases.txt --extract lat-rs.txt --freq 
mv plink.frq lat-$chr.frq
../../plink-1.07-i686/plink  --bfile lat-"$chr" --keep clean_cases.txt --extract lat-rs.txt --hardy2
mv plink.hwe lat-$chr.hwe

../../plink-1.07-i686/plink  --bfile afr-"$chr" --keep clean_cases.txt --extract afr-rs.txt --freq
mv plink.frq afr-$chr.frq
../../plink-1.07-i686/plink  --bfile afr-"$chr" --keep clean_cases.txt --extract afr-rs.txt --hardy2
mv plink.hwe afr-$chr.hwe

../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep clean_cases.txt --extract eas-rs.txt --freq
mv plink.frq eas-$chr.frq
../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep clean_cases.txt --extract eas-rs.txt --hardy2
mv plink.hwe eas-$chr.hwe

cat eur-*.frq lat-*.frq afr-*.frq eas-*.frq >> all-chips-cases.frq
cat eur-*.hwe lat-*.hwe afr-*.hwe eas-*.hwe >> all-chips-cases.hwe

#cat eur.frq lat.frq afr.frq eas.frq >> sexchr-chips.frq
#cat eur.hwe lat.hwe afr.hwe eas.hwe >> sexchr-chips.hwe

echo chromosome $chr done
done



