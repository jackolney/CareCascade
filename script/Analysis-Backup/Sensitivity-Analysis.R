# Sensitivity Analysis for 'CareCascade' #
# 30th November, 2015 #

rm(list=ls())
setwd("/Volumes/jjo11/cascade/CareCascadeV2/2015/November/27th/Normal")

# Take the mean impact (and cost)
# Unit cost work out range...
# Check over with Tim and Jeff

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

# What are the unit costs?
UnitCost <- data.frame(
    "UnitCost_HctVisit" = 8,
    "UnitCost_RapidHivTest" = 10,
    "UnitCost_Linkage" = 2.61,
    "UnitCost_ImpCare" = 7.05,
    "UnitCost_PreArtClinicVisit" = 28,
    "UnitCost_LabCd4Test" = 12,
    "UnitCost_PocCd4Test" = 42,
    "UnitCost_AnnualArtCost" = 367,
    "UnitCost_AnnualAdherence" = 33.54,
    "UnitCost_Outreach" = 19.55
    )

Calculate_Cost <- function(Object,InitialCost,SizeAdjustment) {

    # Create decaying cost matrix
    theUnitCost <- matrix(0,10,20)
    rownames(theUnitCost) <- c("UnitCost_HctVisit","UnitCost_RapidHivTest","UnitCost_Linkage","UnitCost_ImpCare","UnitCost_PreArtClinicVisit","UnitCost_LabCd4Test","UnitCost_PocCd4Test","UnitCost_AnnualArtCost","UnitCost_AnnualAdherence","UnitCost_Outreach")
    colnames(theUnitCost) <- seq(2010,2029,1)

    # Populate it.
    theUnitCost["UnitCost_HctVisit","2010"] <- as.double(InitialCost["UnitCost_HctVisit"])
    theUnitCost["UnitCost_RapidHivTest","2010"] <- as.double(InitialCost["UnitCost_RapidHivTest"])
    theUnitCost["UnitCost_Linkage","2010"] <- as.double(InitialCost["UnitCost_Linkage"])
    theUnitCost["UnitCost_ImpCare","2010"] <- as.double(InitialCost["UnitCost_ImpCare"])
    theUnitCost["UnitCost_PreArtClinicVisit","2010"] <- as.double(InitialCost["UnitCost_PreArtClinicVisit"])
    theUnitCost["UnitCost_LabCd4Test","2010"] <- as.double(InitialCost["UnitCost_LabCd4Test"])
    theUnitCost["UnitCost_PocCd4Test","2010"] <- as.double(InitialCost["UnitCost_PocCd4Test"])
    theUnitCost["UnitCost_AnnualArtCost","2010"] <- as.double(InitialCost["UnitCost_AnnualArtCost"])
    theUnitCost["UnitCost_AnnualAdherence","2010"] <- as.double(InitialCost["UnitCost_AnnualAdherence"])
    theUnitCost["UnitCost_Outreach","2010"] <- as.double(InitialCost["UnitCost_Outreach"])

    # Create discount function
    Cost_Discount <- function(CostMatrix,PercentPerYear) {
        for(i in 1:dim(CostMatrix)[1]) {
            for(j in 1:dim(CostMatrix)[2]) {
                if(j > 1)
                    CostMatrix[i,j] <- CostMatrix[i,j-1] * (1-PercentPerYear)
            } 
        }
        return(CostMatrix)
    }

    # Run discount function over time (20 years) at 6% per year.
    theUnitCost <- Cost_Discount(theUnitCost,0.06)

    # Create output COST matrix.
    theCost <- matrix(0,10,20)
    rownames(theCost) <- c("theCost_HctVisit","theCost_RapidHivTest","theCost_Linkage","theCost_ImpCare","theCost_PreArtClinicVisit","theCost_LabCd4Test","theCost_PocCd4Test","theCost_AnnualArtCost","theCost_AnnualAdherence","theCost_Outreach")
    colnames(theCost) <- seq(2010,2029,1)

    # Populate it, multiplying the UNIT COSTS (decaying) by the OBJECT cost
    theCost["theCost_HctVisit",] <- (Object$sUNIT_HctVisitCost * as.double(theUnitCost["UnitCost_HctVisit",])) * SizeAdjustment
    theCost["theCost_RapidHivTest",] <- (Object$sUNIT_RapidHivTestCost * as.double(theUnitCost["UnitCost_RapidHivTest",])) * SizeAdjustment
    theCost["theCost_Linkage",] <- (Object$sUNIT_LinkageCost * as.double(theUnitCost["UnitCost_Linkage",])) * SizeAdjustment
    theCost["theCost_ImpCare",] <- (Object$sUNIT_ImpCareCost * as.double(theUnitCost["UnitCost_ImpCare",])) * SizeAdjustment
    theCost["theCost_PreArtClinicVisit",] <- (Object$sUNIT_PreArtClinicVisitCost * as.double(theUnitCost["UnitCost_PreArtClinicVisit",])) * SizeAdjustment
    theCost["theCost_LabCd4Test",] <- (Object$sUNIT_LabCd4TestCost * as.double(theUnitCost["UnitCost_LabCd4Test",])) * SizeAdjustment
    theCost["theCost_PocCd4Test",] <- (Object$sUNIT_PocCd4TestCost * as.double(theUnitCost["UnitCost_PocCd4Test",])) * SizeAdjustment
    theCost["theCost_AnnualArtCost",] <- (Object$sUNIT_AnnualArtCost * as.double(theUnitCost["UnitCost_AnnualArtCost",])) * SizeAdjustment
    theCost["theCost_AnnualAdherence",] <- (Object$sUNIT_AnnualAdherenceCost * as.double(theUnitCost["UnitCost_AnnualAdherence",])) * SizeAdjustment
    theCost["theCost_Outreach",] <- (Object$sUNIT_OutreachCost * as.double(theUnitCost["UnitCost_Outreach",])) * SizeAdjustment

    return(theCost)
}

