#Accessing the files on fi--san02.dide.local
#Results from sweep_ONE (run_1)
setwd("/Volumes/jjo11/cascade/post_paris/18th_September/")
#Don't actually use the below.

graphics.off()
quartz.options(w=18,h=12)
library(RColorBrewer)
p <- brewer.pal(12,"Set3")
m <- brewer.pal(8,"Accent")
d <- brewer.pal(12,"Paired")

#plot_col <- c(p[1],p[12],p[3],p[4],p[5],p[6],p[7],p[8],p[11],p[9],p[10])


R <-brewer.pal(9,"Reds")
# Y <-brewer.pal(9,"YlOrBr")
O <- brewer.pal(9,"Oranges")
G <-brewer.pal(9,"Greens")
B <-brewer.pal(9,"Blues")

#plot_col <- c(B[7],p[5],R[7],p[4],G[6],p[7],p[11],p[1],O[6],p[6],d[10],p[10])
#plot_col <- c(B[7],B[5],R[7],R[5],G[7],p[7],G[5],G[3],O[6],p[6],d[10],d[9])
plot_col <- c(
R[7],R[5],
O[6],p[6],
G[7],p[7],G[5],G[3],
B[7],B[5],
d[10],d[9]
	)
# big_col <- c(R[8], R[7],R[4],R[5], Y[5], Y[4], Y[3],O[7],O[6],O[5],O[4],O[3], G[8], G[7], G[6], G[5], B[8], B[7], B[6])
plot_col
#plot(seq(0,10,1))
#legend("topleft",c("R8","R7","R6","R5","Y5","Y4","Y3","O[7]","O[6]","O[5]","O[4]","O[3]","G8","G7","G6","G5","B8","B7","B6"),fill=big_col,border=NA,box.lty=0,cex=2)

#Whole BARPLOT
baseline_1 	<- cumsum(read.csv("./workshopRun1/output/baseline/incidence/daly_hiv.csv",header=TRUE)[2])
baseline_2 	<- cumsum(read.csv("./workshopRun2/output/baseline/incidence/daly_hiv.csv",header=TRUE)[2])
baseline_3 	<- cumsum(read.csv("./workshopRun3/output/baseline/incidence/daly_hiv.csv",header=TRUE)[2])
baseline_4 	<- cumsum(read.csv("./workshopRun4/output/baseline/incidence/daly_hiv.csv",header=TRUE)[2])
baseline <- (baseline_1 + baseline_2 + baseline_3 + baseline_4) / 4
baseline[20,]

int_1a_1		<- cumsum(read.csv("./workshopRun1/output/int_1a/incidence/daly_hiv.csv",header=TRUE)[2])
int_1a_2		<- cumsum(read.csv("./workshopRun2/output/int_1a/incidence/daly_hiv.csv",header=TRUE)[2])
int_1a_3		<- cumsum(read.csv("./workshopRun3/output/int_1a/incidence/daly_hiv.csv",header=TRUE)[2])
int_1a_4		<- cumsum(read.csv("./workshopRun4/output/int_1a/incidence/daly_hiv.csv",header=TRUE)[2])
int_1a <- (int_1a_1 + int_1a_2 + int_1a_3 + int_1a_4) / 4


int_1b_1 		<- cumsum(read.csv("./workshopRun1/output/int_1b/incidence/daly_hiv.csv",header=TRUE)[2])
int_1b_2 		<- cumsum(read.csv("./workshopRun2/output/int_1b/incidence/daly_hiv.csv",header=TRUE)[2])
int_1b_3 		<- cumsum(read.csv("./workshopRun3/output/int_1b/incidence/daly_hiv.csv",header=TRUE)[2])
int_1b_4 		<- cumsum(read.csv("./workshopRun4/output/int_1b/incidence/daly_hiv.csv",header=TRUE)[2])
int_1b <- (int_1b_1 + int_1b_2 + int_1b_3 + int_1b_4) / 4


int_2a_1 		<- cumsum(read.csv("./workshopRun1/output/int_2a/incidence/daly_hiv.csv",header=TRUE)[2])
int_2a_2 		<- cumsum(read.csv("./workshopRun2/output/int_2a/incidence/daly_hiv.csv",header=TRUE)[2])
int_2a_3 		<- cumsum(read.csv("./workshopRun3/output/int_2a/incidence/daly_hiv.csv",header=TRUE)[2])
int_2a_4 		<- cumsum(read.csv("./workshopRun4/output/int_2a/incidence/daly_hiv.csv",header=TRUE)[2])
int_2a <- (int_2a_1 + int_2a_2 + int_2a_3 + int_2a_4) / 4


int_2b_1 		<- cumsum(read.csv("./workshopRun1/output/int_2b/incidence/daly_hiv.csv",header=TRUE)[2])
int_2b_2 		<- cumsum(read.csv("./workshopRun2/output/int_2b/incidence/daly_hiv.csv",header=TRUE)[2])
int_2b_3 		<- cumsum(read.csv("./workshopRun3/output/int_2b/incidence/daly_hiv.csv",header=TRUE)[2])
int_2b_4 		<- cumsum(read.csv("./workshopRun4/output/int_2b/incidence/daly_hiv.csv",header=TRUE)[2])
int_2b <- (int_2b_1 + int_2b_2 + int_2b_3 + int_2b_4) / 4


int_3a_1		<- cumsum(read.csv("./workshopRun1/output/int_3a/incidence/daly_hiv.csv",header=TRUE)[2])
int_3a_2		<- cumsum(read.csv("./workshopRun2/output/int_3a/incidence/daly_hiv.csv",header=TRUE)[2])
int_3a_3		<- cumsum(read.csv("./workshopRun3/output/int_3a/incidence/daly_hiv.csv",header=TRUE)[2])
int_3a_4		<- cumsum(read.csv("./workshopRun6/output/int_3a/incidence/daly_hiv.csv",header=TRUE)[2])
int_3a <- (int_3a_1 + int_3a_2 + int_3a_3 + int_3a_4) / 4


int_3b_1 		<- cumsum(read.csv("./workshopRun1/output/int_3b/incidence/daly_hiv.csv",header=TRUE)[2])
int_3b_2 		<- cumsum(read.csv("./workshopRun2/output/int_3b/incidence/daly_hiv.csv",header=TRUE)[2])
int_3b_3 		<- cumsum(read.csv("./workshopRun6/output/int_3b/incidence/daly_hiv.csv",header=TRUE)[2])
int_3b_4 		<- cumsum(read.csv("./workshopRun4/output/int_3b/incidence/daly_hiv.csv",header=TRUE)[2])
int_3b <- (int_3b_1 + int_3b_2 + int_3b_3 + int_3b_4) / 4


int_4a_1 		<- cumsum(read.csv("./workshopRun1/output/int_4a/incidence/daly_hiv.csv",header=TRUE)[2])
int_4a_2 		<- cumsum(read.csv("./workshopRun2/output/int_4a/incidence/daly_hiv.csv",header=TRUE)[2])
int_4a_3 		<- cumsum(read.csv("./workshopRun3/output/int_4a/incidence/daly_hiv.csv",header=TRUE)[2])
int_4a_4 		<- cumsum(read.csv("./workshopRun4/output/int_4a/incidence/daly_hiv.csv",header=TRUE)[2])
int_4a <- (int_4a_1 + int_4a_2 + int_4a_3 + int_4a_4) / 4


int_4b_1		<- cumsum(read.csv("./workshopRun1/output/int_4b/incidence/daly_hiv.csv",header=TRUE)[2])
int_4b_2		<- cumsum(read.csv("./workshopRun2/output/int_4b/incidence/daly_hiv.csv",header=TRUE)[2])
int_4b_3		<- cumsum(read.csv("./workshopRun3/output/int_4b/incidence/daly_hiv.csv",header=TRUE)[2])
int_4b_4		<- cumsum(read.csv("./workshopRun4/output/int_4b/incidence/daly_hiv.csv",header=TRUE)[2])
int_4b <- (int_4b_1 + int_4b_2 + int_4b_3 + int_4b_4) / 4


int_5a_1 		<- cumsum(read.csv("./workshopRun1/output/int_5a/incidence/daly_hiv.csv",header=TRUE)[2])
int_5a_2 		<- cumsum(read.csv("./workshopRun2/output/int_5a/incidence/daly_hiv.csv",header=TRUE)[2])
int_5a_3 		<- cumsum(read.csv("./workshopRun3/output/int_5a/incidence/daly_hiv.csv",header=TRUE)[2])
int_5a_4 		<- cumsum(read.csv("./workshopRun4/output/int_5a/incidence/daly_hiv.csv",header=TRUE)[2])
int_5a <- (int_5a_1 + int_5a_2 + int_5a_3 + int_5a_4) / 4


