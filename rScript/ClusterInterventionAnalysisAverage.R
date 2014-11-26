#Test Script for CareCascade
rm(list=ls())
setwd("/Volumes/jjo11/cascade/CareCascadeV2/November/26th/")

# Load up results.
sweep <- c("Sweep1","Sweep2","Sweep3","Sweep4","Sweep5")
interventions <- c("Baseline", "Hbct_1", "Hbct_2", "Vct_1", "Vct_2", "HbctPocCd4_1", "HbctPocCd4_2", "Linkage_1", "Linkage_2", "VctPocCd4", "PreOutreach_1", "PreOutreach_2", "ImprovedCare_1", "ImprovedCare_2", "PocCd4", "ArtOutreach_1", "ArtOutreach_2", "Adherence_1", "Adherence_2", "ImmediateArt", "UniversalTestAndTreat_1", "UniversalTestAndTreat_2")

# for(i in 1:length(sweep)) {
# 	for(j in 1:length(interventions)) {
# 		load(gsub(" ","",paste("./",sweep[i],"/output/",interventions[j],"/currentWorkspace.RData")))
# 	}
# }

for(i in 1:length(interventions)) {
	output = 0
	for(j in 1:length(sweep)) {
		load(gsub(" ","",paste("./",sweep[j],"/output/",interventions[i],"/currentWorkspace.RData")))
		output <- output + sum(get(interventions[i])$sDALY)
	}
	output <- output / length(sweep)
	assign(gsub(" ","",paste(interventions[i],"_DALY")),output)
}


load("./Sweep1/output/HbctPocCd4_2/currentWorkspace.RData")
hpc_1 <- HbctPocCd4_2
load("./Sweep2/output/HbctPocCd4_2/currentWorkspace.RData")
hpc_2 <- HbctPocCd4_2
load("./Sweep3/output/HbctPocCd4_2/currentWorkspace.RData")
hpc_3 <- HbctPocCd4_2
load("./Sweep4/output/HbctPocCd4_2/currentWorkspace.RData")
hpc_4 <- HbctPocCd4_2
load("./Sweep5/output/HbctPocCd4_2/currentWorkspace.RData")
hpc_5 <- HbctPocCd4_2


test <- sum(sum(hpc_1$sDALY), sum(hpc_2$sDALY), sum(hpc_3$sDALY), sum(hpc_4$sDALY), sum(hpc_5$sDALY)) / 5
HbctPocCd4_2_DALY
#####################
# PLOTS AND FIGURES #
#####################

graphics.off()
quartz.options(w=18,h=12)
library(RColorBrewer)
p <- brewer.pal(12,"Set3")
d <- brewer.pal(12,"Paired")
R <-brewer.pal(9,"Reds")
O <- brewer.pal(9,"Oranges")
G <-brewer.pal(9,"Greens")
B <-brewer.pal(9,"Blues")
plot_col <- c(R[7],R[5],O[6],p[6],O[3],G[7],p[7],G[3],B[7],B[5],d[10],d[9])

resultDALY <- matrix(0,2,12)
resultDALY[1,1] <- Baseline_DALY - Hbct_1_DALY
resultDALY[2,1] <- Baseline_DALY - Hbct_2_DALY
resultDALY[1,2] <- Baseline_DALY - Vct_1_DALY
resultDALY[2,2] <- Baseline_DALY - Vct_2_DALY
resultDALY[1,3] <- Baseline_DALY - HbctPocCd4_1_DALY
resultDALY[2,3] <- Baseline_DALY - HbctPocCd4_2_DALY
resultDALY[1,4] <- Baseline_DALY - Linkage_1_DALY
resultDALY[2,4] <- Baseline_DALY - Linkage_2_DALY
resultDALY[1,5] <- Baseline_DALY - VctPocCd4_DALY
resultDALY[1,6] <- Baseline_DALY - PreOutreach_1_DALY
resultDALY[2,6] <- Baseline_DALY - PreOutreach_2_DALY
resultDALY[1,7] <- Baseline_DALY - ImprovedCare_1_DALY
resultDALY[2,7] <- Baseline_DALY - ImprovedCare_2_DALY
resultDALY[1,8] <- Baseline_DALY - PocCd4_DALY
resultDALY[1,9] <- Baseline_DALY - ArtOutreach_1_DALY
resultDALY[2,9] <- Baseline_DALY - ArtOutreach_2_DALY
resultDALY[1,10] <- Baseline_DALY - Adherence_1_DALY
resultDALY[2,10] <- Baseline_DALY - Adherence_2_DALY
resultDALY[1,11] <- Baseline_DALY - ImmediateArt_DALY
resultDALY[1,12] <- Baseline_DALY - UniversalTestAndTreat_1_DALY
resultDALY[2,12] <- Baseline_DALY - UniversalTestAndTreat_2_DALY