sum(Calculate_Cost(Baseline,UnitCost,10))
sum(Baseline$sCOST) * 10

# The LatinHyper to update a vector from all this.
# In some cases I need to ignore various costs.
# And only implement the costs when certain interventions are implemented.

# Will need a range of parRange's for each intervention.
# REMEMBER THAT COST IS ADDITIONAL... RELATIVE TO BASELINE.
# remember we only need to do this for 'short_interventions' not all the maximum blah blah BS.
# Do we either:
# 1) Use the MEAN 'Baseline' and just vary unit costs in the interventions.
# 2) For each draw of parameters, do the calculation: Intervention$COST - Baseline$COST and plot that.

Calculate_LatinHyper <- function(TheIntervention,Draws) {
    # Baseline Unit Costs
    HctVisit.Normal <- 8
    RapidHivTest.Normal <- 10
    Linkage.Normal <- 2.61
    ImpCare.Normal <- 7.05
    PreArtClinicVisit.Normal <- 28
    LabCd4Test.Normal <- 12
    PocCd4Test.Normal <- 42
    AnnualArt.Normal <- 367
    AnnualAdherence.Normal <- 33.54
    Outreach.Normal <- 19.55

    # Set the .min and .max values to 1 (adjusted next).
    HctVisit.min = 1
    HctVisit.max = 1
    PocCd4Test.min = 1
    PocCd4Test.max = 1
    Linkage.min = 1
    Linkage.max = 1
    Outreach.min = 1
    Outreach.max = 1
    ImpCare.min = 1
    ImpCare.max = 1
    Adherence.min = 1
    Adherence.max = 1

    # Selection algorithm which varies that costs that are manipulated for each loop.
    if(TheIntervention == "Hbct_2") {
        HctVisit.min = 0.5
        HctVisit.max = 1.5
    } else if(TheIntervention == "HbctPocCd4_2") {
        HctVisit.min = 0.5
        HctVisit.max = 1.5
        PocCd4Test.min = 0.5
        PocCd4Test.max = 1.5
    } else if(TheIntervention == "Linkage_2") {
        Linkage.min = 0.5
        Linkage.max = 1.5
    } else if(TheIntervention == "VctPocCd4") {
        PocCd4Test.min = 0.5
        PocCd4Test.max = 1.5
    } else if(TheIntervention == "PreOutreach_2") {
        Outreach.min = 0.5
        Outreach.max = 1.5
    } else if(TheIntervention == "ImprovedCare_2") {
        ImpCare.min = 0.5
        ImpCare.max = 1.5
    } else if(TheIntervention == "PocCd4") {
        PocCd4Test.min = 0.5
        PocCd4Test.max = 1.5
    } else if(TheIntervention == "ArtOutreach_2") {
        Outreach.min = 0.5
        Outreach.max = 1.5
    } else if(TheIntervention == "Adherence_2") {
        Adherence.min = 0.5
        Adherence.max = 1.5
    } else if(TheIntervention == "UniversalTestAndTreat_2") {
        HctVisit.min = 0.5
        HctVisit.max = 1.5
    }

    # .min = 50% .max = 150%
    parRange <- data.frame(min = c(
        HctVisit.Normal * HctVisit.min,
        RapidHivTest.Normal * 0.5,
        Linkage.Normal * Linkage.min,
        ImpCare.Normal * ImpCare.min,
        PreArtClinicVisit.Normal * 0.5,
        LabCd4Test.Normal * 0.5,
        PocCd4Test.Normal * PocCd4Test.min,
        AnnualArt.Normal * 0.5,
        AnnualAdherence.Normal * Adherence.min,
        Outreach.Normal * Outreach.min),
    max = c(
        HctVisit.Normal * HctVisit.max,
        RapidHivTest.Normal * 1.5,
        Linkage.Normal * Linkage.max,
        ImpCare.Normal * ImpCare.max,
        PreArtClinicVisit.Normal * 1.5,
        LabCd4Test.Normal * 1.5,
        PocCd4Test.Normal * PocCd4Test.max,
        AnnualArt.Normal * 1.5,
        AnnualAdherence.Normal * Adherence.max,
        Outreach.Normal * Outreach.max))

    rownames(parRange) <- c("UnitCost_HctVisit","UnitCost_RapidHivTest","UnitCost_Linkage","UnitCost_ImpCare","UnitCost_PreArtClinicVisit","UnitCost_LabCd4Test","UnitCost_PocCd4Test","UnitCost_AnnualArtCost","UnitCost_AnnualAdherence","UnitCost_Outreach")

    LHS_Cost <- FME::Latinhyper(parRange,Draws)

    return(LHS_Cost)
}

