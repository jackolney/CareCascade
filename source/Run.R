#Test Script for CareCascade
setwd("/Users/jack/git/CareCascade/source")
dyn.load("main.so")


system.time(
result <- .Call("CallCascade",1, #Pop;
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

graphics.off()
quartz.options(h=12,w=5)
par(mfrow=c(3,1))
plot(result$sPOP_15to49,type='l',lwd=2)
plot(result$sHIV_15to49,type='l',lwd=2)
plot(result$sART_15to49,type='l',lwd=2)

# Figures
graphics.off()
quartz.options(h=10,w=10)
library(RColorBrewer)
p <- brewer.pal(9,"Set1")

####################
#Hiv Prevalence
Unaids_HivPrev <- read.csv("/Users/jack/git/CareCascade/estimates/UNAIDS_HivPrevalence_Kenya.csv",header=TRUE)
Unaids_HivPrev$year

plot(seq(0,59,1),result$sHIV_15to49 / result$sPOP_15to49,
	type='l',
	col=p[2],
	lwd=2,
	ylim=c(0,0.1),
	main='HIV Prevalence',
	xlab='Year',
	ylab='Prevalence',
	xaxt='n')
lines(seq(20,42,1),Unaids_HivPrev$prev,
	lwd=2,
	lty=3,
	col=p[1])
axis(1,seq(0,60,5),seq(1970,2030,5))
legend("topright",c("UNAIDS 15-49yr","CareCascade 15-49yr"),
	fill=p[1:2],
	box.lty=0,
	border=NA,
	cex=1.2)

####################
#PlwhivOnArt
Unaids_PlwhivOnArt <- read.csv("/Users/jack/git/CareCascade/estimates/UNAIDS_PlwhivOnArt_Kenya.csv",header=TRUE)

plot(seq(0,59,1),result$sART_15to49 / result$sHIV_15to49,
	type='l',
	col=p[2],
	lwd=2,
	ylim=c(0,0.5),
	main='Proportion of PLWHIV on ART',
	xlab='Year',
	ylab='Proportion',
	xaxt='n')
lines(seq(34,42,1),Unaids_PlwhivOnArt$propPlwhivOnArt,
	lwd=2,
	lty=3,
	col=p[1])
axis(1,seq(0,60,5),seq(1970,2030,5))
legend("topright",c("UNAIDS","CareCascade"),
	fill=p[1:2],
	box.lty=0,
	border=NA,
	cex=1.2)

####################
#Proportion of AIDS-related deaths in general population
Unaids_AidsDeaths <- read.csv("/Users/jack/git/CareCascade/estimates/UNAIDS_AidsRelatedDeaths.csv",header=TRUE)


plot(seq(0,59,1),result$sAidsDeath_15plus / result$sPOP_15plus,
	type='l',
	col=p[2],
	lwd=2,
	ylim=c(0,0.01),
	main='Proportion of AIDS-realted deaths in population',
	xlab='Year',
	ylab='Proportion',
	xaxt='n')
lines(seq(20,42,1),Unaids_AidsDeaths$proportion,
	lwd=2,
	lty=3,
	col=p[1])
axis(1,seq(0,60,5),seq(1970,2030,5))
legend("topright",c("UNAIDS (unspecified)","CareCascade >15yrs"),
	fill=p[1:2],
	box.lty=0,
	border=NA,
	cex=1.2)


####################
#KAIS 2007 - HIV prevalence by Age and Sex. (National)
Kais2007_PrevByAgeSex <- read.csv("/Users/jack/git/CareCascade/estimates/Kais2007_PrevByAgeSex.csv",header=TRUE)

######
#MALE#
######

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2007 / result$sPOP_AgeSex_2007)[11:20],
	type='b',
	lwd=3,
	main="HIV prevalence among men 15-64 years old",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.15))
lines(Kais2007_PrevByAgeSex$male,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=3)
axis(1,seq(1,10,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-54",
		"55-59",
		"60-64"),
	cex.axis=1.2)
axis(2,seq(0,0.15,0.02),seq(0,15,2),las=1,cex.axis=1.2)
legend("topright",
	c("Model 2007 - Males","KAIS 2007 - Males"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.5)

########
#FEMALE#
########

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2007 / result$sPOP_AgeSex_2007)[1:10],
	type='b',
	lwd=3,
	main="HIV prevalence among women 15-64 years old",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.15))
lines(Kais2007_PrevByAgeSex$female,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=3)
axis(1,seq(1,10,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-54",
		"55-59",
		"60-64"),
	cex.axis=1.2)