par(family="Avenir Next Bold")
	barplot(resultDALY[1,],
		col=plot_col,
		border=NA,
		cex.main=1.5,
		cex.lab=1.2,
		main="DALY's averted between 2010 and 2030",
		ylim=c(0,5e+05),
		ylab="DALY's averted",
		yaxt='n')
	axis(2,at=seq(0,5e+05,1e+05),labels=format(seq(0,5e+05,1e+05),big.mark=","),las=3,cex.axis=1)
	mtext("HBCT",1,								at=0.7,1,cex=1)
	mtext("VCT",1,								at=1.9,1,cex=1)
	mtext("HBCT\n POC CD4",1,					at=3.1,1.5,cex=1)
	mtext("Linkage",1,							at=4.3,1,cex=1)
	mtext("VCT\nPOC CD4",1,						at=5.5,1.5,cex=1)
	mtext("Pre-ART\n Outreach",1,				at=6.7,1.5,cex=1)
	mtext("Improved\n Care",1,					at=7.9,1.5,cex=1)
	mtext("POC CD4",1,							at=9.1,1,cex=1)
	mtext("ART\n Outreach",1,					at=10.3,1.5,cex=1)
	mtext("Adherence",1,						at=11.5,1.5,cex=1)
	mtext("Immediate\n ART",1,					at=12.7,1.5,cex=1)
	mtext("UTT",1,								at=13.9,1.5,cex=1)

	barplot(resultDALY[2,],
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1,1,1,1,0,1,1,0,1,1,0,1),
		density=30)

legend("topleft",
	c("Maximum Impact","Realistic Impact"),
	fill=1,
	density=c(100,30),
	cex=1.5,
	border=NA,
	box.lty=0)

abline(v=2.5,lty=3,lwd=1.5)
abline(v=6.1,lty=3,lwd=1.5)
abline(v=9.7,lty=3,lwd=1.5)
abline(v=12.1,lty=3,lwd=1.5)

quartz.save("/Users/jack/git/CareCascade/interventionFigures/impact.pdf",type='pdf')

###########
# SWEEP 1 #
###########

for(j in 1:length(interventions)) {
	load(gsub(" ","",paste("./",sweep[5],"/output/",interventions[j],"/currentWorkspace.RData")))
}


# graphics.off()
# quartz.options(w=18,h=12)
# library(RColorBrewer)
# p <- brewer.pal(12,"Set3")
# d <- brewer.pal(12,"Paired")
# R <-brewer.pal(9,"Reds")
# O <- brewer.pal(9,"Oranges")
# G <-brewer.pal(9,"Greens")
# B <-brewer.pal(9,"Blues")
# plot_col <- c(R[7],R[5],O[6],p[6],O[3],G[7],p[7],G[3],B[7],B[5],d[10],d[9])

