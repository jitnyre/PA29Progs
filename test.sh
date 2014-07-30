#!/bin/bash

# May 28th: this code generates the sample heterozygosity across all SNP. Splitting EUR individuals into smaller sets of 1000 individuals

for i in {0..0}
do
cp split-subjects00$i split-subjects

for chr in {1..22}
do
#../../plink-1.07-i686/plink  --bfile eur-"$chr" --keep split-subjects --make-bed --out eur-reduced-"$chr"

../../plink-1.07-i686/plink  --bfile lat-"$chr" --keep split-subjects --make-bed --out lat-reduced-"$chr"

../../plink-1.07-i686/plink  --bfile afr-"$chr" --keep split-subjects --make-bed --out afr-reduced-"$chr"

../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep split-subjects --make-bed --out eas-reduced-"$chr"

echo chromosome $chr done
done

#../../plink-1.07-i686/plink --bfile eur-reduced-1 --merge-list eur-allchr.txt --make-bed --out eur-reduced-allchr

#../../plink-1.07-i686/plink --bfile eur-reduced-allchr --het --out eur-het-"$i"

../../plink-1.07-i686/plink --bfile lat-reduced-1 --merge-list lat-allchr.txt --make-bed --out lat-reduced-allchr

../../plink-1.07-i686/plink --bfile lat-reduced-allchr --het --out lat-het-"$i"

../../plink-1.07-i686/plink --bfile afr-reduced-1 --merge-list afr-allchr.txt --make-bed --out afr-reduced-allchr

../../plink-1.07-i686/plink --bfile afr-reduced-allchr --het --out afr-het-"$i"

../../plink-1.07-i686/plink --bfile eas-reduced-1 --merge-list eas-allchr.txt --make-bed --out eas-reduced-allchr

../../plink-1.07-i686/plink --bfile eas-reduced-allchr --het --out eas-het-"$i"

echo file $i done
done


