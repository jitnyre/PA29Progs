#!/bin/bash

# June 19th: this code calculates MAF and HWE of each SNP 

for chr in 23
do
../../plink-1.07-i686/plink  --bfile eur-"$chr" --keep clean_het_callrate_controls_id.txt --extract eur-rs-nondi-"$chr".txt --freq
mv plink.frq eur.frq
../../plink-1.07-i686/plink  --bfile eur-"$chr" --keep clean_het_callrate_controls_id.txt --extract eur-rs-nondi-"$chr".txt --hardy2
grep 'ALL' plink.hwe > eur.hwe

../../plink-1.07-i686/plink  --bfile lat-"$chr" --keep clean_het_callrate_controls_id.txt --extract lat-rs-nondi-"$chr".txt --freq 
mv plink.frq lat.frq
../../plink-1.07-i686/plink  --bfile lat-"$chr" --keep clean_het_callrate_controls_id.txt --extract lat-rs-nondi-"$chr".txt --hardy2
grep 'ALL' plink.hwe > lat.hwe

../../plink-1.07-i686/plink  --bfile afr-"$chr" --keep clean_het_callrate_controls_id.txt --extract afr-rs-nondi-"$chr".txt --freq
mv plink.frq afr.frq
../../plink-1.07-i686/plink  --bfile afr-"$chr" --keep clean_het_callrate_controls_id.txt --extract afr-rs-nondi-"$chr".txt --hardy2
grep 'ALL' plink.hwe > afr.hwe

../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep clean_het_callrate_controls_id.txt --extract eas-rs-nondi-"$chr".txt --freq
mv plink.frq eas.frq
../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep clean_het_callrate_controls_id.txt --extract eas-rs-nondi-"$chr".txt --hardy2
grep 'ALL' plink.hwe > eas.hwe

R CMD BATCH 3chips-maf.R
R CMD BATCH 3chips-hwe1.R
cp hwe_afr_lat_notin3.txt hwe_afr_lat_notin3_$chr.txt  
cp hwe_all3.txt hwe_all3_$chr.txt           
cp hwe_eur_lat_notin3.txt hwe_eur_lat_notin3_$chr.txt 
cp hwe_lat_only.txt hwe_lat_only_$chr.txt
cp hwe_afr_only.txt hwe_afr_only_$chr.txt        
cp hwe_eur_afr_notin3.txt hwe_eur_afr_notin3_$chr.txt  
cp hwe_eur_only.txt hwe_eur_only_$chr.txt

# for maf
cp maf_afr_lat_notin3.txt maf_afr_lat_notin3_$chr.txt
cp maf_all3.txt maf_all3_$chr.txt
cp maf_eur_lat_notin3.txt maf_eur_lat_notin3_$chr.txt
cp maf_lat_only.txt maf_lat_only_$chr.txt
cp maf_afr_only.txt maf_afr_only_$chr.txt
cp maf_eur_afr_notin3.txt maf_eur_afr_notin3_$chr.txt
cp maf_eur_only.txt maf_eur_only_$chr.txt

cat maf_*_$chr.txt > maf-$chr.txt 
cat hwe_*_$chr.txt > hwe-$chr.txt

echo chromosome $chr done
done

# get SNPs with MAF >= 0.01 and < 0.5
 awk '{if($5 >= 0.01 && $5 < 0.5) print $0}' maf-eur-allchr.txt > clean-maf-eur.txt
 awk '{if($5 >= 0.01 && $5 < 0.5) print $0}' maf-afr-allchr.txt > clean-maf-afr.txt
 awk '{if($5 >= 0.01 && $5 < 0.5) print $0}' maf-lat-allchr.txt > clean-maf-lat.txt

# get SNPs with -log10(HWE) < 6 after cleaning SNPs for MAF
R CMD BATCH get-hwe-snps.R
