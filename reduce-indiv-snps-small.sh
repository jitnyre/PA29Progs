#!/bin/bash

echo "this loop is over file pairs where each file contains 2000 people, Apr 14 @1pm"
for i in {1..1}
do
	echo "$i"
	awk 'NR=='$i'' all-small-list.txt > list.txt
	cat `awk '{print $1}' list.txt` `awk '{print $2}' list.txt` > both.txt 

for chr in {1..1}
do
../..//plink-1.07-i686/plink  --bfile eur-"$chr" --keep both.txt --extract eur_eas_afr_lat_rs.txt --thin 0.1 --make-bed --out eur-reduced-"$chr"

../../plink-1.07-i686/plink  --bfile lat-"$chr" --keep both.txt --extract eur-reduced-"$chr".bim --make-bed --out lat-reduced-"$chr"

../../plink-1.07-i686/plink  --bfile afr-"$chr" --keep both.txt --extract eur-reduced-"$chr".bim --make-bed --out afr-reduced-"$chr"

../../plink-1.07-i686/plink  --bfile eas-"$chr" --keep both.txt --extract eur-reduced-"$chr".bim --make-bed --out eas-reduced-"$chr"

done

../../plink-1.07-i686/plink --bfile eur-reduced-1 --merge-list all-chips-chr1.txt --make-bed --out all-chips-small-data-"$i"

../../plink-1.07-i686/plink --bfile all-chips-small-data-"$i" --freq
mv plink.frq plink-"$i".frq

tar zcf all-chips-small-data-"$i".tgz all-chips-small-data-"$i".bed all-chips-small-data-"$i".bim all-chips-small-data-"$i".fam
	
rm -f all-chips-small-data-"$i".bed
rm -f all-chips-small-data-"$i".bim
rm -f all-chips-small-data-"$i".fam

done