int_5b_1 		<- cumsum(read.csv("./workshopRun1/output/int_5b/incidence/daly_hiv.csv",header=TRUE)[2])
int_5b_2 		<- cumsum(read.csv("./workshopRun2/output/int_5b/incidence/daly_hiv.csv",header=TRUE)[2])
int_5b_3 		<- cumsum(read.csv("./workshopRun3/output/int_5b/incidence/daly_hiv.csv",header=TRUE)[2])
int_5b_4 		<- cumsum(read.csv("./workshopRun4/output/int_5b/incidence/daly_hiv.csv",header=TRUE)[2])
int_5b <- (int_5b_1 + int_5b_2 + int_5b_3 + int_5b_4) / 4


int_6a_1 		<- cumsum(read.csv("./workshopRun1/output/int_6a/incidence/daly_hiv.csv",header=TRUE)[2])
int_6a_2 		<- cumsum(read.csv("./workshopRun2/output/int_6a/incidence/daly_hiv.csv",header=TRUE)[2])
int_6a_3 		<- cumsum(read.csv("./workshopRun3/output/int_6a/incidence/daly_hiv.csv",header=TRUE)[2])
int_6a_4 		<- cumsum(read.csv("./workshopRun4/output/int_6a/incidence/daly_hiv.csv",header=TRUE)[2])
int_6a <- (int_6a_1 + int_6a_2 + int_6a_3 + int_6a_4) / 4


int_6b_1 		<- cumsum(read.csv("./workshopRun1/output/int_6b/incidence/daly_hiv.csv",header=TRUE)[2])
int_6b_2 		<- cumsum(read.csv("./workshopRun2/output/int_6b/incidence/daly_hiv.csv",header=TRUE)[2])
int_6b_3 		<- cumsum(read.csv("./workshopRun3/output/int_6b/incidence/daly_hiv.csv",header=TRUE)[2])
int_6b_4 		<- cumsum(read.csv("./workshopRun4/output/int_6b/incidence/daly_hiv.csv",header=TRUE)[2])
int_6b <- (int_6b_1 + int_6b_2 + int_6b_3 + int_6b_4) / 4


int_7_1  		<- cumsum(read.csv("./workshopRun1/output/int_7/incidence/daly_hiv.csv",header=TRUE)[2])
int_7_2  		<- cumsum(read.csv("./workshopRun2/output/int_7/incidence/daly_hiv.csv",header=TRUE)[2])
int_7_3  		<- cumsum(read.csv("./workshopRun3/output/int_7/incidence/daly_hiv.csv",header=TRUE)[2])
int_7_4  		<- cumsum(read.csv("./workshopRun4/output/int_7/incidence/daly_hiv.csv",header=TRUE)[2])
int_7 <- (int_7_1 + int_7_2 + int_7_3 + int_7_4) / 4


int_8a_1 		<- cumsum(read.csv("./workshopRun1/output/int_8a/incidence/daly_hiv.csv",header=TRUE)[2])
int_8a_2 		<- cumsum(read.csv("./workshopRun2/output/int_8a/incidence/daly_hiv.csv",header=TRUE)[2])
int_8a_3 		<- cumsum(read.csv("./workshopRun3/output/int_8a/incidence/daly_hiv.csv",header=TRUE)[2])
int_8a_4 		<- cumsum(read.csv("./workshopRun4/output/int_8a/incidence/daly_hiv.csv",header=TRUE)[2])
int_8a <- (int_8a_1 + int_8a_2 + int_8a_3 + int_8a_4) / 4


int_8b_1 		<- cumsum(read.csv("./workshopRun1/output/int_8b/incidence/daly_hiv.csv",header=TRUE)[2])
int_8b_2 		<- cumsum(read.csv("./workshopRun2/output/int_8b/incidence/daly_hiv.csv",header=TRUE)[2])
int_8b_3 		<- cumsum(read.csv("./workshopRun3/output/int_8b/incidence/daly_hiv.csv",header=TRUE)[2])
int_8b_4 		<- cumsum(read.csv("./workshopRun4/output/int_8b/incidence/daly_hiv.csv",header=TRUE)[2])
int_8b <- (int_8b_1 + int_8b_2 + int_8b_3 + int_8b_4) / 4


int_9a_1 		<- cumsum(read.csv("./workshopRun1/output/int_9a/incidence/daly_hiv.csv",header=TRUE)[2])
int_9a_2 		<- cumsum(read.csv("./workshopRun2/output/int_9a/incidence/daly_hiv.csv",header=TRUE)[2])
int_9a_3 		<- cumsum(read.csv("./workshopRun3/output/int_9a/incidence/daly_hiv.csv",header=TRUE)[2])
int_9a_4 		<- cumsum(read.csv("./workshopRun4/output/int_9a/incidence/daly_hiv.csv",header=TRUE)[2])
int_9a <- (int_9a_1 + int_9a_2 + int_9a_3 + int_9a_4) / 4


int_9b_1 		<- cumsum(read.csv("./workshopRun1/output/int_9b/incidence/daly_hiv.csv",header=TRUE)[2])
int_9b_2 		<- cumsum(read.csv("./workshopRun2/output/int_9b/incidence/daly_hiv.csv",header=TRUE)[2])
int_9b_3 		<- cumsum(read.csv("./workshopRun3/output/int_9b/incidence/daly_hiv.csv",header=TRUE)[2])
int_9b_4 		<- cumsum(read.csv("./workshopRun4/output/int_9b/incidence/daly_hiv.csv",header=TRUE)[2])
int_9b <- (int_9b_1 + int_9b_2 + int_9b_3 + int_9b_4) / 4


int_10_1 		<- cumsum(read.csv("./workshopRun1/output/int_10/incidence/daly_hiv.csv",header=TRUE)[2])
int_10_2 		<- cumsum(read.csv("./workshopRun2/output/int_10/incidence/daly_hiv.csv",header=TRUE)[2])
int_10_3 		<- cumsum(read.csv("./workshopRun3/output/int_10/incidence/daly_hiv.csv",header=TRUE)[2])
int_10_4 		<- cumsum(read.csv("./workshopRun4/output/int_10/incidence/daly_hiv.csv",header=TRUE)[2])
int_10 <- (int_10_1 + int_10_2 + int_10_3 + int_10_4) / 4


int_11a_1 	<- cumsum(read.csv("./workshopRun1/output/int_11a/incidence/daly_hiv.csv",header=TRUE)[2])
int_11a_2 	<- cumsum(read.csv("./workshopRun2/output/int_11a/incidence/daly_hiv.csv",header=TRUE)[2])
int_11a_3 	<- cumsum(read.csv("./workshopRun3/output/int_11a/incidence/daly_hiv.csv",header=TRUE)[2])
int_11a_4 	<- cumsum(read.csv("./workshopRun4/output/int_11a/incidence/daly_hiv.csv",header=TRUE)[2])
int_11a <- (int_11a_1 + int_11a_2 + int_11a_3 + int_11a_4) / 4


int_11b_1 	<- cumsum(read.csv("./workshopRun1/output/int_11b/incidence/daly_hiv.csv",header=TRUE)[2])
int_11b_2 	<- cumsum(read.csv("./workshopRun2/output/int_11b/incidence/daly_hiv.csv",header=TRUE)[2])
int_11b_3 	<- cumsum(read.csv("./workshopRun3/output/int_11b/incidence/daly_hiv.csv",header=TRUE)[2])
int_11b_4 	<- cumsum(read.csv("./workshopRun4/output/int_11b/incidence/daly_hiv.csv",header=TRUE)[2])
int_11b <- (int_11b_1 + int_11b_2 + int_11b_3 + int_11b_4) / 4

int_12_1 	<- cumsum(read.csv("./workshopRun6/output/int_12/incidence/daly_hiv.csv",header=TRUE)[2])
int_12_2 	<- cumsum(read.csv("./workshopRun7/output/int_12/incidence/daly_hiv.csv",header=TRUE)[2])
int_12_3 	<- cumsum(read.csv("./workshopRun8/output/int_12/incidence/daly_hiv.csv",header=TRUE)[2])
int_12_4 	<- cumsum(read.csv("./workshopRun9/output/int_12/incidence/daly_hiv.csv",header=TRUE)[2])
int_12 <- (int_12_1 + int_12_2 + int_12_3 + int_12_4) / 4

dif_1a 		<- baseline[20,] - int_1a[20,]
dif_1b 		<- baseline[20,] - int_1b[20,]
dif_2a 		<- baseline[20,] - int_2a[20,]
dif_2b 		<- baseline[20,] - int_2b[20,]
dif_3a 		<- baseline[20,] - int_3a[20,]
dif_3b		<- baseline[20,] - int_3b[20,]
dif_4a 		<- baseline[20,] - int_4a[20,]
dif_4b 		<- baseline[20,] - int_4b[20,]
dif_5a 		<- baseline[20,] - int_5a[20,]
dif_5b 		<- baseline[20,] - int_5b[20,]
dif_6a 		<- baseline[20,] - int_6a[20,]
dif_6b 		<- baseline[20,] - int_6b[20,]
dif_7 		<- baseline[20,] - int_7[20,]
dif_8a 		<- baseline[20,] - int_8a[20,]
dif_8b 		<- baseline[20,] - int_8b[20,]
dif_9a 		<- baseline[20,] - int_9a[20,]
dif_9b 		<- baseline[20,] - int_9b[20,]
dif_10 		<- baseline[20,] - int_10[20,]
dif_11a 	<- baseline[20,] - int_11a[20,]
dif_11b 	<- baseline[20,] - int_11b[20,]
dif_12 		<- baseline[20,] - int_12[20,]


