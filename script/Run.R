#Test Script for CareCascade
rm(list=ls())
setwd("/Users/jack/git/CareCascade")
# source("./rScript/BaselineFigures.R")

system("date")
popSize = 10000
dyn.load("./main.so")

Baseline <- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Baseline
names(Baseline)
Baseline$sCARE
Baseline$sCARE_PT

Baseline$sCARE / Baseline$sCARE_PT


Prev <- Baseline$sHIV_15to49 / Baseline$sPOP_15to49
Inc <- Baseline$sINCIDENCE
Year <- seq(1970,2035,1)
Scenario <- "Baseline"

length(Year)
Output <- data.frame(Year,Prev,Inc)

plot(Baseline$sHIV_15to49 / Baseline$sPOP_15to49,type='l',lwd=2)
# names(Baseline)
# Baseline$sPOP * 100

# totalDALY <- sum(Baseline$sDALY)

# sum(Baseline$sDALY_OffArt)
# sum(Baseline$sDALY_OnArt)
# sum(Baseline$sDALY_LYL)

# sum(Baseline$sDALY_OffArt) + sum(Baseline$sDALY_OnArt) + sum(Baseline$sDALY_LYL)


# theDALY <- c(sum(Baseline$sDALY_OnArt),sum(Baseline$sDALY_OffArt),sum(Baseline$sDALY_LYL))

# Out <- c(theDALY[1] / totalDALY,theDALY[2] / totalDALY,theDALY[3] / totalDALY)

# require(RColorBrewer)
# Color <- brewer.pal(9,"Set1")

# barplot(as.matrix(Out),col=Color)


# Cost Unit Check
require(scales)
dollar(sum(Baseline$sCOST))


# Intervention costs
hctVisitCost = 8.00
rapidHivTestCost = 10.00
preArtClinicVisitCost = 28.00
labCd4TestCost = 12.00
pocCd4TestCost = 42.00
annualArtCost = 367.00
annualAdherenceCost = 33.54
outreachCost = 19.55
annualLinkageCost = 2.61
impCareCost = 7.05

ComparisonCost <- vector()
ComparisonCost[1] <- sum(Baseline$sUNIT_HctVisitCost * Baseline$sUnitCost_HctVisitCost)
ComparisonCost[2] <- sum(Baseline$sUNIT_RapidHivTestCost * Baseline$sUnitCost_RapidHivTestCost)
ComparisonCost[3] <- sum(Baseline$sUNIT_LinkageCost * Baseline$sUnitCost_LinkageCost)
ComparisonCost[4] <- sum(Baseline$sUNIT_ImpCareCost * Baseline$sUnitCost_ImpCareCost)
ComparisonCost[5] <- sum(Baseline$sUNIT_PreArtClinicVisitCost * Baseline$sUnitCost_PreArtClinicVisitCost)
ComparisonCost[6] <- sum(Baseline$sUNIT_LabCd4TestCost * Baseline$sUnitCost_LabCd4TestCost)
ComparisonCost[7] <- sum(Baseline$sUNIT_PocCd4TestCost * Baseline$sUnitCost_PocCd4TestCost)
ComparisonCost[8] <- sum(Baseline$sUNIT_AnnualArtCost * Baseline$sUnitCost_AnnualArtCost)
ComparisonCost[9] <- sum(Baseline$sUNIT_AnnualAdherenceCost * Baseline$sUnitCost_AnnualAdherenceCost)
ComparisonCost[10] <- sum(Baseline$sUNIT_OutreachCost * Baseline$sUnitCost_OutreachCost)

dollar(sum(ComparisonCost))
dollar(sum(Baseline$sCOST))

plot(cumsum(Baseline$sUNIT_AnnualArtCost) * annualArtCost,type='l',lwd=2)
lines(cumsum(Baseline$sArtCOST),lwd=2,col='red')

sum(Baseline$sPreArtCOST)
sum(Baseline$sUNIT_RapidHivTestCost * rapidHivTestCost) + sum(Baseline$sUNIT_PreArtClinicVisitCost * preArtClinicVisitCost) + sum(Baseline$sUNIT_LabCd4TestCost * labCd4TestCost)

# Just focus on ART costs initially. Then scale up.
annualArtCost = 367.00
ArtCost <- vector()
for(i in 1:20) {
    if(i == 1)
        ArtCost[i] <- annualArtCost
    else
        ArtCost[i] <- ArtCost[i-1] * 0.94
}
ArtCost

sum(Baseline$sUNIT_AnnualArtCost * annualArtCost)
plot(cumsum(Baseline$sUNIT_AnnualArtCost * ArtCost),type='l',lwd=2)
lines(cumsum(Baseline$sArtCOST),lwd=2,col='red')


dollar(sum(Baseline$sArtCOST))
dollar(sum(Baseline$sUNIT_AnnualArtCost * ArtCost))

plot(cumsum(Baseline$sUNIT_AnnualArtCost),type='l')
lines(cumsum(Baseline$sArtCOST))


sum(Baseline$sUNIT_AnnualArtCost)

plot(cumsum(Baseline$sArtCOST),type='l',lwd=2)
lines(cumsum(Baseline$sUNIT_AnnualArtCost * Baseline$sUnitCost_AnnualArtCost),lwd=2,col="red")

plot(Baseline$sArtCOST,type='l',lwd=2)
lines(Baseline$sUNIT_AnnualArtCost * Baseline$sUnitCost_AnnualArtCost,lwd=2,col="red")

