#!/bin/bash

# June 18th: this code checks the sex of each individuals from their sex chromosome 

rm all-chips.sexcheck

../../plink-1.07-i686/plink  --bfile eur-23 --keep clean-call-casectl-052814.txt --extract eur-rs-nondi-23.txt --check-sex
mv plink.sexcheck eur-sexcheck

../../plink-1.07-i686/plink  --bfile lat-23 --keep clean-call-casectl-052814.txt --extract lat-rs-nondi-23.txt --check-sex
mv plink.sexcheck lat-sexcheck

../../plink-1.07-i686/plink  --bfile afr-23 --keep clean-call-casectl-052814.txt --extract afr-rs-nondi-23.txt --check-sex
mv plink.sexcheck afr-sexcheck

#awk '{if($1 == 23 && $6 != "-") print $0}' eas_only_snps.txt | grep 'rs' > eas-rs-chr23.txt

../../plink-1.07-i686/plink  --bfile eas-23 --keep clean-call-casectl-052814.txt --extract eas-rs-nondi-23.txt --check-sex
mv plink.sexcheck eas-sexcheck

cat eur-sexcheck lat-sexcheck afr-sexcheck eas-sexcheck > all-chips.sexcheck

grep 'PROBLEM' all-chips.sexcheck > sex-mismatch.txt

## sex chromosome certain though pedigree was uncertain, we take the sex as assigned by PLINK
awk '{if($4 !=0) print $1, $2}' sex-mismatch.txt > sex-from-plink.txt

grep 'OK' all-chips.sexcheck | awk '{print $1, $2}' > sex-ok.txt

cat sex-from-plink.txt sex-ok.txt > clean_sex.txt

exit