Calculate_LatinHyper("Baseline",10)

################################
# Read in previous results set #
################################

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

Dalys <- c(resultDALY[2,1],resultDALY[2,2],resultDALY[2,3],resultDALY[2,4],resultDALY[1,5],resultDALY[2,6],resultDALY[2,7],resultDALY[1,8],resultDALY[2,9],resultDALY[2,10],resultDALY[1,11],resultDALY[2,12])
Cost <- c(resultCOST[2,1],resultCOST[2,2],resultCOST[2,3],resultCOST[2,4],resultCOST[1,5],resultCOST[2,6],resultCOST[2,7],resultCOST[1,8],resultCOST[2,9],resultCOST[2,10],resultCOST[1,11],resultCOST[2,12])
Interventions <- c("HBCT","Enhanced VCT","HBCT (with POC CD4)","Facilitated Linkage","VCT POC CD4","Pre-ART Outreach","Improved Care","POC CD4","On-ART Outreach","Adherence","Immediate ART","Universal Test & Treat")
Scenario <- c("Real","Real","Real","Real","Max","Real","Real","Max","Real","Real","Max","Real")
Color <- c(plotCol[1],plotCol[2],plotCol[3],plotCol[4],plotCol[5],plotCol[6],plotCol[7],plotCol[8],plotCol[9],plotCol[10],plotCol[11],plotCol[12])
results <- data.frame(Interventions,Scenario,Dalys,Cost,Color)
results <- mutate(results, Iteration = "mean")
results$Interventions <- factor(results$Interventions, levels=c("HBCT","Enhanced VCT","HBCT (with POC CD4)","Facilitated Linkage","VCT POC CD4","Pre-ART Outreach","Improved Care","POC CD4","On-ART Outreach","Adherence","Immediate ART","Universal Test & Treat"))
results

#########
# SETUP #
#########