dif <- matrix(0,2,12)

dif[1,1] <- dif_1a
dif[2,1] <- dif_1b
dif[1,2] <- dif_2a
dif[2,2] <- dif_2b
dif[1,3] <- dif_3a
dif[2,3] <- dif_3b
dif[1,4] <- dif_4a
dif[2,4] <- dif_4b
dif[1,5] <- dif_5a
dif[2,5] <- dif_5b
dif[1,6] <- dif_6a
dif[2,6] <- dif_6b
dif[1,7] <- dif_12
dif[1,8] <- dif_7
dif[1,9] <- dif_8a
dif[2,9] <- dif_8b
dif[1,10] <- dif_9a
dif[2,10] <- dif_9b
dif[1,11] <- dif_10
dif[1,12] <- dif_11a
dif[2,12] <- dif_11b



par(family="Avenir Next Bold")
	barplot(dif[1,],
		col=plot_col,
		border=NA,
		cex.main=1.5,
		cex.lab=1.2,
		main="DALY's averted between 2010 and 2030",
		ylim=c(0,5e+05),
		ylab="DALY's averted",
		yaxt='n')
	axis(2,at=seq(0,5e+05,5e+04),labels=format(seq(0,5e+05,5e+04),big.mark=","),las=3,cex.axis=1)
	mtext("HBCT",1,								at=0.7,1,cex=1)
	mtext("VCT",1,								at=1.9,1,cex=1)
	mtext("HBCT\n POC CD4",1,					at=3.1,1.5,cex=1)
	mtext("Linkage",1,							at=4.3,1,cex=1)
	mtext("Pre-ART\n Outreach",1,				at=5.5,1.5,cex=1)
	mtext("Improved\n Care",1,					at=6.7,1.5,cex=1)
	mtext("VCT\nPOC CD4",1,						at=7.9,1.5,cex=1)
	mtext("POC CD4",1,							at=9.1,1,cex=1)
	mtext("ART\n Outreach",1,					at=10.3,1.5,cex=1)
	mtext("Adherence",1,						at=11.5,1.5,cex=1)
	mtext("Immediate\n ART",1,					at=12.7,1.5,cex=1)
	mtext("UTT",1,								at=13.9,1.5,cex=1)
	
	barplot(dif[2,],
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1,1,1,1,1,1,0,0,1,1,0,1),
		density=30)

legend("topleft",
	c("Maximum Impact","Realistic Impact"),
	fill=1,
	density=c(100,30),
	cex=1.5,
	border=NA,
	box.lty=0)

abline(v=2.5,lty=3,lwd=1.5)
abline(v=4.9,lty=3,lwd=1.5)
abline(v=9.7,lty=3,lwd=1.5)
abline(v=12.1,lty=3,lwd=1.5)

quartz.save("./plots/impact_barplot.pdf",type='pdf')

################################################
################################################
################################################
#Cost Impact plot
baseline_cost_1 	<- cumsum(read.csv("./workshopRun1/output/baseline/incidence/cost.csv",header=TRUE))[2]
baseline_cost_2 	<- cumsum(read.csv("./workshopRun2/output/baseline/incidence/cost.csv",header=TRUE))[2]
baseline_cost_3 	<- cumsum(read.csv("./workshopRun3/output/baseline/incidence/cost.csv",header=TRUE))[2]
baseline_cost_4 	<- cumsum(read.csv("./workshopRun4/output/baseline/incidence/cost.csv",header=TRUE))[2]
baseline_cost <- (baseline_cost_1 + baseline_cost_2 + baseline_cost_3 + baseline_cost_4) / 4

int_1a_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_1a/incidence/cost.csv",header=TRUE))[2]
int_1a_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_1a/incidence/cost.csv",header=TRUE))[2]
int_1a_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_1a/incidence/cost.csv",header=TRUE))[2]
int_1a_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_1a/incidence/cost.csv",header=TRUE))[2]
int_1a_cost <- (int_1a_cost_1 + int_1a_cost_2 + int_1a_cost_3 + int_1a_cost_4) / 4


int_1b_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_1b/incidence/cost.csv",header=TRUE))[2]
int_1b_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_1b/incidence/cost.csv",header=TRUE))[2]
int_1b_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_1b/incidence/cost.csv",header=TRUE))[2]
int_1b_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_1b/incidence/cost.csv",header=TRUE))[2]
int_1b_cost <- (int_1b_cost_1 + int_1b_cost_2 + int_1b_cost_3 + int_1b_cost_4) / 4


int_2a_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_2a/incidence/cost.csv",header=TRUE))[2]
int_2a_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_2a/incidence/cost.csv",header=TRUE))[2]
int_2a_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_2a/incidence/cost.csv",header=TRUE))[2]
int_2a_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_2a/incidence/cost.csv",header=TRUE))[2]
int_2a_cost <- (int_2a_cost_1 + int_2a_cost_2 + int_2a_cost_3 + int_2a_cost_4) / 4


int_2b_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_2b/incidence/cost.csv",header=TRUE))[2]
int_2b_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_2b/incidence/cost.csv",header=TRUE))[2]
int_2b_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_2b/incidence/cost.csv",header=TRUE))[2]
int_2b_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_2b/incidence/cost.csv",header=TRUE))[2]
int_2b_cost <- (int_2b_cost_1 + int_2b_cost_2 + int_2b_cost_3 + int_2b_cost_4) / 4


int_3a_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_3a/incidence/cost.csv",header=TRUE))[2]
int_3a_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_3a/incidence/cost.csv",header=TRUE))[2]
int_3a_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_3a/incidence/cost.csv",header=TRUE))[2]
int_3a_cost_4 		<- cumsum(read.csv("./workshopRun6/output/int_3a/incidence/cost.csv",header=TRUE))[2]
int_3a_cost <- (int_3a_cost_1 + int_3a_cost_2 + int_3a_cost_3 + int_3a_cost_4) / 4


int_3b_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_3b/incidence/cost.csv",header=TRUE))[2]
int_3b_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_3b/incidence/cost.csv",header=TRUE))[2]
int_3b_cost_3 		<- cumsum(read.csv("./workshopRun6/output/int_3b/incidence/cost.csv",header=TRUE))[2]
int_3b_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_3b/incidence/cost.csv",header=TRUE))[2]
int_3b_cost <- (int_3b_cost_1 + int_3b_cost_2 + int_3b_cost_3 + int_3b_cost_4) / 4


int_4a_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_4a/incidence/cost.csv",header=TRUE))[2]
int_4a_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_4a/incidence/cost.csv",header=TRUE))[2]
int_4a_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_4a/incidence/cost.csv",header=TRUE))[2]
int_4a_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_4a/incidence/cost.csv",header=TRUE))[2]
int_4a_cost <- (int_4a_cost_1 + int_4a_cost_2 + int_4a_cost_3 + int_4a_cost_4) / 4


int_4b_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_4b/incidence/cost.csv",header=TRUE))[2]
int_4b_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_4b/incidence/cost.csv",header=TRUE))[2]
int_4b_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_4b/incidence/cost.csv",header=TRUE))[2]
int_4b_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_4b/incidence/cost.csv",header=TRUE))[2]
int_4b_cost <- (int_4b_cost_1 + int_4b_cost_2 + int_4b_cost_3 + int_4b_cost_4) / 4


int_5a_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_5a/incidence/cost.csv",header=TRUE))[2]
int_5a_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_5a/incidence/cost.csv",header=TRUE))[2]
int_5a_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_5a/incidence/cost.csv",header=TRUE))[2]
int_5a_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_5a/incidence/cost.csv",header=TRUE))[2]
int_5a_cost <- (int_5a_cost_1 + int_5a_cost_2 + int_5a_cost_3 + int_5a_cost_4) / 4


int_5b_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_5b/incidence/cost.csv",header=TRUE))[2]
int_5b_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_5b/incidence/cost.csv",header=TRUE))[2]
int_5b_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_5b/incidence/cost.csv",header=TRUE))[2]
int_5b_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_5b/incidence/cost.csv",header=TRUE))[2]
int_5b_cost <- (int_5b_cost_1 + int_5b_cost_2 + int_5b_cost_3 + int_5b_cost_4) / 4


int_6a_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_6a/incidence/cost.csv",header=TRUE))[2]
int_6a_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_6a/incidence/cost.csv",header=TRUE))[2]
int_6a_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_6a/incidence/cost.csv",header=TRUE))[2]
int_6a_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_6a/incidence/cost.csv",header=TRUE))[2]
int_6a_cost <- (int_6a_cost_1 + int_6a_cost_2 + int_6a_cost_3 + int_6a_cost_4) / 4


