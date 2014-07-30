#!/bin/bash

# July 10th: for sex chr 23

#set chr = 23

for chr in 23
do
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

awk '{if($5 >= 0.01 && $5 < 0.5) print $0}' maf-$chr.txt > clean-maf-$chr.txt
done

# get SNPs with -log10(HWE) < 6 after cleaning SNPs for MAF
#R CMD BATCH get-hwe-snps-sexchr.R
