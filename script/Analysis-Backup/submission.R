#Test Script for CareCascade
rm(list=ls())
setwd("/Volumes/jjo11/cascade/CareCascadeV2/2015/November/27th/Normal")
system("mkdir ./plots")
require(plotrix)

# Load up results.
run <- c("run1","run2","run3","run4","run5","run6","run7","run8","run9","run10")
interventions <- c("Baseline", "Hbct_1", "Hbct_2", "Vct_1", "Vct_2", "HbctPocCd4_1", "HbctPocCd4_2", "Linkage_1", "Linkage_2", "VctPocCd4", "PreOutreach_1", "PreOutreach_2", "ImprovedCare_1", "ImprovedCare_2", "PocCd4", "ArtOutreach_1", "ArtOutreach_2", "Adherence_1", "Adherence_2", "ImmediateArt", "UniversalTestAndTreat_1", "UniversalTestAndTreat_2")

# Baseline load to get the size of the output array needed
if(file.exists(gsub(" ","",paste("./",run[1],"/output/",interventions[1],"/currentWorkspace.RData"))))
    load(gsub(" ","",paste("./",run[1],"/output/",interventions[1],"/currentWorkspace.RData"))) else stop("File (run1:baseline) does not exist.")

# Loop through all interventions and runs and dynamically average them #
for(i in 1:length(interventions)) {
    cat(paste("",interventions[i], "\n"))
    # Create vector of names
    outputNames <- c()
    for(m in 1:length(Baseline))
        outputNames[m] <- names(Baseline)[m]
    # Create list
    output <- sapply(outputNames,function(x) NULL)
    for(n in 1:length(output))
        output[[n]] <- vector('double',length(Baseline[[n]]))
    theLength = 0
    for(j in 1:length(run)) {
        if(file.exists(gsub(" ","",paste("./",run[j],"/output/",interventions[i],"/currentWorkspace.RData")))) {
            load(gsub(" ","",paste("./",run[j],"/output/",interventions[i],"/currentWorkspace.RData")))
            cat(paste("\t",run[j], "\n"))
            theLength <- theLength + 1
            for(k in 1:length(Baseline)) {
                # cat(paste("\t\tRow",k, "\n"))
                output[[k]] <- output[[k]] + get(interventions[i])[[k]]
            }
        }
    }
    cat(paste("\t\t\ttheLength =",theLength, "\n"))
    for(l in 1:length(Baseline)) {
        # cat(paste("\t\t\t\tOutputRow",l, "\n"))
        output[[l]] <- output[[l]] / theLength
    }
    assign(interventions[i],output)
}
print("\tComplete!")

##################
# sizeAdjustment #
sizeAdjustment = 10
##################

#####################
# PLOTS AND FIGURES #
#####################

library(RColorBrewer)
p <- brewer.pal(12,"Set3")
d <- brewer.pal(12,"Paired")
R <-brewer.pal(9,"Reds")
O <- brewer.pal(9,"Oranges")
G <-brewer.pal(9,"Greens")
B <-brewer.pal(9,"Blues")
plotCol <- c(R[7],R[5],O[6],p[6],O[3],G[7],p[7],G[3],B[7],B[5],d[10],d[9])

