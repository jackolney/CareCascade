#Test Script for CareCascade
setwd("/Users/jack/git/CareCascade")
source("./rScript/BaselineFigures.R")

system("date")
popSize = 100
dyn.load("./source/main.so")

Baseline <- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Baseline

Baseline$s2007output
Baseline$s2011output
Baseline$s2015output

the2007survival <- Baseline$s2007output / Baseline$s2007output[1]
the2011survival <- Baseline$s2011output / Baseline$s2011output[1]
the2015survival <- Baseline$s2015output / Baseline$s2015output[1]

1-the2007survival[7]
1-the2011survival[7]
1-the2015survival[7]

yrs <- c(0,0.5,1,2,3,4,5)

graphics.off()
quartz.options(w=15,h=5)

par(mfrow=c(1,3),family="Avenir Next Bold")
plot(yrs,the2007survival,
    type='b',
    main="Survival after initiating ART between 2007 and 2008",
    xlab="Time since ART initiation (years)",
    ylab="Survival",
    ylim=c(0.6,1),
    lwd=2,
    col="red"
    )
plot(yrs,the2011survival,
    type='b',
    main="Survival after initiating ART between 2011 and 2012",
    xlab="Time since ART initiation (years)",
    ylab="Survival",
    ylim=c(0.6,1),
    lwd=2,
    col="red"
    )

plot(yrs,the2015survival,
    type='b',
    main="Survival after initiating ART between 2015 and 2016",
    xlab="Time since ART initiation (years)",
    ylab="Survival",
    ylim=c(0.6,1),
    lwd=2,
    col="red"
    )

