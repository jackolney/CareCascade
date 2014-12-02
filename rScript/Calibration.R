#Calbiration Script for CareCascade
setwd("/Users/jack/git/CareCascade")
source("./rScript/BaselineFigures.R")

system("date")
popSize = 10000
dyn.load("./source/main.so")

Baseline <- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
