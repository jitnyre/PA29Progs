maf_eur = read.table("clean-maf-eur.txt")
hwe_eur = read.table("hwe-eur-allchr.txt")
m = match(maf_eur[,2], hwe_eur[,2])
hwe_eur1 = cbind(maf_eur, hwe_eur[m,])
logp = -log10(hwe_eur1$V6)
hwe_eur2 = cbind(hwe_eur1, logp)

hwe_eur3 = subset(hwe_eur2, hwe_eur2$logp <= 6)
write.table(hwe_eur3[,c(1:4,11)], "clean-hwe-eur.txt", row.names = FALSE,col.names = FALSE, quote = FALSE)

maf_afr = read.table("clean-maf-afr.txt")
hwe_afr = read.table("hwe-afr-allchr.txt")
m = match(maf_afr[,2], hwe_afr[,2])
hwe_afr1 = cbind(maf_afr, hwe_afr[m,])
logp = -log10(hwe_afr1$V6)
hwe_afr2 = cbind(hwe_afr1, logp)

hwe_afr3 = subset(hwe_afr2, hwe_afr2$logp <= 6)
write.table(hwe_afr3[,c(1:4,11)], "clean-hwe-afr.txt", row.names = FALSE,col.names = FALSE, quote = FALSE)

maf_lat = read.table("clean-maf-lat.txt")
hwe_lat = read.table("hwe-lat-allchr.txt")
m = match(maf_lat[,2], hwe_lat[,2])
hwe_lat1 = cbind(maf_lat, hwe_lat[m,])
logp = -log10(hwe_lat1$V6)
hwe_lat2 = cbind(hwe_lat1, logp)

hwe_lat3 = subset(hwe_lat2, hwe_lat2$logp <= 6)
write.table(hwe_lat3[,c(1:4,11)], "clean-hwe-lat.txt", row.names = FALSE,col.names = FALSE, quote = FALSE)

