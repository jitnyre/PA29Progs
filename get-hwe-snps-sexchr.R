maf_eur = read.table("clean-maf-23.txt")
hwe_eur = read.table("hwe-23.txt")
m = match(maf_eur[,2], hwe_eur[,2])
hwe_eur1 = cbind(maf_eur, hwe_eur[m,])
logp = -log10(hwe_eur1$V6)
hwe_eur2 = cbind(hwe_eur1, logp)

hwe_eur3 = subset(hwe_eur2, hwe_eur2$logp <= 6)
write.table(hwe_eur3[,c(1:4,11)], "clean-hwe-23.txt", row.names = FALSE,col.names = FALSE, quote = FALSE)