axis(2,seq(0,0.15,0.02),seq(0,15,2),las=1,cex.axis=1.2)
legend("topright",
	c("Model 2007 - Females","KAIS 2007 - Females"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.5)

####################
#KAIS 2012 - HIV prevalence by Age and Sex. (National)
Kais2012_PrevByAgeSex <- read.csv("/Users/jack/git/CareCascade/estimates/Kais2012_PrevByAgeSex.csv",header=TRUE)

(result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[1:8]
(result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[9:16]

######
#MALE#
######

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[9:16],
	type='b',
	lwd=3,
	main="HIV prevalence among Men in Kenya Nationally in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.16),
	)

lines(Kais2012_PrevByAgeSex$men,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confLower.1,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confHigher.1,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)
axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.16,0.02),seq(0,16,2),las=1,cex.axis=1.5)
legend("topright",
	c("Model 2012 - Males","KAIS 2012 Nyanza - Males"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.5)

########
#FEMALE#
########

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[1:8],
	type='b',
	lwd=3,
	main="HIV prevalence among Women in Kenya Nationally in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.16),
	)

lines(Kais2012_PrevByAgeSex$women,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confLower.2,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confHigher.2,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)
axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.16,0.02),seq(0,16,2),las=1,cex.axis=1.5)
legend("topright",
	c("Model 2012 - Females","KAIS 2012 Nyanza - Females"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.5)

#################
#NYANZA PROVINCE#
#################

######
#MALE#
######

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[9:16],
	type='b',
	lwd=3,
	main="HIV prevalence among Men in Nyanza Province in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.5),
	)

lines(Kais2012_PrevByAgeSex$men.1,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confLower.4,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confHigher.4,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)
axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.5,0.05),seq(0,50,5),las=1,cex.axis=1.5)
legend("topright",
	c("Model 2012 - Males","KAIS 2012 Nyanza - Males"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.5)

########
#FEMALE#
########

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[1:8],
	type='b',
	lwd=3,
	main="HIV prevalence among Women in Nyanza Province in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.5),
	)

lines(Kais2012_PrevByAgeSex$women.1,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confLower.5,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confHigher.5,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)

axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.5,0.05),seq(0,50,5),las=1,cex.axis=1.5)
legend("topright",
	c("Model 2012 - Females","KAIS 2012 Nyanza - Females"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.5)

##################
#WESTERN PROVINCE#
##################

######
#MALE#
######

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[9:16],
	type='b',
	lwd=3,
	main="HIV prevalence among Men in Western Province in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.3),
	)

lines(Kais2012_PrevByAgeSex$men.2,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confLower.7,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confHigher.7,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)
axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.3,0.05),seq(0,30,5),las=1,cex.axis=1.5)
legend("topright",
	c("Model 2012 - Males","KAIS 2012 Western - Males"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.5)

########
#FEMALE#
########

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[1:8],
	type='b',
	lwd=3,
	main="HIV prevalence among Women in Western Province in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.3),
	)

lines(Kais2012_PrevByAgeSex$women.2,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confLower.8,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)

