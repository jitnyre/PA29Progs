options(digits = 20)

casectl = read.csv("C29_CASECONTROL.csv")
case = which(casectl$CASENESS == 1)
casectl[case,2] = 2
ctl = which(casectl$CASENESS == 0)
casectl[ctl,2]	= 1

fam = read.table("fam.txt")
m = match(fam[,2], casectl[,1])
fam_status = cbind(fam, casectl[m,])
fam_status[,6] = fam_status$CASENESS
write.table(fam_status[,1:6], "fam-status.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

