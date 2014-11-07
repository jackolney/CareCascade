#Test Script for Debugging

#HivDeathDate
hivDeath <- read.csv("/Users/jack/Desktop/hivDeath.csv")
range(hivDeath[,1])

hist(hivDeath[,1],50)

plot(hivDeath[,1])

sHivDeath <- sort(hivDeath[,1],TRUE)

plot(sHivDeath,type='l')

require(survival)

SurvHivDeath <- survfit(Surv(hivDeath[,1])~1)
plot(SurvHivDeath)

T <- sum(hivDeath[,1]!=0)

sum(hivDeath[,1]<1000) / T

sum(hivDeath[,1]>1000) / T

#It looks like HIV deaths are a bit weirdly skewed maybe?

#initialAge1970

age1970 <- read.csv("/Users/jack/Desktop/initialAge1970.csv")
range(age1970[,1])

plot(age1970[,1])

a <- sort(age1970[,1],TRUE)
plot(a,type='l')

SurvAge <- survfit(Surv(age1970[,1])~1)

plot(SurvAge)

hist(age1970[,1])


i <- read.csv("/Users/jack/Desktop/i.csv")

range(i[,1])

hist(i[,1],30)

abline(v=18)