lines(Kais2012_PrevByAgeSex$confHigher.8,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=3)
axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.3,0.05),seq(0,30,5),las=1,cex.axis=1.5)
legend("topright",
	c("Model 2012 - Females","KAIS 2012 Western - Females"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.5)

####################
#CD4 distribution over time

Cd4DistributionTotal <- matrix(0,8,60)
Cd4DistributionTotal[1,] <- result$sCd4_200 - result$sCd4_200_Art
Cd4DistributionTotal[2,] <- result$sCd4_200_Art
Cd4DistributionTotal[3,] <- result$sCd4_200350 - result$sCd4_200350_Art
Cd4DistributionTotal[4,] <- result$sCd4_200350_Art
Cd4DistributionTotal[5,] <- result$sCd4_350500 - result$sCd4_350500_Art
Cd4DistributionTotal[6,] <- result$sCd4_350500_Art
Cd4DistributionTotal[7,] <- result$sCd4_500 - result$sCd4_500_Art
Cd4DistributionTotal[8,] <- result$sCd4_500_Art

Cd4DistributionProp <- matrix(0,8,60)
Cd4DistributionProp[1,] <- (result$sCd4_200 - result$sCd4_200_Art) / colSums(Cd4DistributionTotal)
Cd4DistributionProp[2,] <- result$sCd4_200_Art / colSums(Cd4DistributionTotal)
Cd4DistributionProp[3,] <- (result$sCd4_200350 - result$sCd4_200350_Art) / colSums(Cd4DistributionTotal)
Cd4DistributionProp[4,] <- result$sCd4_200350_Art / colSums(Cd4DistributionTotal)
Cd4DistributionProp[5,] <- (result$sCd4_350500 - result$sCd4_350500_Art) / colSums(Cd4DistributionTotal)
Cd4DistributionProp[6,] <- result$sCd4_350500_Art / colSums(Cd4DistributionTotal)
Cd4DistributionProp[7,] <- (result$sCd4_500 - result$sCd4_500_Art) / colSums(Cd4DistributionTotal)
Cd4DistributionProp[8,] <- result$sCd4_500_Art / colSums(Cd4DistributionTotal)

require(RColorBrewer)
m <- brewer.pal(11,"RdYlGn")

par(family="Avenir Next Bold")
barplot(Cd4DistributionProp,
	space=0,
	border=1,
	col=c(m[1],m[11],m[2],m[10],m[3],m[9],m[4],m[8]),
	xlab="Year",
	main="CD4 distribution among HIV-positive individuals over time",
	ylab="Proportion",
	yaxt='n',
	xlim=c(5,60))
axis(1,seq(4.5,59.5,5),seq(1975,2030,5))
axis(2,seq(0,1,0.1),las=1)

####################
#Cd4 distrubition among people not on ART in 2007
Kais2007_Cd4 <- read.csv("/Users/jack/git/CareCascade/estimates/Kais2007_Cd4.csv",header=TRUE)

Model_Cd4_1 <- result$sPOP_NoArtCd4_2007[1] / sum(result$sPOP_NoArtCd4_2007)
Model_Cd4_2 <- result$sPOP_NoArtCd4_2007[2] / sum(result$sPOP_NoArtCd4_2007)
Model_Cd4_3 <- result$sPOP_NoArtCd4_2007[3] / sum(result$sPOP_NoArtCd4_2007)
Model_Cd4_4 <- result$sPOP_NoArtCd4_2007[4] / sum(result$sPOP_NoArtCd4_2007)
Model_Cd4 <- c(Model_Cd4_1,Model_Cd4_2,Model_Cd4_3,Model_Cd4_4)

Cd4_Bar <- matrix(0,4,2)
Cd4_Bar[,1] <- Model_Cd4
Cd4_Bar[,2] <- Kais2007_Cd4[,2]

graphics.off()
quartz.options(w=10,h=12)

par(family="Helvetica Neue Bold")
barplot(Cd4_Bar,
	border=NA,
	width=c(1,1),
	main="CD4 distribution among individuals not on ART in 2007",
	yaxt='n',
	ylab="Proportion",
	cex.main=1.5,
	cex.lab=1.2,
	ylim=c(0,1),
	col=m)
axis(2,seq(0,1,0.1),las=1,cex.axis=1.2)
mtext("Model 2007",1,at=0.7,1,cex=1.5)
mtext("KAIS 2007",1,at=1.9,1,cex=1.5)

####################
#AMPATH Prevalence in 2014
Ampath2014 <- read.csv("/Users/jack/git/CareCascade/estimates/Ampath2014_PrevByAgeSex.csv",header=TRUE)

######
#MALE#
######

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2014 / result$sPOP_AgeSex_2014)[6:10],
	type='b',
	lwd=3,
	main="HIV prevalence among Men on 22/05/2014",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.24))
lines(Ampath2014$male,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=3)
axis(1,seq(1,5,1),
	c("0-14",
		"14-21",
		"21-29",
		"29-46",
		">46"),
	cex.axis=1.5)
axis(2,seq(0,0.24,0.02),seq(0,24,2),las=1,cex.axis=1.5)
legend("topright",
	c("Model 22/05/2014 - Males","AMPATH 22/05/2014 - Males"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.5)

lines(Ampath2014$male,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=3)

########
#FEMALE#
########

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2014 / result$sPOP_AgeSex_2014)[1:5],
	type='b',
	lwd=3,
	main="HIV prevalence among Women on 22/05/2014",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.24))
lines(Ampath2014$female,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=3)

axis(1,seq(1,5,1),
	c("0-14",
		"14-21",
		"21-29",
		"29-46",
		">46"),
	cex.axis=1.5)
axis(2,seq(0,0.24,0.02),seq(0,24,2),las=1,cex.axis=1.5)
legend("topright",
	c("Model 22/05/2014 - Females","AMPATH 22/05/2014 - Females"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.5)
