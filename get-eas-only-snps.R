# get snps that are only for eur, remove those snps

eur = read.table("eur-rs-dial.txt")
afr = read.table("afr-rs-dial.txt")
eas = read.table("eas-rs-dial.txt")
lat = read.table("lat-rs-dial.txt")
m = match(eas[,2], eur[,2])
eas_noeur = eas[which(is.na(m) == TRUE),]
m = match(eas_noeur[,2], afr[,2])
eas_noeurafr = eas_noeur[which(is.na(m) == TRUE),]
m = match(eas_noeurafr[,2], lat[,2])
eas_noeurafrlat = eas_noeurafr[which(is.na(m) == TRUE),]
m = match(eas[,2], eas_noeurafrlat[,2])
eas_inothers = eas[which(is.na(m) == TRUE),]
write.table(eas_noeurafr,"eas_only_snps.txt", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(eas_inothers,"eas_inothers_snps.txt", quote = FALSE, row.names = FALSE, col.names = FALSE)