int_6b_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_6b/incidence/cost.csv",header=TRUE))[2]
int_6b_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_6b/incidence/cost.csv",header=TRUE))[2]
int_6b_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_6b/incidence/cost.csv",header=TRUE))[2]
int_6b_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_6b/incidence/cost.csv",header=TRUE))[2]
int_6b_cost <- (int_6b_cost_1 + int_6b_cost_2 + int_6b_cost_3 + int_6b_cost_4) / 4


int_7_cost_1		<- cumsum(read.csv("./workshopRun1/output/int_7/incidence/cost.csv",header=TRUE))[2]
int_7_cost_2		<- cumsum(read.csv("./workshopRun2/output/int_7/incidence/cost.csv",header=TRUE))[2]
int_7_cost_3		<- cumsum(read.csv("./workshopRun3/output/int_7/incidence/cost.csv",header=TRUE))[2]
int_7_cost_4		<- cumsum(read.csv("./workshopRun4/output/int_7/incidence/cost.csv",header=TRUE))[2]
int_7_cost <- (int_7_cost_1 + int_7_cost_2 + int_7_cost_3 + int_7_cost_4) / 4


int_8a_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_8a/incidence/cost.csv",header=TRUE))[2]
int_8a_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_8a/incidence/cost.csv",header=TRUE))[2]
int_8a_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_8a/incidence/cost.csv",header=TRUE))[2]
int_8a_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_8a/incidence/cost.csv",header=TRUE))[2]
int_8a_cost <- (int_8a_cost_1 + int_8a_cost_2 + int_8a_cost_3 + int_8a_cost_4) / 4


int_8b_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_8b/incidence/cost.csv",header=TRUE))[2]
int_8b_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_8b/incidence/cost.csv",header=TRUE))[2]
int_8b_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_8b/incidence/cost.csv",header=TRUE))[2]
int_8b_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_8b/incidence/cost.csv",header=TRUE))[2]
int_8b_cost <- (int_8b_cost_1 + int_8b_cost_2 + int_8b_cost_3 + int_8b_cost_4) / 4


int_9a_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_9a/incidence/cost.csv",header=TRUE))[2]
int_9a_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_9a/incidence/cost.csv",header=TRUE))[2]
int_9a_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_9a/incidence/cost.csv",header=TRUE))[2]
int_9a_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_9a/incidence/cost.csv",header=TRUE))[2]
int_9a_cost <- (int_9a_cost_1 + int_9a_cost_2 + int_9a_cost_3 + int_9a_cost_4) / 4


int_9b_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_9b/incidence/cost.csv",header=TRUE))[2]
int_9b_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_9b/incidence/cost.csv",header=TRUE))[2]
int_9b_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_9b/incidence/cost.csv",header=TRUE))[2]
int_9b_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_9b/incidence/cost.csv",header=TRUE))[2]
int_9b_cost <- (int_9b_cost_1 + int_9b_cost_2 + int_9b_cost_3 + int_9b_cost_4) / 4


int_10_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_10/incidence/cost.csv",header=TRUE))[2]
int_10_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_10/incidence/cost.csv",header=TRUE))[2]
int_10_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_10/incidence/cost.csv",header=TRUE))[2]
int_10_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_10/incidence/cost.csv",header=TRUE))[2]
int_10_cost <- (int_10_cost_1 + int_10_cost_2 + int_10_cost_3 + int_10_cost_4) / 4


int_11a_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_11a/incidence/cost.csv",header=TRUE))[2]
int_11a_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_11a/incidence/cost.csv",header=TRUE))[2]
int_11a_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_11a/incidence/cost.csv",header=TRUE))[2]
int_11a_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_11a/incidence/cost.csv",header=TRUE))[2]
int_11a_cost <- (int_11a_cost_1 + int_11a_cost_2 + int_11a_cost_3 + int_11a_cost_4) / 4


int_11b_cost_1 		<- cumsum(read.csv("./workshopRun1/output/int_11b/incidence/cost.csv",header=TRUE))[2]
int_11b_cost_2 		<- cumsum(read.csv("./workshopRun2/output/int_11b/incidence/cost.csv",header=TRUE))[2]
int_11b_cost_3 		<- cumsum(read.csv("./workshopRun3/output/int_11b/incidence/cost.csv",header=TRUE))[2]
int_11b_cost_4 		<- cumsum(read.csv("./workshopRun4/output/int_11b/incidence/cost.csv",header=TRUE))[2]
int_11b_cost <- (int_11b_cost_1 + int_11b_cost_2 + int_11b_cost_3 + int_11b_cost_4) / 4


int_12_cost_1 		<- cumsum(read.csv("./workshopRun6/output/int_12/incidence/cost.csv",header=TRUE))[2]
int_12_cost_2 		<- cumsum(read.csv("./workshopRun7/output/int_12/incidence/cost.csv",header=TRUE))[2]
int_12_cost_3 		<- cumsum(read.csv("./workshopRun8/output/int_12/incidence/cost.csv",header=TRUE))[2]
int_12_cost_4 		<- cumsum(read.csv("./workshopRun9/output/int_12/incidence/cost.csv",header=TRUE))[2]
int_12_cost <- (int_12_cost_1 + int_12_cost_2 + int_12_cost_3 + int_12_cost_4) / 4



int_1a_costdif 		<- int_1a_cost[20,] - baseline_cost[20,]
int_1b_costdif 		<- int_1b_cost[20,] - baseline_cost[20,]
int_2a_costdif 		<- int_2a_cost[20,] - baseline_cost[20,]
int_2b_costdif 		<- int_2b_cost[20,] - baseline_cost[20,]
int_3a_costdif 		<- int_3a_cost[20,] - baseline_cost[20,]
int_3b_costdif 		<- int_3b_cost[20,] - baseline_cost[20,]
int_4a_costdif 		<- int_4a_cost[20,] - baseline_cost[20,]
int_4b_costdif 		<- int_4b_cost[20,] - baseline_cost[20,]
int_5a_costdif 		<- int_5a_cost[20,] - baseline_cost[20,]
int_5b_costdif 		<- int_5b_cost[20,] - baseline_cost[20,]
int_6a_costdif 		<- int_6a_cost[20,] - baseline_cost[20,]
int_6b_costdif 		<- int_6b_cost[20,] - baseline_cost[20,]
int_7_costdif 		<- int_7_cost[20,] - baseline_cost[20,]
int_8a_costdif 		<- int_8a_cost[20,] - baseline_cost[20,]
int_8b_costdif 		<- int_8b_cost[20,] - baseline_cost[20,]
int_9a_costdif 		<- int_9a_cost[20,] - baseline_cost[20,]
int_9b_costdif 		<- int_9b_cost[20,] - baseline_cost[20,]
int_10_costdif 		<- int_10_cost[20,] - baseline_cost[20,]
int_11a_costdif 	<- int_11a_cost[20,] - baseline_cost[20,]
int_11b_costdif 	<- int_11b_cost[20,] - baseline_cost[20,]
int_12_costdif 		<- int_12_cost[20,] - baseline_cost[20,]


par(family="Avenir Next Bold")
plot(dif_1a,int_1a_costdif,
	pch=19,
	cex=1.5,
	cex.main=1.5,
	cex.lab=1.2,
	cex.axis=1.2,
	col=plot_col[1],
	xlim=c(0,5e+05),
	main="DALY's averted against additional cost of interventions acting on HIV care between 2010 and 2030",
	xlab="DALY's averted",
	ylab="Additional cost (2013 USD)",
	ylim=c(0,7e+9))
# abline(h=0,lwd=1.5)
# abline(v=0,lwd=1.5)

points(dif_1b,int_1b_costdif,col=plot_col[1],pch=17,cex=1.5)

points(dif_2a,int_2a_costdif,col=plot_col[2],pch=19,cex=1.5)
points(dif_2b,int_2b_costdif,col=plot_col[2],pch=17,cex=1.5)

points(dif_3a,int_3a_costdif,col=plot_col[3],pch=19,cex=1.5)
points(dif_3b,int_3b_costdif,col=plot_col[3],pch=17,cex=1.5)

points(dif_4a,int_4a_costdif,col=plot_col[4],pch=19,cex=1.5)
points(dif_4b,int_4b_costdif,col=plot_col[4],pch=17,cex=1.5)

points(dif_5a,int_5a_costdif,col=plot_col[5],pch=19,cex=1.5)
points(dif_5b,int_5b_costdif,col=plot_col[5],pch=17,cex=1.5)

points(dif_6a,int_6a_costdif,col=plot_col[6],pch=19,cex=1.5)
points(dif_6b,int_6b_costdif,col=plot_col[6],pch=17,cex=1.5)

points(dif_12,int_12_costdif,col=plot_col[7],pch=19,cex=1.5)

points(dif_7,int_7_costdif,col=plot_col[8],pch=19,cex=1.5)

points(dif_8a,int_8a_costdif,col=plot_col[9],pch=19,cex=1.5)
points(dif_8b,int_8b_costdif,col=plot_col[9],pch=17,cex=1.5)

