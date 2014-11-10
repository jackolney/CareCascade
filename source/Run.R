#Test Script for CareCascade
setwd("/Users/jack/git/CareCascade")
source("./source/BaselineFigures.R")
dyn.load("./source/main.so")


system.time(
result <- .Call("CallCascade",100, #Pop;
						      0,  #Hbct; 
						      0,  #Vct; 
						      0,  #HbctPocCd4; 
						      0,  #Linkage;
						      0,  #PreOutreach; 
						      0,  #ImprovedCare; 
						      0,  #PocCd4; 
						      0,  #VctPocCd4; 
						      0,  #ArtOutreach;
						      0,  #ImmediateArt; 
						      0,  #UniversalTestAndTreat; 
						      0   #Adherence;
	)
)
result

#Create Plots
GenerateBaselineFigures(result)

graphics.off()
quartz.options(h=12,w=5)
par(mfrow=c(3,1))
plot(result$sPOP_15to49,type='l',lwd=2)
plot(result$sHIV_15to49,type='l',lwd=2)
plot(result$sART_15to49,type='l',lwd=2)