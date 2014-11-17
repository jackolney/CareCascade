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


get(Interventions[1])

# get(Interventions[1])
save.image(file="currentWorkspace.RData")

load("currentWorkspace.RData")



bDALY <- sum(Baseline$sDALY)

resultDALY <- matrix(0,2,12)
resultDALY[1,1] <- bDaly - sum(Hbct_1$sDALY)
resultDALY[2,1] <- bDaly - sum(Hbct_2$sDALY)
resultDALY[1,2] <- bDALY - sum(Vct_1$sDALY)
resultDALY[2,2] <- bDALY - sum(Vct_2$sDALY)
resultDALY[1,3] <- bDALY - sum(HbctPocCd4_1$sDALY)
resultDALY[2,3] <- bDALY - sum(HbctPocCd4_2$sDALY)
resultDALY[1,4] <- bDALY - sum(Linkage_1$sDALY)
resultDALY[2,4] <- bDALY - sum(Linkage_2$sDALY)
resultDALY[1,5] <- bDALY - sum(VctPocCd4$sDALY)
resultDALY[1,6] <- bDALY - sum(PreOutreach_1$sDALY)
resultDALY[2,6] <- bDALY - sum(PreOutreach_2$sDALY)
resultDALY[1,7] <- bDALY - sum(ImprovedCare_1$sDALY)
resultDALY[2,7] <- bDALY - sum(ImprovedCare_2$sDALY)
resultDALY[1,8] <- bDALY - sum(PocCd4$sDALY)
resultDALY[1,9] <- bDALY - sum(ArtOutreach_1$sDALY)
resultDALY[2,9] <- bDALY - sum(ArtOutreach_2$sDALY)
resultDALY[1,10] <- bDALY - sum(Adherence_1$sDALY)
resultDALY[2,10] <- bDALY - sum(Adherence_2$sDALY)
resultDALY[1,11] <- bDALY - sum(ImmediateArt_1$sDALY)
resultDALY[2,11] <- bDALY - sum(ImmediateArt_2$sDALY)
resultDALY[1,12] <- bDALY - sum(UniversalTestAndTreat_1$sDALY)
resultDALY[2,12] <- bDALY - sum(UniversalTestAndTreat_2$sDALY)

barplot(resultDALY[1,])
barplot(resultDALY[2,],add=TRUE,col="red")

# NOTES #

# 1) There is no ImmediateArt_2 intervention - IDIOT.

# Need the colour script to work out which intervention is which.

