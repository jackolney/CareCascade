# Script for work on hotfix to HBCT with active referral (15th July, 2016)

rm(list=ls())
setwd("/Users/jack/git/CareCascade")


system("date")

popSize = 100

dyn.load("./main.so")


runs <- 10
out <- list()
for(i in 1:runs) {
    out[[i]] <- .Call("CallCascade",popSize, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
}


What do we actually need to preserve???
names(Baseline)

Baseline$sDALY
Baseline$sCOST


plot(out[[1]]$sDALY)

save.image()

# Now we need to average across all runs

runs


dalys <- c()
cost <- c()

for(j in 1:runs) {
    dalys[j] <- sum(out[[j]]$sDALY)
    cost[j] <- sum(out[[j]]$sCOST)
}

plot(dalys)


test <- mean(dalys)

test2 <- test * 100

baseDALY <- 27331118
baseCOST <- 4007959217

range(baseDALY - (dalys * 100))