resultDALY <- matrix(0,2,12)
resultDALY[1,1] <- sum(Baseline$sDALY) - sum(Hbct_1$sDALY)
resultDALY[2,1] <- sum(Baseline$sDALY) - sum(Hbct_2$sDALY)
resultDALY[1,2] <- sum(Baseline$sDALY) - sum(Vct_1$sDALY)
resultDALY[2,2] <- sum(Baseline$sDALY) - sum(Vct_2$sDALY)
resultDALY[1,3] <- sum(Baseline$sDALY) - sum(HbctPocCd4_1$sDALY)
resultDALY[2,3] <- sum(Baseline$sDALY) - sum(HbctPocCd4_2$sDALY)
resultDALY[1,4] <- sum(Baseline$sDALY) - sum(Linkage_1$sDALY)
resultDALY[2,4] <- sum(Baseline$sDALY) - sum(Linkage_2$sDALY)
resultDALY[1,5] <- sum(Baseline$sDALY) - sum(VctPocCd4$sDALY)
resultDALY[1,6] <- sum(Baseline$sDALY) - sum(PreOutreach_1$sDALY)
resultDALY[2,6] <- sum(Baseline$sDALY) - sum(PreOutreach_2$sDALY)
resultDALY[1,7] <- sum(Baseline$sDALY) - sum(ImprovedCare_1$sDALY)
resultDALY[2,7] <- sum(Baseline$sDALY) - sum(ImprovedCare_2$sDALY)
resultDALY[1,8] <- sum(Baseline$sDALY) - sum(PocCd4$sDALY)
resultDALY[1,9] <- sum(Baseline$sDALY) - sum(ArtOutreach_1$sDALY)
resultDALY[2,9] <- sum(Baseline$sDALY) - sum(ArtOutreach_2$sDALY)
resultDALY[1,10] <- sum(Baseline$sDALY) - sum(Adherence_1$sDALY)
resultDALY[2,10] <- sum(Baseline$sDALY) - sum(Adherence_2$sDALY)
resultDALY[1,11] <- sum(Baseline$sDALY) - sum(ImmediateArt$sDALY)
resultDALY[1,12] <- sum(Baseline$sDALY) - sum(UniversalTestAndTreat_1$sDALY)
resultDALY[2,12] <- sum(Baseline$sDALY) - sum(UniversalTestAndTreat_2$sDALY)

par(family="Avenir Next Bold")
	barplot(resultDALY[1,],
		col=plot_col,
		border=NA,
		cex.main=1.5,
		cex.lab=1.2,
		main="DALY's averted between 2010 and 2030",
		ylim=c(0,5e+05),
		ylab="DALY's averted",
		yaxt='n')
	axis(2,at=seq(0,5e+05,1e+05),labels=format(seq(0,5e+05,1e+05),big.mark=","),las=3,cex.axis=1)
	mtext("HBCT",1,								at=0.7,1,cex=1)
	mtext("VCT",1,								at=1.9,1,cex=1)
	mtext("HBCT\n POC CD4",1,					at=3.1,1.5,cex=1)
	mtext("Linkage",1,							at=4.3,1,cex=1)
	mtext("VCT\nPOC CD4",1,						at=5.5,1.5,cex=1)
	mtext("Pre-ART\n Outreach",1,				at=6.7,1.5,cex=1)
	mtext("Improved\n Care",1,					at=7.9,1.5,cex=1)
	mtext("POC CD4",1,							at=9.1,1,cex=1)
	mtext("ART\n Outreach",1,					at=10.3,1.5,cex=1)
	mtext("Adherence",1,						at=11.5,1.5,cex=1)
	mtext("Immediate\n ART",1,					at=12.7,1.5,cex=1)
	mtext("UTT",1,								at=13.9,1.5,cex=1)

	barplot(resultDALY[2,],
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1,1,1,1,0,1,1,0,1,1,0,1),
		density=30)

legend("topleft",
	c("Maximum Impact","Realistic Impact"),
	fill=1,
	density=c(100,30),
	cex=1.5,
	border=NA,
	box.lty=0)

abline(v=2.5,lty=3,lwd=1.5)
abline(v=6.1,lty=3,lwd=1.5)
abline(v=9.7,lty=3,lwd=1.5)
abline(v=12.1,lty=3,lwd=1.5)

######################
# COST IMPACT FIGURE #
######################
graphics.off()
quartz.options(w=18,h=12)
library(RColorBrewer)
p <- brewer.pal(12,"Set3")
d <- brewer.pal(12,"Paired")
R <-brewer.pal(9,"Reds")
O <- brewer.pal(9,"Oranges")
G <-brewer.pal(9,"Greens")
B <-brewer.pal(9,"Blues")
plot_col <- c(R[7],R[5],O[6],p[6],O[3],G[7],p[7],G[3],B[7],B[5],d[10],d[9])

bCOST <- sum(Baseline$sCOST)