points(dif_9a,int_9a_costdif,col=plot_col[10],pch=19,cex=1.5)
points(dif_9b,int_9b_costdif,col=plot_col[10],pch=17,cex=1.5)

points(dif_10,int_10_costdif,col=plot_col[11],pch=19,cex=1.5)

points(dif_11a,int_11a_costdif,col=plot_col[12],pch=19,cex=1.5)
points(dif_11b,int_11b_costdif,col=plot_col[12],pch=17,cex=1.5)

legend("topright",
	c("HBCT",
		"VCT",
		"HBCT POC CD4",
		"Linkage",
		"Pre-ART Outreach",
		"Improved Care",
		"VCT POC CD4",
		"POC CD4",
		"On-ART Outreach",
		"Adherence",
		"Immediate ART",
		"UTT"),
	fill=plot_col,
	border=NA,
	box.lty=0,
	cex=1.2)

legend(c(0,7e+9),
	c("Maximum Impact",
		"Realistic Impact"),
	pch=c(19,17),
	col=c(1),
	border=NA,
	box.lty=0,
	cex=1.2)


quartz.save("./plots/cost_impact.pdf",type='pdf')

####################################################
#ICER CALCULATION#
# C = Cost
# E = Effect
# ICER for 1 = (C1 – C2) / (E1 – E2)
# ICER for 2 = (C2 - C1) / (E2 - E1)


#BASELINE -> HBCT (Best)
(int_1a_costdif - 0) / (dif_1a - 0)

#IMMEDIATE ART -> UTT (Best)
(int_11a_costdif - int_10_costdif) / (dif_11a - dif_10)


####################################################
#Individual plots
graphics.off()
quartz.options(w=4,h=12)

