# subjects after QC
clean = read.table("clean_het_callrate.txt")

# Kaiser Pedigree file (except the twin column)
ped = read.table("C29_Pedigree_notwinid.txt", header = TRUE)

# to get the gender 
m = match(clean[,2], ped[,2])
clean_ped = cbind(clean, ped[m,])

# Kaiser case/control status
casectl = read.csv("C29_CASECONTROL.csv")

# to get the status
m = match(clean_ped[,2], casectl[,1])
clean_ped_casectl = cbind(clean_ped, casectl[m,])

# QC clean subjects with gender and status information
write.table(clean_ped_casectl, "clean_QC_subjects.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# 4 groups: Male case, Female case, Male control, Female control
malecase = subset(clean_ped_casectl, clean_ped_casectl$SEX == 1 & clean_ped_casectl$CASENESS == 1)

malectl = subset(clean_ped_casectl, clean_ped_casectl$SEX == 1 & clean_ped_casectl$CASENESS == 0)

femalecase = subset(clean_ped_casectl, clean_ped_casectl$SEX == 2 & clean_ped_casectl$CASENESS == 1)

femalectl = subset(clean_ped_casectl, clean_ped_casectl$SEX == 2 & clean_ped_casectl$CASENESS == 0)

# discovery set for malecase
malecaseD = malecase[which(rbinom(nrow(malecase),1,prob=0.5) == 1),]
write.table(malecaseD[,1:2],"male-case-discovery-id.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# validation set for malecase
malecaseV = malecase[which(is.na(match(malecase[,2], malecaseD[,2])) == TRUE),]
write.table(malecaseV[,1:2],"male-case-validation-id.txt", row.names = FALSE, col.names = FALSE,	quote =	FALSE)

# discovery set	for malectl
malectlD = malectl[which(rbinom(nrow(malectl),1,prob=0.5) == 1),]
write.table(malectlD[,1:2],"male-control-discovery-id.txt", row.names = FALSE, col.names = FALSE,	quote =	FALSE)

# validation set for malectl
malectlV = malectl[which(is.na(match(malectl[,2], malectlD[,2])) == TRUE),]
write.table(malectlV[,1:2],"male-control-validation-id.txt", row.names = FALSE, col.names = FALSE,        quote = FALSE)

# discovery set	for femalecase
femalecaseD = femalecase[which(rbinom(nrow(femalecase),1,prob=0.5) == 1),]
write.table(femalecaseD[,1:2],"female-case-discovery-id.txt", row.names = FALSE, col.names = FALSE,	quote =	FALSE)

# validation set for femalecase
femalecaseV = femalecase[which(is.na(match(femalecase[,2], femalecaseD[,2])) == TRUE),]
write.table(femalecaseV[,1:2],"female-case-validation-id.txt", row.names = FALSE, col.names = FALSE,        quote = FALSE)

# discovery set for femalectl
femalectlD = femalectl[which(rbinom(nrow(femalectl),1,prob=0.5) == 1),]
write.table(femalectlD[,1:2],"female-control-discovery-id.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

# validation set for femalecase
femalectlV = femalectl[which(is.na(match(femalectl[,2], femalectlD[,2])) == TRUE),]
write.table(femalectlV[,1:2],"female-control-validation-id.txt", row.names = FALSE, col.names = FALSE,        quote = FALSE)

