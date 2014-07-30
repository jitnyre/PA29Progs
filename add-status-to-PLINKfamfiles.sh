#!/bin/bash

# June 30th: this code adds the case/control status to the PLINK .fam files. The status 
# is 1 for case-discovery-id.txt ; and 0 for control-discovery-id.txt

cp eur-1.fam fam.txt
R CMD BATCH add-status-to-PLINKfamfiles.R
cp fam-status.txt eur-1.fam

cp afr-1.fam fam.txt
R CMD BATCH add-status-to-PLINKfamfiles.R
cp fam-status.txt afr-1.fam

cp lat-1.fam fam.txt
R CMD BATCH add-status-to-PLINKfamfiles.R
cp fam-status.txt lat-1.fam


for chr in {2..25}
do

cp eur-1.fam eur-$chr.fam

cp afr-1.fam afr-$chr.fam

cp lat-1.fam lat-$chr.fam

echo $chr done
done

exit


