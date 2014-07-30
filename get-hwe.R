## take only 'ALL' lines of plink.hwe
eas = read.table("eas-22-1.hwe")
afr = read.table("afr-22-1.hwe")
m = match(as.character(eas[,2]), as.character(afr[,2]))
eas_afr = cbind(eas, afr[m,])
common = eas_afr[which(is.na(m) == FALSE),]
geno = as.integer(unlist(strsplit(as.character(common[1,6]),"/")))
geno1 = as.integer(unlist(strsplit(as.character(common[1,15]),"/")))
phat = (2*(geno[1]+geno1[1]) + (geno[2] + geno1[2]))/(2*(sum(geno) + sum(geno1)))
qhat = 1-phat
expec = c(phat^2, 2*phat*qhat, qhat^2)*(sum(geno) + sum(geno1))
chitest = sum(((geno + geno1) - expec)^2/expec)
1 - pchisq(chitest, df = 1)