resultDALY <- matrix(0,2,12)
resultDALY[1,1] <- (sum(Baseline$sDALY) - sum(Hbct_1$sDALY)) * sizeAdjustment
resultDALY[2,1] <- (sum(Baseline$sDALY) - sum(Hbct_2$sDALY)) * sizeAdjustment
resultDALY[1,2] <- (sum(Baseline$sDALY) - sum(Vct_1$sDALY)) * sizeAdjustment
resultDALY[2,2] <- (sum(Baseline$sDALY) - sum(Vct_2$sDALY)) * sizeAdjustment
resultDALY[1,3] <- (sum(Baseline$sDALY) - sum(HbctPocCd4_1$sDALY)) * sizeAdjustment
resultDALY[2,3] <- (sum(Baseline$sDALY) - sum(HbctPocCd4_2$sDALY)) * sizeAdjustment
resultDALY[1,4] <- (sum(Baseline$sDALY) - sum(Linkage_1$sDALY)) * sizeAdjustment
resultDALY[2,4] <- (sum(Baseline$sDALY) - sum(Linkage_2$sDALY)) * sizeAdjustment
resultDALY[1,5] <- (sum(Baseline$sDALY) - sum(VctPocCd4$sDALY)) * sizeAdjustment
resultDALY[1,6] <- (sum(Baseline$sDALY) - sum(PreOutreach_1$sDALY)) * sizeAdjustment
resultDALY[2,6] <- (sum(Baseline$sDALY) - sum(PreOutreach_2$sDALY)) * sizeAdjustment
resultDALY[1,7] <- (sum(Baseline$sDALY) - sum(ImprovedCare_1$sDALY)) * sizeAdjustment
resultDALY[2,7] <- (sum(Baseline$sDALY) - sum(ImprovedCare_2$sDALY)) * sizeAdjustment
resultDALY[1,8] <- (sum(Baseline$sDALY) - sum(PocCd4$sDALY)) * sizeAdjustment
resultDALY[1,9] <- (sum(Baseline$sDALY) - sum(ArtOutreach_1$sDALY)) * sizeAdjustment
resultDALY[2,9] <- (sum(Baseline$sDALY) - sum(ArtOutreach_2$sDALY)) * sizeAdjustment
resultDALY[1,10] <- (sum(Baseline$sDALY) - sum(Adherence_1$sDALY)) * sizeAdjustment
resultDALY[2,10] <- (sum(Baseline$sDALY) - sum(Adherence_2$sDALY)) * sizeAdjustment
resultDALY[1,11] <- (sum(Baseline$sDALY) - sum(ImmediateArt$sDALY)) * sizeAdjustment
resultDALY[1,12] <- (sum(Baseline$sDALY) - sum(UniversalTestAndTreat_1$sDALY)) * sizeAdjustment
resultDALY[2,12] <- (sum(Baseline$sDALY) - sum(UniversalTestAndTreat_2$sDALY)) * sizeAdjustment

