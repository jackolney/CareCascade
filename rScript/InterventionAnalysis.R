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

GlobalPopSize = 1

#Intervention Loop
for(i in 1:length(Interventions)) {
	Output <- Cascade(GlobalPopSize,cHbct[i],cVct[i],cHbctPocCd4[i],cLinkage[i],cVctPocCd4[i],cPreOutreach[i],cImprovedCare[i],cPocCd4[i],cArtOutreach[i],cAdherence[i],cImmediateArt[i],cUniversalTestAndTreat[i])
	assign(Interventions[i],Output)
}

get(Interventions[1])
