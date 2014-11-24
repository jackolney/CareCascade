#Test Script for CareCascade
setwd("/Users/jack/git/CareCascade")
source("./rScript/BaselineFigures.R")
dyn.load("./source/main.so")

system.time(
result <- .Call("CallCascade",100, #Pop;
						      0,  #Hbct; 
						      0,  #Vct; 
						      0,  #HbctPocCd4; 
						      0,  #Linkage;
						      0,  #VctPocCd4; 						      
						      0,  #PreOutreach; 
						      0,  #ImprovedCare; 
						      0,  #PocCd4; 
						      0,  #ArtOutreach;
						      0,  #Adherence;						      
						      0,  #ImmediateArt; 
						      0   #UniversalTestAndTreat; 
	)
)

#result

#Create Plots
# GenerateBaselineFigures(result)

system.time(
ArtOutreach_1 <- .Call("CallCascade",100, #Pop;
						      0,  #Hbct; 
						      0,  #Vct; 
						      0,  #HbctPocCd4; 
						      0,  #Linkage;
						      0,  #VctPocCd4; 						      
						      0,  #PreOutreach; 
						      0,  #ImprovedCare; 
						      0,  #PocCd4; 
						      1,  #ArtOutreach;
						      0,  #Adherence;						      
						      0,  #ImmediateArt; 
						      0   #UniversalTestAndTreat; 
	)
)

sum(result$sDALY)
sum(ArtOutreach_1$sDALY)

sum(result$sDALY) - sum(ArtOutreach_1$sDALY)


graphics.off()
quartz.options(w=20,h=12)
library(RColorBrewer)
m <- brewer.pal(9,"Spectral")

par(mfrow=c(1,2),family="Avenir Next Bold")
pie(result$sCARE,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)

pie(ArtOutreach_1$sCARE,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)