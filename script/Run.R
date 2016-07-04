#Test Script for CareCascade
rm(list=ls())
setwd("/Users/jack/git/CareCascade")
# source("./rScript/BaselineFigures.R")

system("date")
popSize = 100
dyn.load("./main.so")

# // [[Rcpp:export]]
#  above definition of CallCascade in the cpp file
# Rcpp::compileAttributes()
# devtools::document()

Baseline <- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Baseline
names(Baseline)
Baseline$sCARE
Baseline$sCARE2
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

plot(cumsum(Baseline$sUNIT_AnnualArtCost * Baseline$sUnitCost_AnnualArtCost),type='l',lwd=2)
lines(cumsum(Baseline$sArtCOST),lwd=2,col='red')

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

plot(cumsum(Baseline$sUNIT_AnnualArtCost * ArtCost),type='l',lwd=2)
lines(cumsum(Baseline$sArtCOST),lwd=2,col='red')


one <- Baseline$sCARE
two <- Baseline$sCARE2

state <- c("Never tested",
        "Tested but never\nlinked to care",
        "Tested and linked, but\n never initiated ART",
        "Initiated ART but died\nfollowing late initiation (<200)",
        "Initiated ART but\ndied off ART",
        "Initiatied ART but\nnot late (>200)")

test <- data.frame(state, one, two)

out <- reshape2::melt(test)

out$state <- factor(out$state, levels = state)

ggplot(out, aes(x = state, y = value, fill = variable)) + geom_bar(stat = "identity", position = "dodge")


Baseline$sCARE1_m
Baseline$sCARE1_f

Baseline$sCARE2_m
Baseline$sCARE2_f
