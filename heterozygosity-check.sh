#!/bin/bash

# June 22th: this code generates the sample heterozygosity across all SNP. Splitting all individuals into smaller sets of 1000 individuals
# splitting done by:
# awk '{print $1,$2}' clean_relcheck.txt | split -d -a 3 -l 1000 - split-subjects

rm all-chips-het.txt
rm *-het-*.het

#for i in {0..9}
#do
#cp split-subjects00$i split-subjects

#for chr in {1..22}
#do
#../../plink-1.07-i686/plink  --bfile eur-"$chr" --keep split-subjects --extract eur-rs-nondi-"$chr".txt --make-bed --out eur-reduced-"$chr"

#../../plink-1.07-i686/plink  --bfile lat-"$chr" --keep split-subjects --extract lat-rs-nondi-"$chr".txt --make-bed --out lat-reduced-"$chr"

#../../plink-1.07-i686/plink  --bfile afr-"$chr" --keep split-subjects --extract afr-rs-nondi-"$chr".txt --make-bed --out afr-reduced-"$chr"

#../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep split-subjects --extract eas-rs-nondi-"$chr".txt --make-bed --out eas-reduced-"$chr"

#echo chromosome $chr done
#done

#../../plink-1.07-i686/plink --bfile eur-reduced-1 --merge-list eur-allchr-list.txt --make-bed --out eur-reduced-allchr

#../../plink-1.07-i686/plink --bfile eur-reduced-allchr --het --out eur-het-"$i"

#../../plink-1.07-i686/plink --bfile lat-reduced-1 --merge-list lat-allchr-list.txt --make-bed --out lat-reduced-allchr

#../../plink-1.07-i686/plink --bfile lat-reduced-allchr --het --out lat-het-"$i"

#../../plink-1.07-i686/plink --bfile afr-reduced-1 --merge-list afr-allchr-list.txt --make-bed --out afr-reduced-allchr

#../../plink-1.07-i686/plink --bfile afr-reduced-allchr --het --out afr-het-"$i"

#../../plink-1.07-i686/plink --bfile eas-reduced-1 --merge-list eas-allchr-list.txt --make-bed --out eas-reduced-allchr

#../../plink-1.07-i686/plink --bfile eas-reduced-allchr --het --out eas-het-"$i"

#echo file $i done
#done

for i in {40..73}
do
cp split-subjects0$i split-subjects

for chr in {1..22}
do

../../plink-1.07-i686/plink  --bfile eur-"$chr" --keep split-subjects --extract eur-rs-nondi-"$chr".txt --make-bed --out eur-reduced-"$chr"

../../plink-1.07-i686/plink  --bfile lat-"$chr" --keep split-subjects --extract lat-rs-nondi-"$chr".txt --make-bed --out lat-reduced-"$chr"

../../plink-1.07-i686/plink  --bfile afr-"$chr" --keep split-subjects --extract afr-rs-nondi-"$chr".txt --make-bed --out afr-reduced-"$chr"

../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep split-subjects --extract eas-rs-nondi-"$chr".txt --make-bed --out eas-reduced-"$chr"

echo chromosome $chr done
done

../../plink-1.07-i686/plink --bfile eur-reduced-1 --merge-list eur-allchr-list.txt --make-bed --out eur-reduced-allchr

../../plink-1.07-i686/plink --bfile eur-reduced-allchr --het --out eur-het-"$i"

../../plink-1.07-i686/plink --bfile lat-reduced-1 --merge-list lat-allchr-list.txt --make-bed --out lat-reduced-allchr

../../plink-1.07-i686/plink --bfile lat-reduced-allchr --het --out lat-het-"$i"

../../plink-1.07-i686/plink --bfile afr-reduced-1 --merge-list afr-allchr-list.txt --make-bed --out afr-reduced-allchr

../../plink-1.07-i686/plink --bfile afr-reduced-allchr --het --out afr-het-"$i"

../../plink-1.07-i686/plink --bfile eas-reduced-1 --merge-list eas-allchr-list.txt --make-bed --out eas-reduced-allchr

../../plink-1.07-i686/plink --bfile eas-reduced-allchr --het --out eas-het-"$i"

echo file $i done
done

cat eur-het-*.het lat-het-*.het afr-het-*.het eas-het-*.het > all-chips-het-ventana.txt


