## This code selects the controls from the clean_het_callrate_id.txt, i.e. from heterozygosity & callrate step 
## to MAF & HWE step which only needs to be done on controls.

options(digits = 20)
fromhet = read.table("clean_het_callrate_id.txt")
casectl = read.csv("C29_CASECONTROL.csv")
m = match(fromhet[,2], casectl$SUBJID)
fromhet_casectl = cbind(fromhet, casectl[m,])
controls = subset(fromhet_casectl, fromhet_casectl$CASENESS == 0)

write.table(controls[,1:2], "clean_het_callrate_controls_id.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
