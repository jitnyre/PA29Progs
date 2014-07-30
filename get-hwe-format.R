eur = read.table("eur-allchr.bim")
hwe_eur = read.table("clean-hwe-eur.txt")
m = match(hwe_eur[,2], eur[,2])
hwe_eur1 = cbind(hwe_eur, eur[m,])
write.table(hwe_eur1[,c(1,2,8,9,3,4)], "clean-hwe-eur-snps.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

afr = read.table("afr-allchr.bim")
hwe_afr = read.table("clean-hwe-afr.txt")
m = match(hwe_afr[,2], afr[,2])
hwe_afr1 = cbind(hwe_afr, afr[m,])
write.table(hwe_afr1[,c(1,2,8,9,3,4)], "clean-hwe-afr-snps.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

lat = read.table("lat-allchr.bim")
hwe_lat = read.table("clean-hwe-lat.txt")
m = match(hwe_lat[,2], lat[,2])
hwe_lat1 = cbind(hwe_lat, lat[m,])
write.table(hwe_lat1[,c(1,2,8,9,3,4)], "clean-hwe-lat-snps.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