#HBCT
par(family="Avenir Next Bold")
	barplot(dif_1a,
		col=c(plot_col[1]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("HBCT",1,					at=0.7,2,cex=1.5)

	barplot(dif_1b,
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)
quartz.save("./plots/bars/dalys_averted/HBCT.pdf",type='pdf')

#VCT
par(family="Avenir Next Bold")
	barplot(dif_2a,
		col=c(plot_col[2]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("VCT",1,					at=0.7,2,cex=1.5)

	barplot(dif_2b,
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)
quartz.save("./plots/bars/dalys_averted/VCT.pdf",type='pdf')	

#HBCT POC CD4
par(family="Avenir Next Bold")
	barplot(dif_3a,
		col=c(plot_col[3]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("HBCT\n POC CD4",1,		at=0.7,2,cex=1.5)

	barplot(dif_3b,
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)
quartz.save("./plots/bars/dalys_averted/HBCT_POCCD4.pdf",type='pdf')

#Linkage
par(family="Avenir Next Bold")
	barplot(dif_4a,
		col=c(plot_col[4]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("Linkage",1,				at=0.7,2,cex=1.5)

	barplot(dif_4b,
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)
quartz.save("./plots/bars/dalys_averted/Linkage.pdf",type='pdf')

#preART OUTREACH
par(family="Avenir Next Bold")
	barplot(dif_5a,
		col=c(plot_col[5]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("pre-ART\n Outreach",1,	at=0.7,2,cex=1.5)
	
	barplot(dif_5b,
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)
quartz.save("./plots/bars/dalys_averted/preOUTREACH.pdf",type='pdf')	

#Improved Care
par(family="Avenir Next Bold")
	barplot(dif_6a,
		col=c(plot_col[6]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("Improved Care",1,	at=0.7,2,cex=1.25)

	barplot(dif_6b,
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)
quartz.save("./plots/bars/dalys_averted/improved_care.pdf",type='pdf')		
	
#VCT POC CD4
par(family="Avenir Next Bold")
	barplot(dif_12,
		col=c(plot_col[7]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("VCT\n POC CD4",1,				at=0.7,2.5,cex=1.5)
quartz.save("./plots/bars/dalys_averted/VCT_POC_CD4.pdf",type='pdf')	

#POC CD4
par(family="Avenir Next Bold")
	barplot(dif_7,
		col=c(plot_col[8]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("POC CD4",1,				at=0.7,2,cex=1.5)
quartz.save("./plots/bars/dalys_averted/POC_CD4.pdf",type='pdf')	
	

#ART OUTREACH
par(family="Avenir Next Bold")
	barplot(dif_8a,
		col=c(plot_col[9]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("ART\n Outreach",1,		at=0.7,2,cex=1.5)
	

	barplot(dif_8b,
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)
quartz.save("./plots/bars/dalys_averted/ART_OUTREACH.pdf",type='pdf')			
	
#Adherence
par(family="Avenir Next Bold")
	barplot(dif_9a,
		col=c(plot_col[10]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("Adherence",1,					at=0.7,2,cex=1.25)

	barplot(dif_9b,
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)
quartz.save("./plots/bars/dalys_averted/Adherence.pdf",type='pdf')				


#Immediate ART
par(family="Avenir Next Bold")
	barplot(dif_10,
		col=c(plot_col[11]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("Immediate\n ART",1,		at=0.7,2.5,cex=1.5)
quartz.save("./plots/bars/dalys_averted/immediate_ART.pdf",type='pdf')				
	

#UTT
par(family="Avenir Next Bold")
	barplot(dif_11a,
		col=c(plot_col[12]),
		border=NA,
		ylab="DALY's averted between 2010 and 2030",
		cex.main=1.5,
		cex.lab=1.4,
		ylim=c(0,500000),
		yaxt='n')
	axis(2,seq(0,500000,100000),las=3,cex.axis=1.2)
	mtext("UTT",1,					at=0.7,2,cex=1.5)

	barplot(dif_11b,
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)
quartz.save("./plots/bars/dalys_averted/UTT.pdf",type='pdf')				

##########################################################################################
#% of DALY's averted

# per_dif_1a <- ((baseline[20,] - int_1a[20,]) / baseline[20,]) * 100
# per_dif_1b <- ((baseline[20,] - int_1b[20,]) / baseline[20,]) * 100
# per_dif_2a <- ((baseline[20,] - int_2a[20,]) / baseline[20,]) * 100
# per_dif_2b <- ((baseline[20,] - int_2b[20,]) / baseline[20,]) * 100
# per_dif_3 <- ((baseline[20,] - int_3[20,]) / baseline[20,]) * 100
# per_dif_4a <- ((baseline[20,] - int_4a[20,]) / baseline[20,]) * 100
# per_dif_4b <- ((baseline[20,] - int_4b[20,]) / baseline[20,]) * 100
# per_dif_5a <- ((baseline[20,] - int_5a[20,]) / baseline[20,]) * 100
# per_dif_5b <- ((baseline[20,] - int_5b[20,]) / baseline[20,]) * 100
# per_dif_6a <- ((baseline[20,] - int_6a[20,]) / baseline[20,]) * 100
# per_dif_6b <- ((baseline[20,] - int_6b[20,]) / baseline[20,]) * 100
# per_dif_7 <- ((baseline[20,] - int_7[20,]) / baseline[20,]) * 100
# per_dif_8a <- ((baseline[20,] - int_8a[20,]) / baseline[20,]) * 100
# per_dif_8b <- ((baseline[20,] - int_8b[20,]) / baseline[20,]) * 100
# per_dif_9 <- ((baseline[20,] - int_9[20,]) / baseline[20,]) * 100
# per_dif_10a <- ((baseline[20,] - int_10a[20,]) / baseline[20,]) * 100
# per_dif_10b <- ((baseline[20,] - int_10b[20,]) / baseline[20,]) * 100
# per_dif_11a <- ((baseline[20,] - int_11a[20,]) / baseline[20,]) * 100
# per_dif_11b <- ((baseline[20,] - int_11b[20,]) / baseline[20,]) * 100


# graphics.off()
# quartz.options(w=4,h=12)

# #HBCT
# par(family="Helvetica Neue Bold")
# 	barplot(per_dif_1a,
# 		col=c(p[1]),
# 		border=NA,
# 		ylab="% DALY's averted between 2010 and 2030",
# 		ylim=c(0,100),
# 		yaxt='n')
# 	axis(2,seq(0,100,10),las=1)
# 	mtext("HBCT",1,					at=0.7,2,cex=1.25)

# 	barplot(per_dif_1b,
# 		yaxt='n',
# 		border=NA,
# 		add=TRUE,
# 		col=c(1),
# 		density=30)
# quartz.save("./plots/incidence/bars/per_dalys_averted/HBCT.pdf",type='pdf')

# #VCT
# par(family="Helvetica Neue Bold")
# 	barplot(per_dif_2a,
# 		col=c(p[12]),
# 		border=NA,
# 		ylab="% DALY's averted between 2010 and 2030",
# 		cex.main=1.5,
# 		cex.lab=1.2,
# 		ylim=c(0,100),
# 		yaxt='n')
# 	axis(2,seq(0,100,10),las=1,cex.axis=1.2)
# 	mtext("VCT",1,					at=0.7,2,cex=1.25)

# 	barplot(per_dif_2b,
# 		yaxt='n',
# 		border=NA,
# 		add=TRUE,
# 		col=c(1),
# 		density=30)
# quartz.save("./plots/incidence/bars/per_dalys_averted/VCT.pdf",type='pdf')

# #HBCT POC CD4
# par(family="Helvetica Neue Bold")
# 	barplot(per_dif_3,
# 		col=c(p[3]),
# 		border=NA,
# 		ylab="% DALY's averted between 2010 and 2030",
# 		cex.main=1.5,
# 		cex.lab=1.2,
# 		ylim=c(0,100),
# 		yaxt='n')
# 	axis(2,seq(0,100,10),las=1,cex.axis=1.2)
# 	mtext("HBCT\n POC CD4",1,					at=0.7,2,cex=1.5)
# quartz.save("./plots/incidence/bars/per_dalys_averted/HBCT_POC_CD4.pdf",type='pdf')

# #Linkage
# par(family="Helvetica Neue Bold")
# 	barplot(per_dif_4a,
# 		col=c(p[4]),
# 		border=NA,
# 		ylab="% DALY's averted between 2010 and 2030",
# 		cex.main=1.5,
# 		cex.lab=1.2,
# 		ylim=c(0,100),
# 		yaxt='n')
# 	axis(2,seq(0,100,10),las=1,cex.axis=1.2)
# 	mtext("Linkage",1,					at=0.7,2,cex=1.25

# 	barplot(per_dif_4b,
# 		yaxt='n',
# 		border=NA,
# 		add=TRUE,
# 		col=c(1),
# 		density=30)
# quartz.save("./plots/incidence/bars/per_dalys_averted/Linkage.pdf",type='pdf')

# #Pre Outreach
# par(family="Helvetica Neue Bold")
# 	barplot(per_dif_5a,
# 		col=c(p[5]),
# 		border=NA,
# 		ylab="% DALY's averted between 2010 and 2030",
# 		cex.main=1.5,
# 		cex.lab=1.2,
# 		ylim=c(0,100),
# 		yaxt='n')
# 	axis(2,seq(0,100,10),las=1,cex.axis=1.2)
# 	mtext("Pre-ART\n Outreach",1,					at=0.7,2,cex=1.5)

# 	barplot(per_dif_5b,
# 		yaxt='n',
# 		border=NA,
# 		add=TRUE,
# 		col=c(1),
# 		density=30)
# quartz.save("./plots/incidence/bars/per_dalys_averted/pre_outreach.pdf",type='pdf')

# #Improved care
# par(family="Helvetica Neue Bold")
# 	barplot(per_dif_6a,
# 		col=c(p[6]),
# 		border=NA,
# 		ylab="% DALY's averted between 2010 and 2030",
# 		cex.main=1.5,
# 		cex.lab=1.2,
# 		ylim=c(0,100),
# 		yaxt='n')
# 	axis(2,seq(0,100,10),las=1,cex.axis=1.2)
# 	mtext("Improved Care",1,					at=0.7,2,cex=1.5)

# 	barplot(per_dif_6b,
# 		yaxt='n',
# 		border=NA,
# 		add=TRUE,
# 		col=c(1),
# 		density=30)
# quartz.save("./plots/incidence/bars/per_dalys_averted/Imp_Care.pdf",type='pdf')

# #POC CD4
# par(family="Helvetica Neue Bold")
# 	barplot(per_dif_7,
# 		col=c(p[7]),
# 		border=NA,
# 		ylab="% DALY's averted between 2010 and 2030",
# 		cex.main=1.5,
# 		cex.lab=1.2,
# 		ylim=c(0,100),
# 		yaxt='n')
# 	axis(2,seq(0,100,10),las=1,cex.axis=1.2)
# 	mtext("POC CD4",1,					at=0.7,2,cex=1.25
# quartz.save("./plots/incidence/bars/per_dalys_averted/POC_CD4.pdf",type='pdf')

# #ART Outreach
# par(family="Helvetica Neue Bold")
# 	barplot(per_dif_8a,
# 		col=c(p[8]),
# 		border=NA,
# 		ylab="% DALY's averted between 2010 and 2030",
# 		cex.main=1.5,
# 		cex.lab=1.2,
# 		ylim=c(0,100),
# 		yaxt='n')
# 	axis(2,seq(0,100,10),las=1,cex.axis=1.2)
# 	mtext("ART\n Outreach",1,					at=0.7,2,cex=1.5)

# 	barplot(per_dif_8b,
# 		yaxt='n',
# 		border=NA,
# 		add=TRUE,
# 		col=c(1),
# 		density=30)
# quartz.save("./plots/incidence/bars/per_dalys_averted/ART_Outreach.pdf",type='pdf')

# #Immediate_ART
# par(family="Helvetica Neue Bold")
# 	barplot(per_dif_9,
# 		col=c(p[9]),
# 		border=NA,
# 		ylab="% DALY's averted between 2010 and 2030",
# 		cex.main=1.5,
# 		cex.lab=1.2,
# 		ylim=c(0,100),
# 		yaxt='n')
# 	axis(2,seq(0,100,10),las=1,cex.axis=1.2)
# 	mtext("Immediate\n ART",1,					at=0.7,2,cex=1.5)
# quartz.save("./plots/incidence/bars/per_dalys_averted/Immediate_ART.pdf",type='pdf')

# #UTT
# par(family="Helvetica Neue Bold")
# 	barplot(per_dif_10a,
# 		col=c(p[10]),
# 		border=NA,
# 		ylab="% DALY's averted between 2010 and 2030",
# 		cex.main=1.5,
# 		cex.lab=1.2,
# 		ylim=c(0,100),
# 		yaxt='n')
# 	axis(2,seq(0,100,10),las=1,cex.axis=1.2)
# 	mtext("UTT",1,					at=0.7,2,cex=1.25)

# 		barplot(per_dif_10b,
# 		yaxt='n',
# 		border=NA,
# 		add=TRUE,
# 		col=c(1),
# 		density=30)
# qurtz.save("./plots/incidence/bars/per_dalys_averted/UTT.pdf",type='pdf')

# #Adherence
# par(family="Helvetica Neue Bold")
# 	barplot(per_dif_11a,
# 		col=c(p[11]),
# 		border=NA,
# 		ylab="% DALY's averted between 2010 and 2030",
# 		cex.main=1.5,
# 		cex.lab=1.2,
# 		ylim=c(0,100),
# 		yaxt='n')
# 	axis(2,seq(0,100,10),las=1,cex.axis=1.2)
# 	mtext("Adherence",1,					at=0.7,2,cex=1.5)

# 	barplot(per_dif_11b,
# 		yaxt='n',
# 		border=NA,
# 		add=TRUE,
# 		col=c(1),
# 		density=30)
# quartz.save("./plots/incidence/bars/per_dalys_averted/Adherence.pdf",type='pdf')


##########################################################################################
#PIE-O-MY
pie_out_baseline 	<- as.double(read.csv("./baseline/incidence/pie_out.csv")[2:6])
pie_out_int_1a 		<- as.double(read.csv("./int_1a/incidence/pie_out.csv")[2:6])
pie_out_int_1b 		<- as.double(read.csv("./int_1b/incidence/pie_out.csv")[2:6])
pie_out_int_2a 		<- as.double(read.csv("./int_2a/incidence/pie_out.csv")[2:6])
pie_out_int_2b 		<- as.double(read.csv("./int_2b/incidence/pie_out.csv")[2:6])
pie_out_int_3 		<- as.double(read.csv("./int_3/incidence/pie_out.csv")[2:6])
pie_out_int_4a 		<- as.double(read.csv("./int_4a/incidence/pie_out.csv")[2:6])
pie_out_int_4b 		<- as.double(read.csv("./int_4b/incidence/pie_out.csv")[2:6])
pie_out_int_5a 		<- as.double(read.csv("./int_5a/incidence/pie_out.csv")[2:6])
pie_out_int_5b 		<- as.double(read.csv("./int_5b/incidence/pie_out.csv")[2:6])
pie_out_int_6a 		<- as.double(read.csv("./int_6a/incidence/pie_out.csv")[2:6])
pie_out_int_6b 		<- as.double(read.csv("./int_6b/incidence/pie_out.csv")[2:6])
pie_out_int_7 		<- as.double(read.csv("./int_7/incidence/pie_out.csv")[2:6])
pie_out_int_8a 		<- as.double(read.csv("./int_8a/incidence/pie_out.csv")[2:6])
pie_out_int_8b 		<- as.double(read.csv("./int_8b/incidence/pie_out.csv")[2:6])
pie_out_int_9 		<- as.double(read.csv("./int_9/incidence/pie_out.csv")[2:6])
pie_out_int_10a 	<- as.double(read.csv("./int_10a/incidence/pie_out.csv")[2:6])
pie_out_int_10b 	<- as.double(read.csv("./int_10b/incidence/pie_out.csv")[2:6])
pie_out_int_11a		<- as.double(read.csv("./int_11a/incidence/pie_out.csv")[2:6])
pie_out_int_11b		<- as.double(read.csv("./int_11b/incidence/pie_out.csv")[2:6])

library(RColorBrewer)
m <- brewer.pal(9,"Spectral")
graphics.off()
quartz.options(w=20,h=12)


#Baseline
par(family="Avenir Next Bold")
pie(pie_out_baseline,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/baseline.pdf",type='pdf')				

#HBCTa
par(family="Avenir Next Bold")
pie(pie_out_int_1a,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_1a.pdf",type='pdf')				

#HBCTb
par(family="Avenir Next Bold")
pie(pie_out_int_1b,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_1b.pdf",type='pdf')				

#VCTa
par(family="Avenir Next Bold")
pie(pie_out_int_2a,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_2a.pdf",type='pdf')				

#VCTb
par(family="Avenir Next Bold")
pie(pie_out_int_2b,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_2b.pdf",type='pdf')				

#HBCT POC CD4
par(family="Avenir Next Bold")
pie(pie_out_int_3,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_3.pdf",type='pdf')				

#LINKAGEa
par(family="Avenir Next Bold")
pie(pie_out_int_4a,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_4a.pdf",type='pdf')				

#LINAKGEb
par(family="Avenir Next Bold")
pie(pie_out_int_4b,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_4b.pdf",type='pdf')				

#preOUTREACHa
par(family="Avenir Next Bold")
pie(pie_out_int_5a,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_5a.pdf",type='pdf')				

#preOUTREACHb
par(family="Avenir Next Bold")
pie(pie_out_int_5b,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_5b.pdf",type='pdf')				

#IMP_CAREa
par(family="Avenir Next Bold")
pie(pie_out_int_6a,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_6a.pdf",type='pdf')				

#IMP_CAREb
par(family="Avenir Next Bold")
pie(pie_out_int_6b,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_6b.pdf",type='pdf')				

#POC_CD4
par(family="Avenir Next Bold")
pie(pie_out_int_7,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_7.pdf",type='pdf')				

#OUTREACHa
par(family="Avenir Next Bold")
pie(pie_out_int_8a,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_8a.pdf",type='pdf')				

#OUTREACHb
par(family="Avenir Next Bold")
pie(pie_out_int_8b,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_8b.pdf",type='pdf')				

#Immediate_ART
par(family="Avenir Next Bold")
pie(pie_out_int_9,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_9.pdf",type='pdf')				

#UTT
par(family="Avenir Next Bold")
pie(pie_out_int_10a,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_10a.pdf",type='pdf')				

par(family="Avenir Next Bold")
pie(pie_out_int_10b,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_10b.pdf",type='pdf')

#Adherencea
par(family="Avenir Next Bold")
pie(pie_out_int_11a,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_11a.pdf",type='pdf')				

#Adherenceb
par(family="Avenir Next Bold")
pie(pie_out_int_11b,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)
quartz.save("./plots/pies/int_11b.pdf",type='pdf')				


######################################################################
#Bar - total deaths
graphics.off()
quartz.options(w=5,h=12)

bar_baseline <- read.csv("./baseline/bar.csv",header=TRUE)[2]

par(family="Avenir Next Bold")
barplot(as.matrix(bar_baseline[,1]),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)

quartz.save("./plots/bars/deaths/baseline.pdf",type='pdf')

bar_int_1a <- read.csv("./int_1a/bar.csv",header=TRUE)[2]
bar_int_1b <- read.csv("./int_1b/bar.csv",header=TRUE)[2]
bar_int_2a <- read.csv("./int_2a/bar.csv",header=TRUE)[2]
bar_int_2b <- read.csv("./int_2b/bar.csv",header=TRUE)[2]

bar_int_3a <- read.csv("./int_3a/bar.csv",header=TRUE)[2]
bar_int_3b <- read.csv("./int_3b/bar.csv",header=TRUE)[2]

bar_int_4a <- read.csv("./int_4a/bar.csv",header=TRUE)[2]
bar_int_4b <- read.csv("./int_4b/bar.csv",header=TRUE)[2]

bar_int_5a <- read.csv("./int_5a/bar.csv",header=TRUE)[2]
bar_int_5b <- read.csv("./int_5b/bar.csv",header=TRUE)[2]

bar_int_6a <- read.csv("./int_6a/bar.csv",header=TRUE)[2]
bar_int_6b <- read.csv("./int_6b/bar.csv",header=TRUE)[2]

bar_int_7 <- read.csv("/Volumes/jjo11/cascade/post_paris/18th_September/workshopRun3/output/int_7/bar.csv",header=TRUE)[2]

bar_int_8a <- read.csv("./int_8a/bar.csv",header=TRUE)[2]
bar_int_8b <- read.csv("./int_8b/bar.csv",header=TRUE)[2]

bar_int_9a <- read.csv("./int_9a/bar.csv",header=TRUE)[2]
bar_int_9b <- read.csv("./int_9b/bar.csv",header=TRUE)[2]

bar_int_10 <- read.csv("./int_10/bar.csv",header=TRUE)[2]

bar_int_11a <- read.csv("./int_11a/bar.csv",header=TRUE)[2]
bar_int_11b <- read.csv("./int_11b/bar.csv",header=TRUE)[2]

bar_int_12 <- read.csv("/Volumes/jjo11/cascade/post_paris/18th_September/workshopRun6/output/int_12/bar.csv",header=TRUE)[2]

#HBCT
graphics.off()
quartz.options(w=7.5,h=12)

par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_1b[,1]),as.matrix(bar_int_1a[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("HBCT\n 'realistic'",1,						at=1.9,2.5,cex=1.5)
mtext("HBCT\n 'maximum'",1,						at=3.1,2.5,cex=1.5)

quartz.save("./plots/bars/deaths/HBCT.pdf",type='pdf')

#VCT
graphics.off()
quartz.options(w=7.5,h=12)

par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_2b[,1]),as.matrix(bar_int_2a[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("VCT\n 'realistic'",1,						at=1.9,2.5,cex=1.5)
mtext("VCT\n 'maximum'",1,						at=3.1,2.5,cex=1.5)

quartz.save("./plots/bars/deaths/VCT.pdf",type='pdf')

#HBCT POC CD4
graphics.off()
quartz.options(w=7.5,h=12)

par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_3b[,1]),as.matrix(bar_int_3a[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("HBCT\n POC CD4\n 'realistic'",1,						at=1.9,3.5,cex=1.5)
mtext("HBCT\n POC CD4\n'maximum'",1,						at=3.1,3.5,cex=1.5)

quartz.save("./plots/bars/deaths/HBCT_POC_CD4.pdf",type='pdf')

#Linkage
graphics.off()
quartz.options(w=7.5,h=12)

par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_4b[,1]),as.matrix(bar_int_4a[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("Linkage\n 'realistic'",1,						at=1.9,2.5,cex=1.5)
mtext("Linkage\n 'maximum'",1,						at=3.1,2.5,cex=1.5)

quartz.save("./plots/bars/deaths/Linkage.pdf",type='pdf')

#preOutreach
par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_5b[,1]),as.matrix(bar_int_5a[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("Pre-ART Outreach\n 'realistic'",1,						at=1.9,2.5,cex=1.25)
mtext("Pre-ART Outreach\n 'maximum'",1,						at=3.1,2.5,cex=1.25)

quartz.save("./plots/bars/deaths/preOutreach.pdf",type='pdf')

#Improved Care
par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_6b[,1]),as.matrix(bar_int_6a[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("Improved Care\n 'realistic'",1,						at=1.9,2.5,cex=1.5)
mtext("Improved Care\n 'maximum'",1,						at=3.1,2.5,cex=1.5)

quartz.save("./plots/bars/deaths/Improved_Care.pdf",type='pdf')

#VCT POC CD4
graphics.off()
quartz.options(w=5,h=12)

par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_12[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("VCT\n POC CD4",1,						at=1.9,2.5,cex=1.5)

quartz.save("./plots/bars/deaths/VCT_POC_CD4.pdf",type='pdf')

#POC_CD4
graphics.off()
quartz.options(w=5,h=12)

par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_7[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("POC CD4",1,						at=1.9,2,cex=1.5)

quartz.save("./plots/bars/deaths/POC_CD4.pdf",type='pdf')

#ART_Outreach
graphics.off()
quartz.options(w=7.5,h=12)

par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_8b[,1]),as.matrix(bar_int_8a[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("ART Outreach\n 'realistic'",1,						at=1.9,2.5,cex=1.5)
mtext("ART Outreach\n 'maximum'",1,						at=3.1,2.5,cex=1.5)

quartz.save("./plots/bars/deaths/ART_Outreach.pdf",type='pdf')

#Immediate_ART
graphics.off()
quartz.options(w=5,h=12)

par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_10[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("Immediate\n ART",1,						at=1.9,2,cex=1.5)

quartz.save("./plots/bars/deaths/Immediate_ART.pdf",type='pdf')

#UTT
graphics.off()
quartz.options(w=7.5,h=12)

par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_11b[,1]),as.matrix(bar_int_11a[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("UTT\n 'realistic'",1,						at=1.9,2.5,cex=1.5)
mtext("UTT\n 'maximum'",1,						at=3.1,2.5,cex=1.5)

quartz.save("./plots/bars/deaths/UTT.pdf",type='pdf')

#Adherence
graphics.off()
quartz.options(w=7.5,h=12)

par(family="Avenir Next Bold")
barplot(cbind(as.matrix(bar_baseline[,1]),as.matrix(bar_int_9b[,1]),as.matrix(bar_int_9a[,1])),
	col=c(m[1:5]),
	ylim=c(0,120000),
	ylab="Total HIV-related deaths between 2010 and 2030",
	cex.main=1.4,
	cex.lab=1.4,
	yaxt='n',
	border=1)
axis(2,seq(0,120000,20000),labels=format(seq(0,120000,20000),big.mark=","),cex.axis=1.2)
mtext("Baseline",1,					at=0.7,2,cex=1.5)
mtext("Adherence\n 'realistic'",1,						at=1.9,2.5,cex=1.5)
mtext("Adherence\n 'maximum'",1,						at=3.1,2.5,cex=1.5)

quartz.save("./plots/bars/deaths/Adherence.pdf",type='pdf')

################################################################
#Infections averted
#Baseline modelled incidence...
baseline_infections <- 107032


averted_int_1a <- as.matrix(read.csv("./int_1a/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_1b <- as.matrix(read.csv("./int_1b/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_2a <- as.matrix(read.csv("./int_2a/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_2b <- as.matrix(read.csv("./int_2b/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_3 <- as.matrix(read.csv("./int_3/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_4a <- as.matrix(read.csv("./int_4a/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_4b <- as.matrix(read.csv("./int_4b/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_5a <- as.matrix(read.csv("./int_5a/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_5b <- as.matrix(read.csv("./int_5b/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_6a <- as.matrix(read.csv("./int_6a/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_6b <- as.matrix(read.csv("./int_6b/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_7 <- as.matrix(read.csv("./int_7/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_8a <- as.matrix(read.csv("./int_8a/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_8b <- as.matrix(read.csv("./int_8b/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_9 <- as.matrix(read.csv("./int_9/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_10a <- as.matrix(read.csv("./int_10a/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_10b <- as.matrix(read.csv("./int_10b/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_11a <- as.matrix(read.csv("./int_11a/averted.csv",header=TRUE)[2]) / baseline_infections
averted_int_11b <- as.matrix(read.csv("./int_11b/averted.csv",header=TRUE)[2]) / baseline_infections

graphics.off()
quartz.options(w=4,h=12)

#HBCT
par(family="Helvetica Neue Bold")
barplot(averted_int_1a,
	col=c(p[1]),
	ylim=c(0,1),
	ylab="% infections averted between 2010 and 2030",
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	xaxt='n',
	border=NA)
axis(2,seq(0,1,0.1),seq(0,100,10),las=1,cex=2,cex.axis=1.2)
mtext("HBCT",1,					at=0.7,2,cex=1.5)

	barplot(averted_int_1b,
		yaxt='n',
		xaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)

quartz.save("./plots/incidence/infections_averted/HBCT.pdf",type='pdf')

#VCT
par(family="Helvetica Neue Bold")
barplot(averted_int_2a,
	col=c(p[12]),
	ylim=c(0,1),
	ylab="% infections averted between 2010 and 2030",
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	xaxt='n',
	border=NA)
axis(2,seq(0,1,0.1),seq(0,100,10),las=1,cex=2,cex.axis=1.2)
mtext("VCT",1,					at=0.7,2,cex=1.5)

	barplot(averted_int_2b,
		yaxt='n',
		xaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)

quartz.save("./plots/incidence/infections_averted/VCT.pdf",type='pdf')

#HBCT POC CD4
par(family="Helvetica Neue Bold")
barplot(averted_int_3,
	col=c(p[3]),
	ylim=c(0,1),
	ylab="% infections averted between 2010 and 2030",
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	xaxt='n',
	border=NA)
axis(2,seq(0,1,0.1),seq(0,100,10),las=1,cex=2,cex.axis=1.2)
mtext("HBCT\n POC CD4",1,					at=0.7,2,cex=1.5)

quartz.save("./plots/incidence/infections_averted/HBCT_POC_CD4.pdf",type='pdf')

#Linkage
par(family="Helvetica Neue Bold")
barplot(averted_int_4a,
	col=c(p[4]),
	ylim=c(0,1),
	ylab="% infections averted between 2010 and 2030",
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	xaxt='n',
	border=NA)
axis(2,seq(0,1,0.1),seq(0,100,10),las=1,cex=2,cex.axis=1.2)
mtext("Linkage",1,					at=0.7,2,cex=1.5)

	barplot(averted_int_4b,
		yaxt='n',
		xaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)

quartz.save("./plots/incidence/infections_averted/Linkage.pdf",type='pdf')

#Pre Outreach
par(family="Helvetica Neue Bold")
barplot(averted_int_5a,
	col=c(p[5]),
	ylim=c(0,1),
	ylab="% infections averted between 2010 and 2030",
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	xaxt='n',
	border=NA)
axis(2,seq(0,1,0.1),seq(0,100,10),las=1,cex=2,cex.axis=1.2)
mtext("Pre-ART\n Outreach",1,					at=0.7,2,cex=1.5)

	barplot(averted_int_5b,
		yaxt='n',
		xaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)

quartz.save("./plots/incidence/infections_averted/pre_Outreach.pdf",type='pdf')

#Improved Care
par(family="Helvetica Neue Bold")
barplot(averted_int_6a,
	col=c(p[6]),
	ylim=c(0,1),
	ylab="% infections averted between 2010 and 2030",
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	xaxt='n',
	border=NA)
axis(2,seq(0,1,0.1),seq(0,100,10),las=1,cex=2,cex.axis=1.2)
mtext("Improved Care",1,					at=0.7,2,cex=1.5)

	barplot(averted_int_6b,
		yaxt='n',
		xaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)

quartz.save("./plots/incidence/infections_averted/Improved_Care.pdf",type='pdf')

#POC_CD4
par(family="Helvetica Neue Bold")
barplot(averted_int_7,
	col=c(p[7]),
	ylim=c(0,1),
	ylab="% infections averted between 2010 and 2030",
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	xaxt='n',
	border=NA)
axis(2,seq(0,1,0.1),seq(0,100,10),las=1,cex=2,cex.axis=1.2)
mtext("POC CD4",1,					at=0.7,2,cex=1.5)

quartz.save("./plots/incidence/infections_averted/POC_CD4.pdf",type='pdf')

#ART Outreach
par(family="Helvetica Neue Bold")
barplot(averted_int_8a,
	col=c(p[8]),
	ylim=c(0,1),
	ylab="% infections averted between 2010 and 2030",
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	xaxt='n',
	border=NA)
axis(2,seq(0,1,0.1),seq(0,100,10),las=1,cex=2,cex.axis=1.2)
mtext("ART\n Outreach",1,					at=0.7,2,cex=1.5)

	barplot(averted_int_8b,
		yaxt='n',
		xaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)

quartz.save("./plots/incidence/infections_averted/ART_Outreach.pdf",type='pdf')

#Immediate ART
par(family="Helvetica Neue Bold")
barplot(averted_int_9,
	col=c(p[9]),
	ylim=c(0,1),
	ylab="% infections averted between 2010 and 2030",
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	xaxt='n',
	border=NA)
axis(2,seq(0,1,0.1),seq(0,100,10),las=1,cex=2,cex.axis=1.2)
mtext("Immediate\n ART",1,					at=0.7,2,cex=1.5)

quartz.save("./plots/incidence/infections_averted/Immediate_ART.pdf",type='pdf')

#UTT
par(family="Helvetica Neue Bold")
barplot(averted_int_10a,
	col=c(p[10]),
	ylim=c(0,1),
	ylab="% infections averted between 2010 and 2030",
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	xaxt='n',
	border=NA)
axis(2,seq(0,1,0.1),seq(0,100,10),las=1,cex=2,cex.axis=1.2)
mtext("UTT",1,					at=0.7,2,cex=1.5)



	barplot(averted_int_10b,
		yaxt='n',
		xaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)


quartz.save("./plots/incidence/infections_averted/UTT.pdf",type='pdf')

#Adherence
par(family="Helvetica Neue Bold")
barplot(averted_int_11a,
	col=c(p[11]),
	ylim=c(0,1),
	ylab="% infections averted between 2010 and 2030",
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	xaxt='n',
	border=NA)
axis(2,seq(0,1,0.1),seq(0,100,10),las=1,cex=2,cex.axis=1.2)
mtext("Adherence",1,					at=0.7,2,cex=1.5)

	barplot(averted_int_11b,
		yaxt='n',
		xaxt='n',
		border=NA,
		add=TRUE,
		col=c(1),
		density=30)

quartz.save("./plots/incidence/infections_averted/Adherence.pdf",type='pdf')