LHS_Length <- 1000
TheResults <- results
short_interventions <- c("Hbct_2","Vct_2","HbctPocCd4_2","Linkage_2","VctPocCd4","PreOutreach_2","ImprovedCare_2","PocCd4","ArtOutreach_2","Adherence_2","ImmediateArt","UniversalTestAndTreat_2")
TheColor <- Color

for(i in 1:length(short_interventions)) {
    print(short_interventions[i])
    # Dont need to calculate seperate costs for each draw
    TheSample <- Calculate_LatinHyper(short_interventions[i],LHS_Length)

    for(j in 1:dim(TheSample)[1]) {
        cat(paste("\t",j,"\n"))
        # Calculate the BASELINE cost
        BaselineCost <- sum(Calculate_Cost(Baseline,TheSample[j,],10))
        
        # The INTERVENTION cost
        InterventionCost <- sum(Calculate_Cost(get(short_interventions[i]),TheSample[j,],10))

        # The cost comparison
        TheCost <- InterventionCost - BaselineCost

        # Fill out a row to be bound into 'results'

        # Intervention name
        Interventions <- c("HBCT","Enhanced VCT","HBCT (with POC CD4)","Facilitated Linkage","VCT POC CD4","Pre-ART Outreach","Improved Care","POC CD4","On-ART Outreach","Adherence","Immediate ART","Universal Test & Treat")
        Intervention.out <- Interventions[i]

        # Scenario (real or max) [not really relevant anymore]
        Scenario <- c("Real","Real","Real","Real","Max","Real","Real","Max","Real","Real","Max","Real")
        Scenario.out <- Scenario[i]

        # Dalys averted (taking MEAN)
        Daly.out <- Dalys[i]

        # Cost
        Cost.out <- TheCost

        # Color (pick relevant intervention color from the Color array)
        Color.out <- Color[i]

        # Iteration (enter LHS #)
        Iteration.out <- paste("LHS_",j,sep='')

        # Bring all together
        LHS_Result <- list(Intervention.out,Scenario.out,Daly.out,Cost.out,Color.out,Iteration.out)

        # BIND to 'results'
        TheResults <- rbind(TheResults,LHS_Result)
    }
    TheColor <- c(Color,
        rep(Color[1],LHS_Length),
        rep(Color[2],LHS_Length),
        rep(Color[3],LHS_Length),
        rep(Color[4],LHS_Length),
        rep(Color[5],LHS_Length),
        rep(Color[6],LHS_Length),
        rep(Color[7],LHS_Length),
        rep(Color[8],LHS_Length),
        rep(Color[9],LHS_Length),
        rep(Color[10],LHS_Length),
        rep(Color[11],LHS_Length),
        rep(Color[12],LHS_Length))
}

# levels(TheResults$Interventions)
TheResults$Interventions <- factor(TheResults$Interventions, levels=c("HBCT","Enhanced VCT","HBCT (with POC CD4)","Facilitated Linkage","VCT POC CD4","Pre-ART Outreach","Improved Care","POC CD4","On-ART Outreach","Adherence","Immediate ART","Universal Test & Treat"))
# levels(TheResults$Interventions)

graphics.off()
adjustWeight = 0.75
quartz.options(h=5 * adjustWeight,w=8 * adjustWeight)
require(ggplot2)
require(RColorBrewer)
require(scales)
library(grid)

p <- ggplot(TheResults,aes(x=Dalys, y=Cost))
p <- p + geom_point(col=TheColor, alpha=1/30, size=0.5, shape=16)
p <- p + theme_classic()
p <- p + scale_x_continuous(limits=c(0,2e+06), breaks=seq(0,2e+06,5e+05),labels=scientific,expand=c(0,0))
p <- p + scale_y_continuous(limits=c(0,4.5e+09), breaks=seq(0,4.5e+09,5e+08),labels=scientific,expand=c(0,0))
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
p <- p + geom_point(data=results,aes(x=Dalys, y=Cost, fill=Interventions, label=Interventions),col=Color,alpha=1, size=2, shape=16)
p

quartz.save(file='./plots/Fig3_Uncertainty.pdf',type='pdf')

#################
# DATA ANALYSIS #
#################

# For example to see the range of costs that result from the LHS methods.
TheResults %>% filter(Interventions == "HBCT") %>% select(Cost) %>% range() %>% dollar()

