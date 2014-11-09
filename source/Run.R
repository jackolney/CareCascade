#Test Script for CareCascade
setwd("/Users/jack/git/CareCascade/source")
dyn.load("main.so")


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

graphics.off()
quartz.options(h=12,w=5)
par(mfrow=c(3,1))
plot(result$sPOP,type='l',lwd=2)
plot(result$sHIV,type='l',lwd=2)
plot(result$sART,type='l',lwd=2)

# Figures
graphics.off()
quartz.options(h=10,w=10)
library(RColorBrewer)
p <- brewer.pal(9,"Set1")

plot(result$sPOP_15to49,type='l',lwd=2)
plot(result$sHIV_15to49,type='l',lwd=2)

pop <- result$sPOP
hiv <- result$sHIV
art <- result$sART

#Hiv Prevalence
pop_15to49 <- result$sPOP_15to49
hiv_15to49 <- result$sHIV_15to49
art_15to49 <- result$sART_15to49

#Hiv Prevalence
prev_15to49 <- hiv_15to49 / pop_15to49

Unaids_HivPrev <- read.csv("/Users/jack/git/CareCascade/estimates/UNAIDS_HivPrevalence_Kenya.csv",header=TRUE)
Unaids_HivPrev$year

plot(seq(0,59,1),prev_15to49,
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
abline(v=31)

#PlwhivOnArt
onart_15to49 <- art_15to49 / hiv_15to49

Unaids_PlwhivOnArt <- read.csv("/Users/jack/git/CareCascade/estimates/UNAIDS_PlwhivOnArt_Kenya.csv",header=TRUE)

plot(seq(0,59,1),onart_15to49,
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

#####
