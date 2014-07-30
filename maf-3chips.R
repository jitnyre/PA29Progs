eur = read.table("eur.frq", header = TRUE)
afr = read.table("afr.frq", header = TRUE)
lat = read.table("lat.frq", header = TRUE)

# common to 3 chips
eur_afr = merge(eur, afr, by = c(2), all = FALSE)
eur_afr_lat = merge(eur_afr, lat, by.eur_afr = c(1), by.lat = c(2), all = FALSE)

ped = read.table("clean_het_callrate_id.txt")
eur_fam = read.table("eur-22.fam")
afr_fam = read.table("afr-22.fam")
lat_fam = read.table("lat-22.fam")

## chip represented in clean data
N_eur = nrow(merge(eur_fam, ped, by = c(2), all = FALSE))
N_lat = nrow(merge(lat_fam, ped, by = c(2), all = FALSE))
N_afr = nrow(merge(afr_fam, ped, by = c(2), all = FALSE))

maf_all = (eur_afr_lat$MAF.x * N_eur + eur_afr_lat$MAF.y * N_afr + eur_afr_lat$MAF * N_lat)/(N_eur + N_afr + N_lat)
write.table(cbind(eur_afr_lat[,c(2,1,3,4)],maf_all), "maf_all3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

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
write.table(cbind(eur_afr1[,c(2,1,3,4)],maf_eur_afr1), "maf_eur_afr_notin3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# EUR, LAT
eur_lat1 = merge(eur_notall, lat_notall, by = c(2), all = FALSE)

maf_eur_lat1 = (eur_lat1$MAF.x * N_eur + eur_lat1$MAF.y * N_lat)/(N_eur + N_lat)
write.table(cbind(eur_lat1[,c(2,1,3,4)],maf_eur_lat1), "maf_eur_lat_notin3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# AFR, LAT
afr_lat1 = merge(afr_notall, lat_notall, by = c(2), all = FALSE)

maf_afr_lat1 = (afr_lat1$MAF.x * N_afr + afr_lat1$MAF.y * N_lat)/(N_afr + N_lat)
write.table(cbind(afr_lat1[,c(2,1,3,4)],maf_afr_lat1), "maf_afr_lat_notin3.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

## remove the 2 file SNPs from "chip"_notall_notin3, i.e. eur_afr, eur_lat, eur_eas from eur_notall_notin3
eur_intwos = rbind(eur_afr1, eur_lat1)
m = match(eur_notall[,2], eur_intwos[,1])
eur_only = eur_notall[which(is.na(m) == TRUE),]

write.table(eur_only, "maf_eur_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# afr
afr_intwos = rbind(eur_afr1, afr_lat1)
m = match(afr_notall[,2], afr_intwos[,1])
afr_only = afr_notall[which(is.na(m) ==	TRUE),]

write.table(afr_only, "maf_afr_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# lat
lat_intwos = rbind(afr_lat1, eur_lat1)
m = match(lat_notall[,2], lat_intwos[,1])
lat_only = lat_notall[which(is.na(m) ==	TRUE),]

write.table(lat_only, "maf_lat_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

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
