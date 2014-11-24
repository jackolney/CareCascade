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