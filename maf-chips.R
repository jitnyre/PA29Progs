eur = read.table("eur-22.frq", header = TRUE)
afr = read.table("afr-22.frq", header = TRUE)
eas = read.table("eas-22.frq", header = TRUE)
lat = read.table("lat-22.frq", header = TRUE)
all = read.table("eur_eas_afr_lat_rs.txt")
eur_all = merge(eur, all, by = c(2), all = FALSE)
eas_all = merge(eas, all, by = c(2), all = FALSE)
afr_all = merge(afr, all, by = c(2), all = FALSE)
lat_all = merge(lat, all, by = c(2), all = FALSE)
ped = read.table("clean_het_callrate_id.txt")
eur_fam = read.table("eur-22.fam")
afr_fam = read.table("afr-22.fam")
eas_fam = read.table("eas-22.fam")
lat_fam = read.table("lat-22.fam")

## chip represented in clean data
N_eur = nrow(merge(eur_fam, ped, by = c(2), all = FALSE))
N_lat = nrow(merge(lat_fam, ped, by = c(2), all = FALSE))
N_afr = nrow(merge(afr_fam, ped, by = c(2), all = FALSE))
N_eas = nrow(merge(eas_fam, ped, by = c(2), all = FALSE))

maf_all = (eur_all$MAF * N_eur + afr_all$MAF * N_afr + lat_all$MAF * N_lat + eas_all$MAF * N_eas)/(N_eur + N_afr + N_lat + N_eas)
write.table(cbind(eur_all[,c(2,1,3,4)],maf_all), "maf_all.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# SNPs common in 3 chips
m = match(eur[,2], eur_all[,1])
eur_notall = eur[which(is.na(m) == TRUE),]

m = match(afr[,2], afr_all[,1])
afr_notall = afr[which(is.na(m) == TRUE),]

m = match(lat[,2], lat_all[,1])
lat_notall = lat[which(is.na(m) == TRUE),]

m = match(eas[,2], eas_all[,1])
eas_notall = eas[which(is.na(m) == TRUE),]

# how many ways to have SNPs common in 3 chips? EUR-AFR-LAT, EUR-AFR-EAS, EUR-LAT-EAS, AFR-LAT-EAS
m = merge(eur_notall, afr_notall, by = c(2), all = FALSE)
eur_afr_lat = merge(m, lat_notall, by.m = c(1), by.lat_notall = c(2), all = FALSE)

maf_eur_afr_lat = (eur_afr_lat$MAF.x * N_eur + eur_afr_lat$MAF.y * N_afr + eur_afr_lat$MAF * N_lat)/(N_eur + N_afr + N_lat)
write.table(cbind(eur_afr_lat[,c(2,1,3,4)],maf_eur_afr_lat), "maf_eur_afr_lat.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

m = merge(eur_notall, afr_notall, by = c(2), all = FALSE)
eur_afr_eas = merge(m, eas_notall, by.m = c(1), by.eas_notall = c(2), all = FALSE)

maf_eur_afr_eas = (eur_afr_eas$MAF.x * N_eur + eur_afr_eas$MAF.y * N_afr + eur_afr_eas$MAF * N_eas)/(N_eur + N_afr + N_eas)
write.table(cbind(eur_afr_eas[,c(2,1,3,4)],maf_eur_afr_eas), "maf_eur_afr_eas.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

m = merge(eur_notall, lat_notall, by = c(2), all = FALSE)
eur_lat_eas = merge(m, eas_notall, by.m = c(1), by.eas_notall = c(2), all = FALSE)

maf_eur_lat_eas = (eur_lat_eas$MAF.x * N_eur + eur_lat_eas$MAF.y * N_lat + eur_lat_eas$MAF * N_eas)/(N_eur + N_lat + N_eas)
write.table(cbind(eur_lat_eas[,c(2,1,3,4)],maf_eur_lat_eas), "maf_eur_lat_eas.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

m = merge(afr_notall, lat_notall, by = c(2), all = FALSE)
afr_lat_eas = merge(m, eas_notall, by.m = c(1), by.eas_notall = c(2), all = FALSE)

maf_afr_lat_eas = (afr_lat_eas$MAF.x * N_afr + afr_lat_eas$MAF.y * N_lat + afr_lat_eas$MAF * N_eas)/(N_afr + N_lat + N_eas)
write.table(cbind(afr_lat_eas[,c(2,1,3,4)],maf_afr_lat_eas), "maf_afr_lat_eas.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

## remove from each "chip"_notall the snps that appeared in the 3-chip-file, i.e. remove SNPs in eur-afr-eas and eur-afr-lat and eur-lat-eas from eur_not all
eur_in3 = rbind(eur_afr_lat, eur_afr_eas, eur_lat_eas)

m = match(as.character(eur_notall$SNP), as.character(eur_in3$SNP))
eur_notall_notin3 = eur_notall[which(is.na(m) == TRUE),]

# afr
afr_in3 = rbind(eur_afr_lat, eur_afr_eas, afr_lat_eas)

# remove from eur_notall
#d = NULL
#for(i in 1:nrow(afr_notall)){
#if(length(which(as.character(afr_in3$SNP) == as.character(afr_notall$SNP[i]))) == 0){
#d = rbind(d, afr_notall[i,])
#}
#}
#afr_notall_notin3 = d

m = match(as.character(afr_notall$SNP), as.character(afr_in3$SNP))
afr_notall_notin3 = afr_notall[which(is.na(m) == TRUE),]

# lat
lat_in3 = rbind(eur_afr_lat, afr_lat_eas, eur_lat_eas)

m = match(as.character(lat_notall$SNP),	as.character(lat_in3$SNP))
lat_notall_notin3 = lat_notall[which(is.na(m) == TRUE),]

# eas
eas_in3 = rbind(eur_afr_eas, afr_lat_eas, eur_lat_eas)

m = match(as.character(eas_notall$SNP), as.character(eas_in3$SNP))
eas_notall_notin3 = eas_notall[which(is.na(m) == TRUE),]

## SNPs in 2 chips, 4 CHOOSE 2 = 6: EUR-AFR, EUR-LAT, EUR-EAS, AFR-LAT, AFR-EAS, LAT-EAS
# SNPs common to EUR, AFR
eur_afr = merge(eur_notall_notin3, afr_notall_notin3, by = c(2), all = FALSE)

maf_eur_afr = (eur_afr$MAF.x * N_eur + eur_afr$MAF.y * N_afr)/(N_eur + N_afr)
write.table(cbind(eur_afr[,c(2,1,3,4)],maf_eur_afr), "maf_eur_afr.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# EUR, LAT
eur_lat = merge(eur_notall_notin3, lat_notall_notin3, by = c(2), all = FALSE)

maf_eur_lat = (eur_lat$MAF.x * N_eur + eur_lat$MAF.y * N_lat)/(N_eur + N_lat)
write.table(cbind(eur_lat[,c(2,1,3,4)],maf_eur_lat), "maf_eur_lat.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# eur, eas
eur_eas = merge(eur_notall_notin3, eas_notall_notin3, by = c(2), all = FALSE)

maf_eur_eas = (eur_eas$MAF.x * N_eur + eur_eas$MAF.y * N_eas)/(N_eur + N_eas)
write.table(cbind(eur_eas[,c(2,1,3,4)],maf_eur_eas), "maf_eur_eas.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# AFR, LAT
afr_lat = merge(afr_notall_notin3, lat_notall_notin3, by = c(2), all = FALSE)

maf_afr_lat = (afr_lat$MAF.x * N_afr + afr_lat$MAF.y * N_lat)/(N_afr + N_lat)
write.table(cbind(afr_lat[,c(2,1,3,4)],maf_afr_lat), "maf_afr_lat.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# AFR, EAS
afr_eas = merge(afr_notall_notin3, eas_notall_notin3, by = c(2), all = FALSE)

maf_afr_eas = (afr_eas$MAF.x * N_afr + afr_eas$MAF.y * N_eas)/(N_afr + N_eas)
write.table(cbind(afr_eas[,c(2,1,3,4)],maf_afr_eas), "maf_afr_eas.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)


# LAT, EAS
lat_eas = merge(lat_notall_notin3, eas_notall_notin3, by = c(2), all = FALSE)

maf_lat_eas = (lat_eas$MAF.x * N_lat + lat_eas$MAF.y * N_eas)/(N_lat + N_eas)
write.table(cbind(lat_eas[,c(2,1,3,4)],maf_lat_eas), "maf_lat_eas.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

## remove the 2 file SNPs from "chip"_notall_notin3, i.e. eur_afr, eur_lat, eur_eas from eur_notall_notin3
eur_intwos = rbind(eur_afr, eur_lat, eur_eas)
eur_only = merge(eur_notall_notin3, eur_intwos, by.eur_notall_notin3 = c(2), by.eur_intwos = c(1), all.eur_notall_notin3 = FALSE) 

maf_eur = eur_only$MAF

write.table(cbind(eur_only[,c(2,1,3,4)],maf_eur), "maf_eur_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# afr
afr_intwos = rbind(eur_afr, afr_lat, afr_eas)
afr_only = merge(afr_notall_notin3, afr_intwos, by.afr_notall_notin3 = c(2), by.afr_intwos = c(1), all.afr_notall_notin3 = FALSE) 

maf_afr = afr_only$MAF

write.table(cbind(afr_only[,c(2,1,3,4)],maf_afr), "maf_afr_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# lat
lat_intwos = rbind(afr_lat, eur_lat, lat_eas)
lat_only = merge(lat_notall_notin3, lat_intwos, by.lat_notall_notin3 = c(2), by.lat_intwos = c(1), all.lat_notall_notin3 = FALSE) 

maf_lat = lat_only$MAF

write.table(cbind(lat_only[,c(2,1,3,4)],maf_lat), "maf_lat_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# eas
eas_intwos = rbind(afr_eas, lat_eas, eur_eas)
eas_only = merge(eas_notall_notin3, eas_intwos, by.eas_notall_notin3 = c(2), by.eas_intwos = c(1), all.eas_notall_notin3 = FALSE) 

maf_eas = eas_only$MAF

write.table(cbind(eas_only[,c(2,1,3,4)],maf_eas), "maf_eas_only.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)



