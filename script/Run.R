#Test Script for CareCascade
setwd("/Users/jack/git/CareCascade")
source("./rScript/BaselineFigures.R")

system("date")
popSize = 100
dyn.load("./source/main.so")

Baseline <- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Baseline


totalDALY <- sum(Baseline$sDALY)

sum(Baseline$sDALY_OffArt)
sum(Baseline$sDALY_OnArt)
sum(Baseline$sDALY_LYL)

sum(Baseline$sDALY_OffArt) + sum(Baseline$sDALY_OnArt) + sum(Baseline$sDALY_LYL)


theDALY <- c(sum(Baseline$sDALY_OnArt),sum(Baseline$sDALY_OffArt),sum(Baseline$sDALY_LYL))

Out <- c(theDALY[1] / totalDALY,theDALY[2] / totalDALY,theDALY[3] / totalDALY)

require(RColorBrewer)
Color <- brewer.pal(9,"Set1")

barplot(as.matrix(Out),col=Color)