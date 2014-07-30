## cat het-eur-*.het > eur.het

options(digits = 20)
callrate = read.csv("../C29_RPGEH_KIT_CALLRATE.csv")
het = read.table("eur.het", header = TRUE)
m = match(het[,2], callrate[,1])
het_callrate = cbind(het, callrate[m,])
het_callrate = data.frame(het, callrate[m,], heterozygosity = 1- (het_callrate$O.HOM/het_callrate$N.NM.))
write.csv(het_callrate, "het_callrate.csv", row.names = FALSE, quote = FALSE)

## in laptop for plot
het = read.csv("het_callrate.csv")
name = "EUR 41,429"
pdf(name)
plot(het$SAMPLE_SECOND_PASS_CALL_RATE, het$heterozygosity, ylab = "Heterozygosity", xlab = "Call Rate %", col = alpha("black", 1/3), pch ='.', cex = 2, main = name, cex.main = 0.8, cex.axis = 0.5, cex.lab = 0.8)
dev.off()

## cleaning after heterozygosity-callrate plot
het_check = subset(relcheck1, relcheck1$heterozygosity < 0.4 & relcheck1$SAMPLE_SECOND_PASS_CALL_RATE > 97)
