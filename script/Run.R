#Test Script for CareCascade
rm(list=ls())
setwd("/Users/jack/git/CareCascade")
# source("./rScript/BaselineFigures.R")

system("date")
popSize = 1000
dyn.load("./main.so")

Baseline <- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Baseline

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