eur = read.table("eur-rs.txt")
afr = read.table("afr-rs.txt")
lat = read.table("lat-rs.txt")
eas = read.table("eas-rs.txt")
all = read.table("eur_eas_afr_lat_rs.txt")


# EUR and AFR but not intersection of 3. 
m = merge(eur, afr, by = c(2), all.eur = TRUE)
m1 = match(m[,1], all$V2)
w = which(is.na(m1) == TRUE)
eur_afr_notinall = m[w,]
paste(c(nrow(eur_afr_notinall), nrow(m) - nrow(all)))
write.table(eur_afr_notinall, "eur_afr_notinall.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)


# AFR and LAT but not intersection of 3
m = merge(lat, afr, by = c(2), all.lat = TRUE)
m1 = match(m[,1], all$V2)
w = which(is.na(m1) == TRUE)
lat_afr_notinall = m[w,]
paste(c(nrow(lat_afr_notinall), nrow(m) - nrow(all)))
write.table(lat_afr_notinall, "lat_afr_notinall.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)


# EUR and LAT but not intersection of 3
m = merge(eur, lat, by = c(2), all.eur = TRUE)
m1 = match(m[,1], all$V2)
w = which(is.na(m1) == TRUE)
eur_lat_notinall = m[w,]
paste(c(nrow(eur_lat_notinall), nrow(m) - nrow(all)))
write.table(eur_lat_notinall, "eur_lat_notinall.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

afr_in_other = c(as.character(eur_afr_notinall$V2), as.character(all$V2), as.character(lat_afr_notinall$V2))
m = match(afr$V2, afr_in_other)
w = which(is.na(m) == TRUE)
afr_only = afr[w,]
nrow(afr) - nrow(eur_afr_notinall) - nrow(all)

