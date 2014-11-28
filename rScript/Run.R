#Test Script for CareCascade
setwd("/Users/jack/git/CareCascade")
source("./rScript/BaselineFigures.R")
dyn.load("./source/main.so")

# system("date")
# system.time(
# result <- .Call("CallCascade",100, #Pop;
# 						      0,  #Hbct; 
# 						      0,  #Vct; 
# 						      0,  #HbctPocCd4; 
# 						      0,  #Linkage;
# 						      0,  #VctPocCd4; 						      
# 						      0,  #PreOutreach; 
# 						      0,  #ImprovedCare; 
# 						      0,  #PocCd4; 
# 						      0,  #ArtOutreach;
# 						      0,  #Adherence;						      
# 						      0,  #ImmediateArt; 
# 						      0   #UniversalTestAndTreat; 
# 	)
# )


system("date")
popSize = 1000
dyn.load("./source/main.so")
baseline 					<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
# hbct_1 						<- .Call("CallCascade",popSize, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
# hbct_2 						<- .Call("CallCascade",popSize, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
# vct_1 						<- .Call("CallCascade",popSize, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
# vct_2 						<- .Call("CallCascade",popSize, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
# hbctPocCd4_1 				<- .Call("CallCascade",popSize, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)
# hbctPocCd4_2 				<- .Call("CallCascade",popSize, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0)
# linkage_1 					<- .Call("CallCascade",popSize, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)
# linkage_2 					<- .Call("CallCascade",popSize, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0)
# vctPocCd4 					<- .Call("CallCascade",popSize, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0)
# preOutreach_1 				<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)
# preOutreach_2 				<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0)
# improvedCare_1 				<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0)
# improvedCare_2 				<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0)
# pocCd4 						<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)
dyn.load("./source/main.so")
artOutreach_1 				<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0)
# artOutreach_2 				<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0)
dyn.load("./source/main.so")
adherence_1 				<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)
# adherence_2 				<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0)
# immediateArt 				<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)
dyn.load("./source/main.so")
universalTestAndTreat_1 	<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
# universalTestAndTreat_2 	<- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2)

sum(baseline$sDALY) - sum(artOutreach_1$sDALY)
sum(baseline$sDALY) - sum(adherence_1$sDALY)
sum(baseline$sDALY) - sum(universalTestAndTreat_1$sDALY)

plot(baseline$sINCIDENCE,type='b')

plot(baseline$sPreArtCOST,type='b')
plot(baseline$sPreArtCOST_Hiv)
plot(baseline$sArtCOST,type='b')
plot(baseline$sArtCOST_Hiv)
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

system.time(
Baseline <- .Call("CallCascade",100, #Pop;
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

system.time(
Adherence_1 <- .Call("CallCascade",100, #Pop;
						      0,  #Hbct; 
						      0,  #Vct; 
						      0,  #HbctPocCd4; 
						      0,  #Linkage;
						      0,  #VctPocCd4; 						      
						      0,  #PreOutreach; 
						      0,  #ImprovedCare; 
						      0,  #PocCd4; 
						      0,  #ArtOutreach;
						      1,  #Adherence;						      
						      0,  #ImmediateArt; 
						      0   #UniversalTestAndTreat; 
	)
)

system.time(
Adherence_2 <- .Call("CallCascade",100, #Pop;
						      0,  #Hbct; 
						      0,  #Vct; 
						      0,  #HbctPocCd4; 
						      0,  #Linkage;
						      0,  #VctPocCd4; 						      
						      0,  #PreOutreach; 
						      0,  #ImprovedCare; 
						      0,  #PocCd4; 
						      0,  #ArtOutreach;
						      2,  #Adherence;						      
						      0,  #ImmediateArt; 
						      0   #UniversalTestAndTreat; 
	)
)

system.time(
ImmediateArt <- .Call("CallCascade",100, #Pop;
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
						      1,  #ImmediateArt; 
						      0   #UniversalTestAndTreat; 
	)
)



sum(Baseline$sDALY) - sum(Adherence_1$sDALY)
sum(Baseline$sDALY) - sum(Adherence_2$sDALY)
sum(Baseline$sDALY) - sum(ImmediateArt$sDALY)

sum(Adherence_1$sDALY)
sum(ArtOutreach_1$sDALY)


sum(result$sDALY) - sum(ArtOutreach_1$sDALY)


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

pie(Adherence_1$sCARE,
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

pie(Adherence_2$sCARE,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)


source("./rScript/BaselineFigures.R")
GenerateBaselineFigures(baseline)
GenerateBaselineFigures(artOutreach_1)
GenerateBaselineFigures(adherence_1)
GenerateBaselineFigures(universalTestAndTreat_1)
