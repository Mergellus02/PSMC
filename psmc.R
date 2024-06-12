#this is the directory of the files where all the PSMC outputs are saved.
setwd("C:/PSMC/final_output")
#this is the R library we gonna be using
library("ggpubr")
#select a font for your plots
op <- par(family = "serif")
#lets make a blank plot
plot(1,1,
     ylim=c(0,80),xlim=c(2,700),
     log="x",type="n",
     main="",ylab="Effective Population Size (10^4)",xlab="Years ago 10^3")
#lets add lines at different time point of our interest.
abline(v=c(6,22,120), col="black")
text(119.85,75.18514,"LIG",cex=1.0)
text(21.63997,75.18514,"LGM",cex=1.0)
text(5.928641,75.18514,"MDH",cex=1.0)
# extract bootstrap values for each species separately.
for(i in 0:100) {
  path<-paste0("NP_10g_1_diploid.",i,".txt")
  boot.iter<-read.table(path)
  ya<-boot.iter[-1,1]
  ya.pl=ya[which(ya>4999)]
  ne<-boot.iter[-1,2]
  ne.pl=ne[which(ya>4999)]
  lines((ya/1000),ne,xlog=T,type="l",col=alpha("cornflowerblue",0.1),lwd=0.8,ylim=c(0,50))
}

for(i in 0:100) {
  path<-paste0("NP_10g_2_diploid.",i,".txt")
  boot.iter<-read.table(path)
  ya<-boot.iter[-1,1]
  ya.pl=ya[which(ya>4999)]
  ne<-boot.iter[-1,2]
  ne.pl2=ne[which(ya>4999)]
  lines((ya/1000),ne,xlog=T,type="l",col=alpha("orange",0.1), lwd=0.8,ylim=c(0,50))
}

for(i in 0:100) {
  path<-paste0("NP_10g_3_diploid.",i,".txt")
  boot.iter<-read.table(path)
  ya<-boot.iter[-1,1]
  ya.pl=ya[which(ya>4999)]
  ne<-boot.iter[-1,2]
  ne.pl2=ne[which(ya>4999)]
  lines((ya/1000),ne,xlog=T,type="l",col=alpha("yellow",0.1), lwd=0.8,ylim=c(0,50))
}

for(i in 0:100) {
  path<-paste0("NP_10g_4_diploid.",i,".txt")
  boot.iter<-read.table(path)
  ya<-boot.iter[-1,1]
  ya.pl=ya[which(ya>4999)]
  ne<-boot.iter[-1,2]
  ne.pl2=ne[which(ya>4999)]
  lines((ya/1000),ne,xlog=T,type="l",col=alpha("lightgreen",0.1), lwd=0.8,ylim=c(0,50))
}

for(i in 0:100) {
  path<-paste0("NP_10g_5_diploid.",i,".txt")
  boot.iter<-read.table(path)
  ya<-boot.iter[-1,1]
  ya.pl=ya[which(ya>4999)]
  ne<-boot.iter[-1,2]
  ne.pl2=ne[which(ya>4999)]
  lines((ya/1000),ne,xlog=T,type="l",col=alpha("lightpink",0.1), lwd=0.8,ylim=c(0,50))
}

for(i in 0:100) {
  path<-paste0("NP_15g_diploid.",i,".txt")
  boot.iter<-read.table(path)
  ya<-boot.iter[-1,1]
  ya.pl=ya[which(ya>4999)]
  ne<-boot.iter[-1,2]
  ne.pl2=ne[which(ya>4999)]
  lines((ya/1000),ne,xlog=T,type="l",col=alpha("darkgreen",0.1), lwd=0.8,ylim=c(0,50))
}
for(i in 0:100) {
  path<-paste0("NP_20g_diploid.",i,".txt")
  boot.iter<-read.table(path)
  ya<-boot.iter[-1,1]
  ya.pl=ya[which(ya>4999)]
  ne<-boot.iter[-1,2]
  ne.pl2=ne[which(ya>4999)]
  lines((ya/1000),ne,xlog=T,type="l",col=alpha("darkblue",0.1), lwd=0.8,ylim=c(0,50))
}

for(i in 0:100) {
  path<-paste0("NP_30g_diploid.",i,".txt")
  boot.iter<-read.table(path)
  ya<-boot.iter[-1,1]
  ya.pl=ya[which(ya>4999)]
  ne<-boot.iter[-1,2]
  ne.pl2=ne[which(ya>4999)]
  lines((ya/1000),ne,xlog=T,type="l",col=alpha("red",0.1), lwd=0.8,ylim=c(0,50))
}

#adding the legend to the plot - feel free to customize.
legend(160, 77, legend=c("NP_10g_1", "NP_10g_2", "NP_10g_3", "NP_10g_4", "NP_10g_5", "NP_15g", "NP_20g", "NP_30g"),
       col=c("cornflowerblue", "orange", "yellow", "lightgreen", "lightpink", "darkgreen", "darkblue", "red"), lty=1, cex=1.0, box.lty=5)

# lets extract values of the main PSMC results for each species separately.
NP_10_1 = read.table("NP_10g_1_diploid.0.txt")
NP_10_1.ya=NP_10_1[-1,1]
NP_10_1.ne=NP_10_1[-1,2]

NP_10_2 = read.table("NP_10g_2_diploid.0.txt")
NP_10_2.ya=NP_10_2[-1,1]
NP_10_2.ne=NP_10_2[-1,2]

NP_10_3 = read.table("NP_10g_3_diploid.0.txt")
NP_10_3.ya=NP_10_3[-1,1]
NP_10_3.ne=NP_10_3[-1,2]

NP_10_4 = read.table("NP_10g_4_diploid.0.txt")
NP_10_4.ya=NP_10_4[-1,1]
NP_10_4.ne=NP_10_4[-1,2]

NP_10_5 = read.table("NP_10g_5_diploid.0.txt")
NP_10_5.ya=NP_10_5[-1,1]
NP_10_5.ne=NP_10_5[-1,2]

NP_15 = read.table("NP_15g_diploid.0.txt")
NP_15.ya=NP_15[-1,1]
NP_15.ne=NP_15[-1,2]

NP_20 = read.table("NP_20g_diploid.0.txt")
NP_20.ya=NP_20[-1,1]
NP_20.ne=NP_20[-1,2]

NP_30 = read.table("NP_30g_diploid.0.txt")
NP_30.ya=NP_30[-1,1]
NP_30.ne=NP_30[-1,2]

#lets plot those extracted values.
lines(x=(NP_10_1.ya/1000),y=NP_10_1.ne,type="l",col="cornflowerblue",lwd=2.5)
lines(x=(NP_10_2.ya/1000),y=NP_10_2.ne,type="l",col="orange",lwd=2.5)
lines(x=(NP_10_3.ya/1000),y=NP_10_3.ne,type="l",col="yellow",lwd=2.5)
lines(x=(NP_10_4.ya/1000),y=NP_10_4.ne,type="l",col="lightgreen",lwd=2.5)
lines(x=(NP_10_5.ya/1000),y=NP_10_5.ne,type="l",col="lightpink",lwd=2.5)
lines(x=(NP_15.ya/1000),y=NP_15.ne,type="l",col="darkgreen",lwd=2.5)
lines(x=(NP_20.ya/1000),y=NP_20.ne,type="l",col="darkblue",lwd=2.5)
lines(x=(NP_30.ya/1000),y=NP_30.ne,type="l",col="red",lwd=2.5)
