#Test Script for CareCascade

setwd("/Users/jack/git/CareCascade/source")
dyn.load("main.so")


system.time(
result <- .Call("CallCascade",10, #Pop;
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

pop <- result$sPOP
hiv <- result$sHIV
art <- result$sART

prev <- hiv / pop
plot(prev,type='l',lwd=2)
abline(v=33)

onart <- art / hiv
plot(onart,type='l',lwd=2)