resultCOST <- matrix(0,2,12)
resultCOST[1,1] <- sum(Hbct_1$sCOST) - bDALY
resultCOST[2,1] <- sum(Hbct_2$sCOST) - bDALY
resultCOST[1,2] <- sum(Vct_1$sCOST) - bDALY
resultCOST[2,2] <- sum(Vct_2$sCOST) - bDALY
resultCOST[1,3] <- sum(HbctPocCd4_1$sCOST) - bDALY
resultCOST[2,3] <- sum(HbctPocCd4_2$sCOST) - bDALY
resultCOST[1,4] <- sum(Linkage_1$sCOST) - bDALY
resultCOST[2,4] <- sum(Linkage_2$sCOST) - bDALY
resultCOST[1,5] <- sum(VctPocCd4$sCOST) - bDALY
resultCOST[1,6] <- sum(PreOutreach_1$sCOST) - bDALY
resultCOST[2,6] <- sum(PreOutreach_2$sCOST) - bDALY
resultCOST[1,7] <- sum(ImprovedCare_1$sCOST) - bDALY
resultCOST[2,7] <- sum(ImprovedCare_2$sCOST) - bDALY
resultCOST[1,8] <- sum(PocCd4$sCOST) - bDALY
resultCOST[1,9] <- sum(ArtOutreach_1$sCOST) - bDALY
resultCOST[2,9] <- sum(ArtOutreach_2$sCOST) - bDALY
resultCOST[1,10] <- sum(Adherence_1$sCOST) - bDALY
resultCOST[2,10] <- sum(Adherence_2$sCOST) - bDALY
resultCOST[1,11] <- sum(ImmediateArt$sCOST) - bDALY
resultCOST[1,12] <- sum(UniversalTestAndTreat_1$sCOST) - bDALY
resultCOST[2,12] <- sum(UniversalTestAndTreat_2$sCOST) - bDALY

par(family="Avenir Next Bold")
plot(resultDALY[1,1],resultCOST[1,1],
	pch=19,
	cex=1.5,
	cex.main=1.5,
	cex.lab=1.2,
	cex.axis=1.2,
	col=plot_col[1],
	xlim=c(0,5e+05),
	main="DALY's averted against additional cost of interventions acting on HIV care between 2010 and 2030",
	xlab="DALY's averted",
	ylab="Additional cost (2013 USD)",
	ylim=c(0,7e+9))
# abline(h=0,lwd=1.5)
# abline(v=0,lwd=1.5)

points(resultDALY[2,1],resultCOST[2,1],col=plot_col[1],pch=17,cex=1.5)

points(resultDALY[1,2],resultCOST[1,2],col=plot_col[2],pch=19,cex=1.5)
points(resultDALY[2,2],resultCOST[2,2],col=plot_col[2],pch=17,cex=1.5)

points(resultDALY[1,3],resultCOST[1,3],col=plot_col[3],pch=19,cex=1.5)
points(resultDALY[2,3],resultCOST[2,3],col=plot_col[3],pch=17,cex=1.5)

points(resultDALY[1,4],resultCOST[1,4],col=plot_col[4],pch=19,cex=1.5)
points(resultDALY[2,4],resultCOST[2,4],col=plot_col[4],pch=17,cex=1.5)

points(resultDALY[1,5],resultCOST[1,5],col=plot_col[5],pch=19,cex=1.5)

points(resultDALY[1,6],resultCOST[1,6],col=plot_col[6],pch=19,cex=1.5)
points(resultDALY[2,6],resultCOST[2,6],col=plot_col[6],pch=17,cex=1.5)

points(resultDALY[1,7],resultCOST[1,7],col=plot_col[7],pch=19,cex=1.5)
points(resultDALY[2,7],resultCOST[2,7],col=plot_col[7],pch=19,cex=1.5)

points(resultDALY[1,8],resultCOST[1,8],col=plot_col[8],pch=19,cex=1.5)

points(resultDALY[1,9],resultCOST[1,9],col=plot_col[9],pch=19,cex=1.5)
points(resultDALY[2,9],resultCOST[2,9],col=plot_col[9],pch=17,cex=1.5)

