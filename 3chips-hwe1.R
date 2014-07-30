eur = read.table("eur.frq", header = TRUE)
afr = read.table("afr.frq", header = TRUE)
lat = read.table("lat.frq", header = TRUE)

heur = read.table("eur.hwe", header = FALSE)
hafr = read.table("afr.hwe", header = FALSE)
hlat = read.table("lat.hwe", header = FALSE)
#allhwe = rbind(eur, afr, lat)

# common to 3 chips
eur_afr = merge(eur, afr, by = c(2), all = FALSE)
eur_afr_lat = merge(eur_afr, lat, by.eur_afr = c(1), by.lat = c(2), all = FALSE)

heur1 = heur[which(is.na(match(heur[,2], eur_afr_lat[,1])) == FALSE),]
hafr1 = hafr[which(is.na(match(hafr[,2], eur_afr_lat[,1])) == FALSE),]
hlat1 = hlat[which(is.na(match(hlat[,2], eur_afr_lat[,1])) == FALSE),]

ped = read.table("clean_het_callrate_controls_id.txt")
eur_fam = read.table("eur-22.fam")
afr_fam = read.table("afr-22.fam")
lat_fam = read.table("lat-22.fam")

## chip represented in clean data
N_eur = nrow(merge(eur_fam, ped, by = c(2), all = FALSE))
N_lat = nrow(merge(lat_fam, ped, by = c(2), all = FALSE))
N_afr = nrow(merge(afr_fam, ped, by = c(2), all = FALSE))

