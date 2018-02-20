require(Hmisc, quietly = TRUE)


args <- commandArgs(trailingOnly = TRUE)                                                                                                                                                                                                                        
n = as.numeric(args[1])
SNR = as.numeric(args[2])
K = as.numeric(args[3])
dim = as.numeric(args[4])
repets = as.numeric(args[5])

prev=""
if(getwd()=="/home/sobczyk/Dropbox/doktorat/moje_notatki/subspace_clustering")
  prev = "simulations/"


 score <- rep(0,4)
 conc = 0
 ARI <- NULL
 for(i in 1:repets){
   filename <- paste0(prev, "results/old/output1_", i, ".csv")
   d <- read.csv(filename, sep=" ")
   score[which.max(d$BIC)] = score[which.max(d$BIC)] + 1
   conc = conc + (which.max(d$BIC)==which.max(d$ARI) )
   ARI <- rbind(ARI, d$ARI)
 }

  score2 <- rep(0,4)
  conc2 = 0
  ARI2 <- NULL
  for(i in c(1:repets)){
    filename <- paste0(prev, "output2_", i, ".csv")
    d <- read.csv(filename, sep=" ")
    score2[which.max(d$BIC)] = score2[which.max(d$BIC)] + 1
    conc2 = conc2 + (which.max(d$BIC)==which.max(d$ARI) )
    ARI2 <- rbind(ARI2, d$ARI)
    #print(d$ARI)
  }
 
  score3 <- rep(0,4)
  conc3 = 0
  ARI3 <- NULL
  for(i in 1:repets){
    filename <- paste0(prev, "output3_", i, ".csv")
    d <- read.csv(filename, sep=" ")
    score3[which.max(d$BIC)] = score3[which.max(d$BIC)] + 1
    conc3 = conc3 + (which.max(d$BIC)==which.max(d$ARI) )
    ARI3 <- rbind(ARI3, d$ARI)
    print(d$ARI)
  }

 means1 <- colMeans(ARI)
 sds1 <- apply(ARI,2, sd)
 jpeg(filename=paste0("ARI_1", "_", SNR, "_"S, repets, ".jpg"))
 main.info = paste0("ARI value for different methods of clustering.\n", repets, " repetitions, dimension=1, #clusters=", K, ", SNR=", SNR) 
 errbar(1:4, y=means1,yplus=means1+sds1, yminus=means1-sds1, xaxt="n", ylab="ARI")
 axis(1, at=1:4,labels=rownames(d), col.axis="red", las=2)
 title(main.info)
 dev.off()


 means2 <- colMeans(ARI2)
 sds2 <- apply(ARI2,2, sd)
 jpeg(filename=paste0("ARI_2", "_", SNR, "_", repets, ".jpg"))
 main.info = paste0("ARI value for different methods of clustering.\n", repets, " repetitions, dimension=2, #clusters=", K, ", SNR=", SNR) 
 errbar(1:4, y=means2,yplus=means2+sds2, yminus=means2-sds2, xaxt="n", ylab="ARI")
 axis(1, at=1:4,labels=rownames(d), col.axis="red", las=2)
 title(main.info)
 dev.off()

  means3 = colMeans(ARI3)
  sds3 = apply(ARI3,2, sd)
  jpeg(filename=paste0("ARI_3", "_", SNR, "_", repets, ".jpg"))
  main.info = paste0("ARI value for different methods of clustering.\n", repets, " repetitions, dimension=3, #clusters=", K, ", SNR=", SNR) 
  errbar(1:4, y=means3,yplus=means3+sds3, yminus=means3-sds3, xaxt="n", ylab="ARI")
  axis(1, at=1:4,labels=rownames(d), col.axis="red", las=2)
  title(main.info)
  dev.off()

library(xtable, quietly = TRUE)
dane <- rbind(colMeans(ARI), colMeans(ARI2), colMeans(ARI3))
colnames(dane) <- rownames(d)
rownames(dane) <- c("dim=1", "dim=2", "dim=3")
xtable(dane,caption="ARI for different methods and maximal subspace dimensions", align="|c|cccc|", label="comparison_ari")