points(resultDALY[1,10],resultCOST[1,10],col=plot_col[10],pch=19,cex=1.5)
points(resultDALY[2,10],resultCOST[2,10],col=plot_col[10],pch=17,cex=1.5)

points(resultDALY[1,11],resultCOST[1,11],col=plot_col[11],pch=19,cex=1.5)

points(resultDALY[1,12],resultCOST[1,12],col=plot_col[12],pch=19,cex=1.5)
points(resultDALY[2,12],resultCOST[2,12],col=plot_col[12],pch=17,cex=1.5)

legend("topright",
	c("HBCT",
		"VCT",
		"HBCT POC CD4",
		"Linkage",
		"Pre-ART Outreach",
		"Improved Care",
		"VCT POC CD4",
		"POC CD4",
		"On-ART Outreach",
		"Adherence",
		"Immediate ART",
		"UTT"),
	fill=plot_col,
	border=NA,
	box.lty=0,
	cex=1.2)

legend(c(0,7e+9),
	c("Maximum Impact",
		"Realistic Impact"),
	pch=c(19,17),
	col=c(1),
	border=NA,
	box.lty=0,
	cex=1.2)
quartz.save("/Users/jack/git/CareCascade/interventionFigures/costImpact.pdf",type='pdf')

##################
# CARE PIE CHART #
##################

graphics.off()
quartz.options(w=20,h=12)
library(RColorBrewer)
m <- brewer.pal(9,"Spectral")

par(mfrow=c(1,3),family="Avenir Next Bold")
pie(Baseline$sCARE,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)

pie(HbctPocCd4_1$sCARE,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)

pie(HbctPocCd4_2$sCARE,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)

HbctPocCd4_1$sCARE / sum(HbctPocCd4_1$sCARE)
HbctPocCd4_2$sCARE / sum(HbctPocCd4_2$sCARE)


sum(Baseline$sDALY) - sum(HbctPocCd4_1$sDALY)
sum(Baseline$sDALY) - sum(HbctPocCd4_2$sDALY)

plot(HbctPocCd4_1$sDALY,type='b')
lines(HbctPocCd4_2$sDALY,col="red",type='b')

plot(HbctPocCd4_1$sDALY - HbctPocCd4_2$sDALY,type='b',lwd=3)



###########
# BIG PIE #
###########

library(RColorBrewer)
m <- brewer.pal(9,"Spectral")
graphics.off()
quartz.options(w=20,h=12)
system("mkdir ./interventionFigures/pie")

Interventions <- c("Baseline", "Hbct_1", "Hbct_2", "Vct_1", "Vct_2", "HbctPocCd4_1", "HbctPocCd4_2", "Linkage_1", "Linkage_2", "VctPocCd4", "PreOutreach_1", "PreOutreach_2", "ImprovedCare_1", "ImprovedCare_2", "PocCd4", "ArtOutreach_1", "ArtOutreach_2", "Adherence_1", "Adherence_2", "ImmediateArt", "UniversalTestAndTreat_1", "UniversalTestAndTreat_2")

for(i in 1:length(Interventions)) {
	print(Interventions[i])
	par(family="Avenir Next Bold")
	pie(get(Interventions[i])$sCARE,
		main=Interventions[i],
		labels=c("Never tested",
			"Tested but never\n initiated ART",
			"Initiated ART but\n died following late initiation (<200)",
			"Initiated ART but\n died off ART",
			"Initiatied ART but\n not late (>200)"),
		col=c(m[1:5]),
		border=NA,
		cex=2)
	quartz.save(gsub(" ","",paste("/Users/jack/git/CareCascade/interventionFigures/pie/",Interventions[i],".pdf")),type='pdf')
}

################
# TOTAL DEATHS #
################
setwd("/Users/jack/git/CareCascade/")

# Create some directories.
for(i in 1:length(Interventions)) {
	system(paste("mkdir",gsub(" ","",paste("./interventionFigures/",Interventions[i]))))
}

# Fill them up...
source("./rScript/BaselineFigures.R")
for(i in 1:length(Interventions)) {
	print(Interventions[i])
	directory <- gsub(" ","",paste("/Users/jack/git/CareCascade/interventionFigures/",Interventions[i]))
	GenerateBaselineFigures(get(Interventions[i]),directory)
}