#maf_all = (eur_afr_lat$MAF.x * N_eur + eur_afr_lat$MAF.y * N_afr + eur_afr_lat$MAF * N_lat)/(N_eur + N_afr + N_lat)
#write.table(cbind(eur_afr_lat[,c(2,1,3,4)],maf_all), "maf_all3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# hwe
d = NULL
if(nrow(heur1) > 0 & nrow(hafr1) > 0 & nrow(hlat1) > 0){
for(i in 1:nrow(heur1)){
geno1 = as.integer(unlist(strsplit(as.character(heur1[i,6]),"/")))
geno2 = as.integer(unlist(strsplit(as.character(hafr1[i,6]),"/")))
geno3 = as.integer(unlist(strsplit(as.character(hlat1[i,6]),"/")))
obs = c(geno1[1] + geno2[1] + geno3[1], geno1[2] + geno2[2] + geno3[2], geno1[3] + geno2[3] + geno3[3])
phat = (2*(geno1[1]+geno2[1] + geno3[1]) + (geno1[2] + geno2[2] + geno3[2]))/(2*(sum(geno1) + sum(geno2) + sum(geno3)))
qhat = 1-phat
expec = c(phat^2, 2*phat*qhat, qhat^2)*(sum(geno1) + sum(geno2) + sum(geno3))
chitest = sum((obs - expec)^2/expec)
finalP = 1 - pchisq(chitest, df = 1)
d = c(d, finalP)
}
write.table(cbind(heur1[,c(1:5)],d), "hwe_all3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
}

# SNPs common in 3 chips
m = match(eur[,2], eur_afr_lat[,1])
eur_notall = eur[which(is.na(m) == TRUE),]

m = match(afr[,2], eur_afr_lat[,1])
afr_notall = afr[which(is.na(m) == TRUE),]

m = match(lat[,2], eur_afr_lat[,1])
lat_notall = lat[which(is.na(m) == TRUE),]

# SNPs common to EUR, AFR
eur_afr1 = merge(eur_notall, afr_notall, by = c(2), all = FALSE)

maf_eur_afr1 = (eur_afr1$MAF.x * N_eur + eur_afr1$MAF.y * N_afr)/(N_eur + N_afr)
#write.table(cbind(eur_afr1[,c(2,1,3,4)],maf_eur_afr1), "maf_eur_afr_notin3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

heur1 = heur[which(is.na(match(heur[,2], eur_afr1[,1])) == FALSE),]
hafr1 = hafr[which(is.na(match(hafr[,2], eur_afr1[,1])) == FALSE),]

# hwe
d = NULL
if(nrow(heur1) > 0 & nrow(hafr1) > 0){
for(i in 1:nrow(heur1)){
geno1 = as.integer(unlist(strsplit(as.character(heur1[i,6]),"/")))
geno2 = as.integer(unlist(strsplit(as.character(hafr1[i,6]),"/")))
obs = c(geno1[1] + geno2[1], geno1[2] + geno2[2], geno1[3] + geno2[3])
phat = (2*(geno1[1]+geno2[1]) + (geno1[2] + geno2[2]))/(2*(sum(geno1) + sum(geno2)))
qhat = 1-phat
expec = c(phat^2, 2*phat*qhat, qhat^2)*(sum(geno1) + sum(geno2))
chitest = sum((obs - expec)^2/expec)
finalP = 1 - pchisq(chitest, df = 1)
d = c(d, finalP)
}
write.table(cbind(heur1[,c(1:5)],d), "hwe_eur_afr_notin3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
}

# EUR, LAT
eur_lat1 = merge(eur_notall, lat_notall, by = c(2), all = FALSE)

maf_eur_lat1 = (eur_lat1$MAF.x * N_eur + eur_lat1$MAF.y * N_lat)/(N_eur + N_lat)
#write.table(cbind(eur_lat1[,c(2,1,3,4)],maf_eur_lat1), "maf_eur_lat_notin3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

heur1 = heur[which(is.na(match(heur[,2], eur_lat1[,1])) == FALSE),]
hlat1 = hlat[which(is.na(match(hlat[,2], eur_lat1[,1])) == FALSE),]

# hwe
if(nrow(heur1) > 0 & nrow(hlat1) > 0){
d = NULL
for(i in 1:nrow(heur1)){
geno1 = as.integer(unlist(strsplit(as.character(heur1[i,6]),"/")))
geno3 = as.integer(unlist(strsplit(as.character(hlat1[i,6]),"/")))
obs = c(geno1[1] + geno3[1], geno1[2] + geno3[2], geno1[3] + geno3[3])
phat = (2*(geno1[1] + geno3[1]) + (geno1[2] + geno3[2]))/(2*(sum(geno1) + sum(geno3)))
qhat = 1-phat
expec = c(phat^2, 2*phat*qhat, qhat^2)*(sum(geno1) + sum(geno3))
chitest = sum((obs - expec)^2/expec)
finalP = 1 - pchisq(chitest, df = 1)
d = c(d, finalP)
}
write.table(cbind(heur1[,c(1:5)],d), "hwe_eur_lat_notin3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
}

# AFR, LAT
afr_lat1 = merge(afr_notall, lat_notall, by = c(2), all = FALSE)

#maf_afr_lat1 = (afr_lat1$MAF.x * N_afr + afr_lat1$MAF.y * N_lat)/(N_afr + N_lat)
#write.table(cbind(afr_lat1[,c(2,1,3,4)],maf_afr_lat1), "maf_afr_lat_notin3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

hafr1 = hafr[which(is.na(match(hafr[,2], afr_lat1[,1])) == FALSE),]
hlat1 = hlat[which(is.na(match(hlat[,2], afr_lat1[,1])) == FALSE),]

# hwe
d = NULL
if(nrow(hafr1) > 0 & nrow(hlat1) > 0){
for(i in 1:nrow(hafr1)){
geno2 = as.integer(unlist(strsplit(as.character(hafr1[i,6]),"/")))
geno3 = as.integer(unlist(strsplit(as.character(hlat1[i,6]),"/")))
obs = c(geno2[1] + geno3[1], geno2[2] + geno3[2], geno2[3] + geno2[3])
phat = (2*(geno2[1] + geno3[1]) + (geno2[2] + geno3[2]))/(2*(sum(geno2) + sum(geno3)))
qhat = 1-phat
expec = c(phat^2, 2*phat*qhat, qhat^2)*(sum(geno2) + sum(geno3))
chitest = sum((obs - expec)^2/expec)
finalP = 1 - pchisq(chitest, df = 1)
d = c(d, finalP)
}
write.table(cbind(hafr1[,1:5],d), "hwe_afr_lat_notin3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
}

## remove the 2 file SNPs from "chip"_notall_notin3, i.e. eur_afr, eur_lat, eur_eas from eur_notall_notin3
eur_intwos = rbind(eur_afr1, eur_lat1)
m = match(eur_notall[,2], eur_intwos[,1])
eur_only = eur_notall[which(is.na(m) == TRUE),]

heur = read.table("eur.hwe", header = FALSE)
hafr = read.table("afr.hwe", header = FALSE)
hlat = read.table("lat.hwe", header = FALSE)

#write.table(eur_only, "maf_eur_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

heur1 = heur[which(is.na(match(heur[,2], eur_only[,2])) == FALSE),]
write.table(heur1[,c(1:5,9)], "hwe_eur_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)


# afr
afr_intwos = rbind(eur_afr1, afr_lat1)
m = match(afr_notall[,2], afr_intwos[,1])
afr_only = afr_notall[which(is.na(m) ==	TRUE),]

#write.table(afr_only, "maf_afr_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

hafr1 = hafr[which(is.na(match(hafr[,2], afr_only[,2])) == FALSE),]
write.table(hafr1[,c(1:5,9)], "hwe_afr_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# lat
lat_intwos = rbind(afr_lat1, eur_lat1)
m = match(lat_notall[,2], lat_intwos[,1])
lat_only = lat_notall[which(is.na(m) ==	TRUE),]

#write.table(lat_only, "maf_lat_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

hlat1 = hlat[which(is.na(match(hlat[,2], lat_only[,2])) == FALSE),]
write.table(hlat1[,c(1:5,9)], "hwe_lat_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# To check the numbers for each chip, because the sum of SNPs in EUR intersection AFR intersection LAT, and others sets will be total in each chip
#rs = read.table("eur-rs.txt")
#eur_22 = read.table("eur-22.bim")
#dim(merge(eur_22, rs, by = c(2), all = FALSE))
#rs = read.table("afr-rs.txt")
#afr_22 = read.table("afr-22.bim")
#dim(merge(afr_22, rs, by = c(2), all = FALSE))
#rs = read.table("lat-rs.txt")
#lat_22 = read.table("lat-22.bim")
#dim(merge(lat_22, rs, by = c(2), all = FALSE))


#write.table(maf, "maf.txt", row.names = FALSE, quote = FALSE, col.names = FALSE)