resultCOST <- matrix(0,2,12)
resultCOST[1,1] <- (sum(Hbct_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,1] <- (sum(Hbct_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,2] <- (sum(Vct_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,2] <- (sum(Vct_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,3] <- (sum(HbctPocCd4_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,3] <- (sum(HbctPocCd4_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,4] <- (sum(Linkage_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,4] <- (sum(Linkage_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,5] <- (sum(VctPocCd4$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,6] <- (sum(PreOutreach_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,6] <- (sum(PreOutreach_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,7] <- (sum(ImprovedCare_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,7] <- (sum(ImprovedCare_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,8] <- (sum(PocCd4$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,9] <- (sum(ArtOutreach_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,9] <- (sum(ArtOutreach_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,10] <- (sum(Adherence_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,10] <- (sum(Adherence_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,11] <- (sum(ImmediateArt$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,12] <- (sum(UniversalTestAndTreat_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,12] <- (sum(UniversalTestAndTreat_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment

################
### FIGURE 3 ###
################

Dalys <- c(resultDALY[2,1],resultDALY[2,2],resultDALY[2,3],resultDALY[2,4],resultDALY[1,5],resultDALY[2,6],resultDALY[2,7],resultDALY[1,8],resultDALY[2,9],resultDALY[2,10],resultDALY[1,11],resultDALY[2,12])
Cost <- c(resultCOST[2,1],resultCOST[2,2],resultCOST[2,3],resultCOST[2,4],resultCOST[1,5],resultCOST[2,6],resultCOST[2,7],resultCOST[1,8],resultCOST[2,9],resultCOST[2,10],resultCOST[1,11],resultCOST[2,12])
Interventions <- c("HBCT","Enhanced VCT","HBCT (with POC CD4)","Facilitated Linkage","VCT POC CD4","Pre-ART Outreach","Improved Care","POC CD4","On-ART Outreach","Adherence","Immediate ART","Universal Test & Treat")
Scenario <- c("Real","Real","Real","Real","Max","Real","Real","Max","Real","Real","Max","Real")
Color <- c(plotCol[1],plotCol[2],plotCol[3],plotCol[4],plotCol[5],plotCol[6],plotCol[7],plotCol[8],plotCol[9],plotCol[10],plotCol[11],plotCol[12])
Iteration <- "mean"

results <- data.frame(Interventions,Scenario,Dalys,Cost,Color,Iteration)
levels(results$Interventions)
results$Interventions <- factor(results$Interventions, levels=c("HBCT","Enhanced VCT","HBCT (with POC CD4)","Facilitated Linkage","VCT POC CD4","Pre-ART Outreach","Improved Care","POC CD4","On-ART Outreach","Adherence","Immediate ART","Universal Test & Treat"))
levels(results$Interventions)
results

results <- mutate(results,label = c("HBCT","VCT","HBCT (with POC CD4)","Linkage","VCT POC CD4","Pre-ART Outreach","Improved Care","POC CD4","On-ART Outreach","Adherence","Immediate ART","Universal Test & Treat"))

graphics.off()
adjustWeight = 0.75
quartz.options(h=5 * adjustWeight,w=8 * adjustWeight)

require(ggplot2)
require(RColorBrewer)
require(scales)
library(grid)

p <- ggplot(results,aes(x=Dalys, y=Cost, fill=Interventions, label=Interventions))
p <- p + geom_point(col=Color,alpha=1, size=3, shape=16)
p <- p + theme_classic()
p <- p + scale_x_continuous(limits=c(0,2e+06), breaks=seq(0,2e+06,5e+05),labels=scientific,expand=c(0,0))
p <- p + scale_y_continuous(limits=c(0,3e+09), breaks=seq(0,3e+09,5e+08),labels=scientific,expand=c(0,0))
p <- p + xlab("DALYs averted")
p <- p + ylab("Additional cost (2013 USD)")
p <- p + ggtitle("DALYs averted and additional cost of interventions acting on HIV care between 2010 and 2030")
p <- p + theme(plot.title=element_text(size=7,face='bold'))
p <- p + theme(axis.title=element_text(size=8))
p <- p + theme(axis.text=element_text(size=7))
p <- p + theme(legend.position=c(0.3,0.32))
p <- p + theme(legend.title=element_blank())
p <- p + theme(legend.text=element_text(size=7))
p <- p + theme(legend.justification=c(1,0))
p <- p + theme(legend.key = element_blank())
p <- p + theme(legend.key.size = unit(0.35, "cm"))
p <- p + theme(plot.margin = unit(c(0.35, 1, 0.3, 0.35), "cm"))
p

# setwd("/Volumes/jjo11/cascade/CareCascadeV2/2015/May/20th_Repeat/")
# system("mkdir ./plots/")
quartz.save(file='./plots/Fig3.pdf',type='pdf')

##############################################
# Bringing in all the other results together #
##############################################

sum(Baseline$sCOST)

# Load up results.
run <- c("run1","run2","run3","run4","run5","run6","run7","run8","run9","run10")
interventions <- c("Baseline", "Hbct_1", "Hbct_2", "Vct_1", "Vct_2", "HbctPocCd4_1", "HbctPocCd4_2", "Linkage_1", "Linkage_2", "VctPocCd4", "PreOutreach_1", "PreOutreach_2", "ImprovedCare_1", "ImprovedCare_2", "PocCd4", "ArtOutreach_1", "ArtOutreach_2", "Adherence_1", "Adherence_2", "ImmediateArt", "UniversalTestAndTreat_1", "UniversalTestAndTreat_2")

# Baseline load to get the size of the output array needed
if(file.exists(gsub(" ","",paste("./",run[1],"/output/",interventions[1],"/currentWorkspace.RData"))))
    load(gsub(" ","",paste("./",run[1],"/output/",interventions[1],"/currentWorkspace.RData"))) else stop("File (run1:baseline) does not exist.")

# Loop through all interventions and runs and dynamically average them #
for(i in 1:length(interventions)) {
    cat(paste(interventions[i], "\n"))
    for(j in 1:length(run)) {
        cat(paste("\t",run[j],"\n"))
        if(file.exists(gsub(" ","",paste("./",run[j],"/output/",interventions[i],"/currentWorkspace.RData")))) {
            theName <- paste(interventions[i],"_",run[j],sep='')
            load(gsub(" ","",paste("./",run[j],"/output/",interventions[i],"/currentWorkspace.RData")))
            assign(theName,get(interventions[i]))
        }
    }
}
print("\tComplete!")

# Bring back the average of BASELINE
outputNames <- c()
for(m in 1:length(Baseline))
    outputNames[m] <- names(Baseline)[m]
# Create list
output <- sapply(outputNames,function(x) NULL)
for(n in 1:length(output))
    output[[n]] <- vector('double',length(Baseline[[n]]))
theLength = 0
for(j in 1:length(run)) {
    if(file.exists(gsub(" ","",paste("./",run[j],"/output/",interventions[1],"/currentWorkspace.RData")))) {
        load(gsub(" ","",paste("./",run[j],"/output/",interventions[1],"/currentWorkspace.RData")))
        cat(paste("\t",run[j], "\n"))
        theLength <- theLength + 1
        for(k in 1:length(Baseline)) {
            # cat(paste("\t\tRow",k, "\n"))
            output[[k]] <- output[[k]] + get(interventions[1])[[k]]
        }
    }
}
cat(paste("\t\t\ttheLength =",theLength, "\n"))
for(l in 1:length(Baseline)) {
    # cat(paste("\t\t\t\tOutputRow",l, "\n"))
    output[[l]] <- output[[l]] / theLength
}
assign(interventions[1],output)


###################################################################################
# Calculated DALYs averted and additional cost relative to MEAN baseline results. #
###################################################################################

short_interventions <- c("Hbct_2","Vct_2","HbctPocCd4_2","Linkage_2","VctPocCd4","PreOutreach_2","ImprovedCare_2","PocCd4","ArtOutreach_2","Adherence_2","ImmediateArt","UniversalTestAndTreat_2")

Calc_DALYs_Averted <- function(Mean_BaselineDALYs,Object,sizeAdjustment) {
    DALYs_Averted <- (Mean_BaselineDALYs - sum(Object$sDALY)) * sizeAdjustment
    return(DALYs_Averted)
}

Calc_Additional_Cost <- function(Mean_BaselineCOST,Object,sizeAdjustment) {
    Additional_Cost <- (sum(Object$sCOST) - Mean_BaselineCOST) * sizeAdjustment
    return(Additional_Cost)
}


Dalys <- c()
Cost <- c()
Interventions <- c()
Iteration <- c()
ScenarioAll <- c()
ColorAll <- c()

theScenario <- c("Real","Real","Real","Real","Max","Real","Real","Max","Real","Real","Max","Real")
theColor <- c(plotCol[1],plotCol[2],plotCol[3],plotCol[4],plotCol[5],plotCol[6],plotCol[7],plotCol[8],plotCol[9],plotCol[10],plotCol[11],plotCol[12])

index <- 0
for(i in 1:length(short_interventions)) {
    print(short_interventions[i])
    for(j in 1:length(run)) {
        index <- index + 1
        Dalys[index] <- Calc_DALYs_Averted(sum(Baseline$sDALY),get(paste(short_interventions[i],"_",run[j],sep='')),sizeAdjustment)
        Cost[index] <- Calc_Additional_Cost(sum(Baseline$sCOST),get(paste(short_interventions[i],"_",run[j],sep='')),sizeAdjustment)
        Interventions[index] <- short_interventions[i]
        ScenarioAll[index] <- theScenario[i]
        ColorAll[index] <- theColor[i]
        Iteration[index] <- run[j]
    }
}
allResults <- data.frame(Dalys,Cost,Interventions,Iteration,ScenarioAll,ColorAll)


# Test Plot
p <- ggplot(allResults,aes(x=Dalys, y=Cost, col=Interventions, label=Interventions))
p <- p + geom_point(col=ColorAll,alpha=1, size=3, shape=16)
p <- p + theme_classic()
p <- p + scale_x_continuous(limits=c(0,2e+06), breaks=seq(0,2e+06,5e+05),labels=scientific,expand=c(0,0))
p <- p + scale_y_continuous(limits=c(0,3e+09), breaks=seq(0,3e+09,5e+08),labels=scientific,expand=c(0,0))
p <- p + xlab("DALYs averted")
p <- p + ylab("Additional cost (2013 USD)")
p <- p + ggtitle("DALYs averted and additional cost of interventions acting on HIV care between 2010 and 2030")
p <- p + theme(plot.title=element_text(size=7,face='bold'))
p <- p + theme(axis.title=element_text(size=8))
p <- p + theme(axis.text=element_text(size=7))
p <- p + theme(legend.position=c(0.3,0.32))
p <- p + theme(legend.title=element_blank())
p <- p + theme(legend.text=element_text(size=7))
p <- p + theme(legend.justification=c(1,0))
p <- p + theme(legend.key = element_blank())
p <- p + theme(legend.key.size = unit(0.35, "cm"))
p <- p + theme(plot.margin = unit(c(0.35, 1, 0.3, 0.35), "cm"))
p


# For i in 1:length(short_interventions),
# run Rmisc::CI across all DALYs and COST
# add to "results" data.frame
# Reproduce figure 3 with error bars

# 95% CI from Normal distribution
# Z-score for 95% is 1.96 = qnorm(0.975)
CI_95 <- function(x) {
    a <- mean(x)
    error <- qnorm(0.975) * sd(x) / sqrt(length(x))
    return(c(upper = a + error, mean = a, lower = a - error))
}


DALY_CI_upper <- c()
DALY_CI_lower <- c()
COST_CI_upper <- c()
COST_CI_lower <- c()

for(i in 1:length(short_interventions)) {
    theDalys <- allResults %>% filter(Interventions == short_interventions[i]) %>% select(Dalys)
    theCost <- allResults %>% filter(Interventions == short_interventions[i]) %>% select(Cost)

    DALY_CI_upper[i] <- CI_95(x = theDalys$Dalys)[[1]]
    DALY_CI_lower[i] <- CI_95(x = theDalys$Dalys)[[3]]

    COST_CI_upper[i] <- CI_95(x = theCost$Cost)[[1]]
    COST_CI_lower[i] <- CI_95(x = theCost$Cost)[[3]]
}

DALY_CI_upper
DALY_CI_lower
COST_CI_upper
COST_CI_lower

results <- mutate(results,Dalys_upper = DALY_CI_upper)
results <- mutate(results,Dalys_lower = DALY_CI_lower)
results <- mutate(results,Cost_upper = COST_CI_upper)
results <- mutate(results,Cost_lower = COST_CI_lower)

p <- ggplot(results,aes(x=Dalys, y=Cost, fill=Interventions, label=Interventions))
p <- p + geom_errorbar(aes(ymax = Cost_upper,ymin = Cost_lower),size=0.3)
p <- p + geom_errorbarh(aes(xmax = Dalys_upper,xmin = Dalys_lower),size=0.3,height=2.5e+7)
p <- p + geom_point(col=Color,alpha=1, size=2, shape=16)
p <- p + theme_classic()
p <- p + scale_x_continuous(limits=c(0,2e+06), breaks=seq(0,2e+06,5e+05),labels=scientific,expand=c(0,0))
p <- p + scale_y_continuous(limits=c(0,3e+09), breaks=seq(0,3e+09,5e+08),labels=scientific,expand=c(0,0))
p <- p + xlab("DALYs averted")
p <- p + ylab("Additional cost (2013 USD)")
p <- p + ggtitle("DALYs averted and additional cost of interventions acting on HIV care between 2010 and 2030")
p <- p + theme(plot.title=element_text(size=7,face='bold'))
p <- p + theme(axis.title=element_text(size=8))
p <- p + theme(axis.text=element_text(size=7))
p <- p + theme(legend.position=c(0.3,0.32))
p <- p + theme(legend.title=element_blank())
p <- p + theme(legend.text=element_text(size=7))
p <- p + theme(legend.justification=c(1,0))
p <- p + theme(legend.key = element_blank())
p <- p + theme(legend.key.size = unit(0.35, "cm"))
p <- p + theme(plot.margin = unit(c(0.35, 1, 0.3, 0.35), "cm"))
p

quartz.save(file='./plots/Fig3_ErrorBars.pdf',type='pdf')

########
# TIFF #
########

adjustWeight = 0.75
tiff(filename = "./plots/Fig3_ErrorBars.tiff",
    width = 8 * adjustWeight,
    height = 5 * adjustWeight,
    units = "in",
    res = 330,
    compression = "lzw",
    bg = "white",
    type = "quartz")

# results
h.just <- c(
    -0.75, # HBCT
    0.5, # VCT
    -0.2,   # HBCT (POC)
    1.2, # Linkage
    -0.375, # VCT POC CD4
    -0.3, # Pre-ART Outreach
    0.25, # Improved Care
    0.63, # POC CD4
    -0.2, # On-ART Outreach
    0.5, # Adherence
    -0.25, # Immediate ART
    -0.2) # UTT

v.just <- c(
    0.525, # HBCT
    -1.3, # VCT
    0.525,   # HBCT (POC)
    -2.5, # Linkage
    0.525, # VCT POC CD4
    0.525, # Pre-ART Outreach
    -6, # Improved Care
    -3.5, # POC CD4
    0.525, # On-ART Outreach
    -1.3, # Adherence
    0.525, # Immediate ART
    0.525) # UTT

p <- ggplot(results,aes(x=Dalys, y=Cost, fill=Interventions, label=Interventions))
p <- p + geom_errorbar(aes(ymax = Cost_upper,ymin = Cost_lower),size=0.3)
p <- p + geom_errorbarh(aes(xmax = Dalys_upper,xmin = Dalys_lower),size=0.3,height=2.5e+7)
p <- p + geom_point(col=Color,alpha=1, size=2, shape=16)
p <- p + theme_classic()
p <- p + geom_text(aes(label=label),size=1.4,hjust=h.just,vjust=v.just)
p <- p + geom_segment(aes(x=103511.1 * 0.82, y=39745385 * 1.5, xend=101511.1 * 0.5, yend=39745385 * 3),size=0.1) # Linkage
p <- p + geom_segment(aes(x=112655.6 * 0.95, y=107400470 * 1.4, xend=112655.6 * 0.875, yend=107400470 * 2.1),size=0.1) # POC CD4
p <- p + geom_segment(aes(x=155461.8 * 1.05, y=156742136 * 1.3, xend=155461.8 * 1.15, yend=156742136 * 2.35),size=0.1) # Improved Care
p <- p + scale_x_continuous(limits=c(0,2e+06), breaks=seq(0,2e+06,5e+05),labels=scientific,expand=c(0,0))
p <- p + scale_y_continuous(limits=c(0,3e+09), breaks=seq(0,3e+09,5e+08),labels=scientific,expand=c(0,0))
p <- p + xlab("DALYs averted")
p <- p + ylab("Additional cost (2013 USD)")
p <- p + ggtitle("DALYs averted and additional cost of interventions acting on HIV care between 2010 and 2030")
p <- p + theme(plot.title=element_text(size=7,face='bold'))
p <- p + theme(axis.title=element_text(size=8))
p <- p + theme(axis.text=element_text(size=7))
p <- p + theme(legend.position=c(0.3,0.32))
p <- p + theme(legend.title=element_blank())
p <- p + theme(legend.text=element_text(size=7))
p <- p + theme(legend.justification=c(1,0))
p <- p + theme(legend.key = element_blank())
p <- p + theme(legend.key.size = unit(0.35, "cm"))
p <- p + theme(plot.margin = unit(c(0.35, 1, 0.3, 0.35), "cm"))
p

dev.off()


################
### FIGURE 2 ###
################

library(RColorBrewer)
m <- brewer.pal(11,"Spectral")
p <- brewer.pal(9,"Set1")
require(plotrix)

graphics.off()
adjustWeight = 0.75
quartz.options(h=5 * adjustWeight,w=8 * adjustWeight)


par(family="Arial",cex=1,mar=c(2,2,2,2))
plot.new()
bisect.angles <- floating.pie(0,0,Baseline$sCARE,startpos=pi/2)
pie(Baseline$sCARE,
    init.angle=90,
    labels=c("Never tested",
            "Tested but never\nlinked to care",
            "Tested and linked, but\n never initiated ART",
            "Initiated ART but died\nfollowing late initiation (<200)",
            "Initiated ART but\ndied off ART",
            "Initiatied ART but\nnot late (>200)"),
    col=c(m[1:6]),
    border=NA,
    cex.main=1,
    cex=0.7)
pie.values <- gsub(" ","",paste(round(Baseline$sCARE / sum(Baseline$sCARE),2) * 100,"%"))
par(family="Arial Bold",cex=1)
pie.labels(0,0,bisect.angles,pie.values,radius=0.45)

quartz.save(file='./plots/Fig2.pdf',type='pdf')

# ##########################
# # BACK TO FUCKING TIFF's #
# ##########################

bisect.angles <- floating.pie(0,0,Baseline$sCARE,startpos=pi/2)
adjustWeight = 0.75
tiff(filename = "./plots/Fig2.tiff",
    width = 8 * adjustWeight,
    height = 5 * adjustWeight,
    units = "in",
    res = 300,
    compression = "lzw",
    bg = "white",
    type = "quartz")

par(family="Arial",cex=1,mar=c(2,2,2,2))
plot.new()
pie(Baseline$sCARE,
    init.angle=90,
    labels=c("Never tested",
            "Tested but never\nlinked to care",
            "Tested and linked, but\n never initiated ART",
            "Initiated ART but died\nfollowing late initiation (<200)",
            "Initiated ART but\ndied off ART",
            "Initiatied ART but\nnot late (>200)"),
    col=c(m[1:6]),
    border=NA,
    radius=1,
    cex.main=1,
    cex=0.7)
pie.values <- gsub(" ","",paste(round(Baseline$sCARE / sum(Baseline$sCARE),2) * 100,"%"))
par(family="Arial Bold",cex=1)
pie.labels(0,0,bisect.angles,pie.values,radius=0.45)

dev.off()

# ############
# # FIGURE 4 #
# ############

# graphics.off()
# adjustWeight = 0.7
# quartz.options(h=7.5 * adjustWeight,w=7.5 * adjustWeight)

# par(family="Arial")
#     barplot(mortalityPlot * sizeAdjustment,
#         col=c(o[1:6]),
#         cex.main=0.8,
#         cex.lab=0.8,
#         space=c(0.5),
#         border=NA,
#         main="Care experience among HIV-related deaths between 2010 and 2030",
#         ylim=c(0,8e+05),
#         ylab="HIV-related deaths between 2010 and 2030",
#         yaxt='n',
#         xaxt='n')
# axis(2,at=seq(0,8e+05,1e+05),labels=c(" ",format(seq(1e+05,8e+05,1e+05),big.mark=",",scientific=FALSE)),las=3,cex.axis=0.55)
# axis(2,at=0,labels=0,hadj=c(0.5),cex.axis=0.55)

# mtext("Baseline",1,at=1,0.6,cex=0.4)
# mtext("Immediate\nART",1,at=2.5,0.75,cex=0.4)
# mtext("Combination of\ninterventions",1,at=4,0.75,cex=0.4)
# mtext("Immediate ART &\n HBCT (UTT)",1,at=5.5,0.75,cex=0.4)
# mtext("Immediate ART &\n combination of\n interventions",1,at=7,1,cex=0.4)
# mtext("UTT &\n combination of\n interventions",1,at=8.5,1,cex=0.4)

# labels=c("Never tested", "Tested but never linked to care", "Tested and linked, but never initiated ART", "Initiated ART but died following late initiation (<200)", "Initiated ART but died off ART", "Initiatied ART but not late (>200)")
# legend("topright",
#     labels,
#     fill=c(o[1:6]),
#     cex=0.5,
#     box.lty=0)

# text(1,(sum(mortalityPlot[,1]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$4.16b")),cex=0.5)
# text(2.5,(sum(mortalityPlot[,2]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$4.70b")),cex=0.5)
# text(4,(sum(mortalityPlot[,3]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$4.79b")),cex=0.5)
# text(5.5,(sum(mortalityPlot[,4]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$6.97b")),cex=0.5)
# text(7,(sum(mortalityPlot[,5]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$5.29b")),cex=0.5)
# text(8.5,(sum(mortalityPlot[,6]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$7.78b")),cex=0.5)

# quartz.save(file='./plots/Fig4.pdf',type='pdf')



# library(RColorBrewer)
# o <- brewer.pal(11,"Spectral")

# mortalityPlot <- as.matrix(data.frame(Baseline$sCARE,ImmediateArt$sCARE,Multi_5$sCARE,UniversalTestAndTreat_2$sCARE,ImmediateArtAndMulti_5$sCARE,UttAndMulti_5$sCARE))

# tiff(filename = "./plots/Fig4.tiff",
#     width = 7.5 * adjustWeight,
#     height = 7.5 * adjustWeight,
#     units = "in",
#     res = 300,
#     compression = "lzw",
#     bg = "white",
#     type = "quartz")

# par(family="Arial")
#     barplot(mortalityPlot * sizeAdjustment,
#         col=c(o[1:6]),
#         cex.main=0.8,
#         cex.lab=0.8,
#         space=c(0.5),
#         border=NA,
#         main="Care experience among HIV-related deaths between 2010 and 2030",
#         ylim=c(0,8e+05),
#         ylab="HIV-related deaths between 2010 and 2030",
#         yaxt='n',
#         xaxt='n')
# axis(2,at=seq(0,8e+05,1e+05),labels=c(" ",format(seq(1e+05,8e+05,1e+05),big.mark=",",scientific=FALSE)),las=3,cex.axis=0.55)
# axis(2,at=0,labels=0,hadj=c(0.5),cex.axis=0.55)

# mtext("Baseline",1,at=1,0.6,cex=0.4)
# mtext("Immediate\nART",1,at=2.5,0.75,cex=0.4)
# mtext("Combination of\ninterventions",1,at=4,0.75,cex=0.4)
# mtext("Immediate ART &\n HBCT (UTT)",1,at=5.5,0.75,cex=0.4)
# mtext("Immediate ART &\n combination of\n interventions",1,at=7,1,cex=0.4)
# mtext("UTT &\n combination of\n interventions",1,at=8.5,1,cex=0.4)

# labels=c("Never tested", "Tested but never linked to care", "Tested and linked, but never initiated ART", "Initiated ART but died following late initiation (<200)", "Initiated ART but died off ART", "Initiatied ART but not late (>200)")
# legend("topright",
#     labels,
#     fill=c(o[1:6]),
#     cex=0.5,
#     box.lty=0)

# text(1,(sum(mortalityPlot[,1]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$4.16b")),cex=0.5)
# text(2.5,(sum(mortalityPlot[,2]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$4.70b")),cex=0.5)
# text(4,(sum(mortalityPlot[,3]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$4.79b")),cex=0.5)
# text(5.5,(sum(mortalityPlot[,4]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$6.97b")),cex=0.5)
# text(7,(sum(mortalityPlot[,5]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$5.29b")),cex=0.5)
# text(8.5,(sum(mortalityPlot[,6]) * sizeAdjustment) + 2e+04,gsub(" ","",paste("$7.78b")),cex=0.5)

# dev.off()

# ############
# # EPS SHIT #
# ############

# # require(extrafont)
# # font_import()
# # fonts()

# # loadfonts(device = "postscript")

# # setEPS()
# # postscript("./plots/Fig2.eps",
# #     height = 5,
# #     width = 8,
# #     family = "Arial",
# #     paper = "special",
# #     onefile = FALSE,
# #     horizontal = FALSE)

# # par(family="Arial",cex=1,mar=c(2,2,2,2))
# # plot.new()
# # bisect.angles <- floating.pie(0,0,Baseline$sCARE,startpos=pi/2)
# # pie(Baseline$sCARE,
# #     init.angle=90,
# #     labels=c("Never tested",
# #             "Tested but never\nlinked to care",
# #             "Tested and linked, but\n never initiated ART",
# #             "Initiated ART but died\nfollowing late initiation (<200)",
# #             "Initiated ART but\ndied off ART",
# #             "Initiatied ART but\nnot late (>200)"),
# #     col=c(m[1:6]),
# #     border=NA,
# #     cex.main=1,
# #     cex=0.7)
# # pie.values <- gsub(" ","",paste(round(Baseline$sCARE / sum(Baseline$sCARE),2) * 100,"%"))
# # par(family="Arial Bold",cex=1)
# # pie.labels(0,0,bisect.angles,pie.values,radius=0.45)

# # dev.off()

# # FUCK THIS FUCKING SHIT!
