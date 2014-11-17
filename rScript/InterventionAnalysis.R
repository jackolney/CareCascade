#Test Script for CareCascade
setwd("/Users/jack/git/CareCascade")
source("./rScript/Cascade.R")
dyn.load("./source/main.so")

Interventions <- 
c("Baseline",
"Hbct_1",
"Hbct_2", 
"Vct_1",
"Vct_2", 
"HbctPocCd4_1",
"HbctPocCd4_2", 
"Linkage_1",
"Linkage_2",
"VctPocCd4",
"PreOutreach_1",
"PreOutreach_2", 
"ImprovedCare_1",
"ImprovedCare_2", 
"PocCd4", 
"ArtOutreach_1",
"ArtOutreach_2",
"Adherence_1",
"Adherence_2",
"ImmediateArt_1",
"ImmediateArt_2", 
"UniversalTestAndTreat_1",
"UniversalTestAndTreat_2")

cHbct 					<- c(0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
cVct 					<- c(0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
cHbctPocCd4 			<- c(0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
cLinkage				<- c(0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
cVctPocCd4 				<- c(0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0)
cPreOutreach 			<- c(0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0)
cImprovedCare 			<- c(0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0)
cPocCd4 				<- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0)
cArtOutreach			<- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0)
cAdherence 				<- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0)
cImmediateArt 			<- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0)
cUniversalTestAndTreat 	<- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2)

GlobalPopSize = 100

#Intervention Loop
for(i in 1:length(Interventions)) {
	Output <- Cascade(GlobalPopSize,cHbct[i],cVct[i],cHbctPocCd4[i],cLinkage[i],cVctPocCd4[i],cPreOutreach[i],cImprovedCare[i],cPocCd4[i],cArtOutreach[i],cAdherence[i],cImmediateArt[i],cUniversalTestAndTreat[i])
	assign(Interventions[i],Output)
}

# get(Interventions[1])
save.image(file="currentWorkspace.RData")

load("currentWorkspace.RData")
ls()


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
plot_col <- c(R[7],R[5],O[6],p[6],G[7],p[7],G[5],G[3],B[7],B[5],d[10],d[9])



dif_1a 		<- baseline[20,] - int_1a[20,]
dif_1b 		<- baseline[20,] - int_1b[20,]
dif_2a 		<- baseline[20,] - int_2a[20,]
dif_2b 		<- baseline[20,] - int_2b[20,]
dif_3a 		<- baseline[20,] - int_3a[20,]
dif_3b		<- baseline[20,] - int_3b[20,]
dif_4a 		<- baseline[20,] - int_4a[20,]
dif_4b 		<- baseline[20,] - int_4b[20,]
dif_5a 		<- baseline[20,] - int_5a[20,]
dif_5b 		<- baseline[20,] - int_5b[20,]
dif_6a 		<- baseline[20,] - int_6a[20,]
dif_6b 		<- baseline[20,] - int_6b[20,]
dif_7 		<- baseline[20,] - int_7[20,]
dif_8a 		<- baseline[20,] - int_8a[20,]
dif_8b 		<- baseline[20,] - int_8b[20,]
dif_9a 		<- baseline[20,] - int_9a[20,]
dif_9b 		<- baseline[20,] - int_9b[20,]
dif_10 		<- baseline[20,] - int_10[20,]
dif_11a 	<- baseline[20,] - int_11a[20,]
dif_11b 	<- baseline[20,] - int_11b[20,]
dif_12 		<- baseline[20,] - int_12[20,]


dif <- matrix(0,2,12)

dif[1,1] <- baseline[20,] - int_1a[20,]
dif[2,1] <- baseline[20,] - int_1b[20,]
dif[1,2] <- baseline[20,] - int_2a[20,]
dif[2,2] <- baseline[20,] - int_2b[20,]
dif[1,3] <- baseline[20,] - int_3a[20,]
dif[2,3] <- baseline[20,] - int_3b[20,]
dif[1,4] <- baseline[20,] - int_4a[20,]
dif[2,4] <- baseline[20,] - int_4b[20,]
dif[1,5] <- baseline[20,] - int_5a[20,]
dif[2,5] <- baseline[20,] - int_5b[20,]
dif[1,6] <- baseline[20,] - int_6a[20,]
dif[2,6] <- baseline[20,] - int_6b[20,]
dif[1,7] <- baseline[20,] - int_12[20,]
dif[1,8] <- baseline[20,] - int_7[20,]
dif[1,9] <- baseline[20,] - int_8a[20,]
dif[2,9] <- baseline[20,] - int_8b[20,]
dif[1,10] <- baseline[20,] - int_9a[20,]
dif[2,10] <- baseline[20,] - int_9b[20,]
dif[1,11] <- baseline[20,] - int_10[20,]
dif[1,12] <- baseline[20,] - int_11a[20,]
dif[2,12] <- baseline[20,] - int_11b[20,]



par(family="Avenir Next Bold")
	barplot(dif[1,],
		col=plot_col,
		border=NA,
		cex.main=1.5,
		cex.lab=1.2,
		main="DALY's averted between 2010 and 2030",
		ylim=c(0,5e+05),
		ylab="DALY's averted",
		yaxt='n')
	axis(2,at=seq(0,5e+05,5e+04),labels=format(seq(0,5e+05,5e+04),big.mark=","),las=3,cex.axis=1)
	mtext("HBCT",1,								at=0.7,1,cex=1)
	mtext("VCT",1,								at=1.9,1,cex=1)
	mtext("HBCT\n POC CD4",1,					at=3.1,1.5,cex=1)
	mtext("Linkage",1,							at=4.3,1,cex=1)
	mtext("Pre-ART\n Outreach",1,				at=5.5,1.5,cex=1)
	mtext("Improved\n Care",1,					at=6.7,1.5,cex=1)
	mtext("VCT\nPOC CD4",1,						at=7.9,1.5,cex=1)
	mtext("POC CD4",1,							at=9.1,1,cex=1)
	mtext("ART\n Outreach",1,					at=10.3,1.5,cex=1)
	mtext("Adherence",1,						at=11.5,1.5,cex=1)
	mtext("Immediate\n ART",1,					at=12.7,1.5,cex=1)
	mtext("UTT",1,								at=13.9,1.5,cex=1)
	
	barplot(dif[2,],
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1,1,1,1,1,1,0,0,1,1,0,1),
		density=30)

legend("topleft",
	c("Maximum Impact","Realistic Impact"),
	fill=1,
	density=c(100,30),
	cex=1.5,
	border=NA,
	box.lty=0)

abline(v=2.5,lty=3,lwd=1.5)
abline(v=4.9,lty=3,lwd=1.5)
abline(v=9.7,lty=3,lwd=1.5)
abline(v=12.1,lty=3,lwd=1.5)