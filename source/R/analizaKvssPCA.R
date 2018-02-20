require(mclust, quietly = TRUE)
require(xtable, quietly = TRUE)
require(varclust, quietly = TRUE)

args <- commandArgs(trailingOnly = TRUE)
n = as.numeric(args[1])
p = as.numeric(args[2])
SNR = as.numeric(args[3])
K = as.numeric(args[4])
max.dim = as.numeric(args[5])
mode = as.numeric(args[6])
rep = as.numeric(args[7])
name = args[8]


file.name = paste('data/X_', max.dim, '_', SNR, '.csv', sep='')
X = read.table(file.name, header=F, sep=',')
X = as.matrix(X)

filename <- paste('segmentationR', max.dim, '.csv', sep='')
segmentationR <- read.table(file=filename, sep=",")
true_segmentation <- rep(1:K, each=p/K)
segmentationR <- as.matrix(segmentationR)
colnames(segmentationR) <- NULL

howManyMatlab = 0
howManyR = 2
dane <- matrix(nrow=howManyMatlab+howManyR, ncol=4)

for (i in 1:howManyMatlab){
  tryCatch({
      dane[i,1] <- adjustedRandIndex(as.matrix(segmentationMATLAB[i,1:p]),
                                     true_segmentation)
      #dane[i,2] <- varclust:::cluster.pca.BIC(X, as.matrix(segmentationMATLAB[i,1:p]), max.dim, K)
      res <- varclust:::integration(segmentationMATLAB[i,1:p], true_segmentation)
      dane[i,3] <- res[1]
      dane[i,4] <- res[2]
    
  }, error = function(err) {
    dane[i,1] <- 0
    dane[i,2] <- 0
    dane[i,3] <- 0
    dane[i,4] <- 0
    
  })
}

for (i in 1:howManyR){
  j <- howManyMatlab + i
  tryCatch({
      dane[j,1] <- adjustedRandIndex(as.matrix(segmentationR[i,1:p]),
                                     true_segmentation)
      #dane[j,2] <- varclust:::cluster.pca.BIC(X, as.matrix(segmentationR[i,1:p]), max.dim, K)
      res <- varclust:::integration(segmentationR[i,1:p], true_segmentation)
      dane[j,3] <- res[1]
      dane[j,4] <- res[2]
  }, error = function(err) {
      dane[j,1] <- 0
      dane[j,2] <- 0
      dane[j,3] <- 0
      dane[j,4] <- 0
    
  })

}


dane <- data.frame(dane)
colnames(dane)= c("ARI", "BIC", "Integration", "Acontamination")
rownames(dane) <- c("MLCC","sPCA")
tableCaption <- paste("Simulated \\newline
          D=", p, "; n=", n, "; SNR=", SNR, "; K=", K, "; max.dim=", max.dim, ";")
#print(xtable(dane, align="|c|ccc|",caption=tableCaption, label="methods_comparison"),sanitize.text.function=function(x){x})

filename <- paste('output', name, n, p, SNR, K, max.dim, mode, rep, sep='_')
filename <- paste(filename, '.csv', sep='')
write.table(format(x=dane,digits=3), file=filename)
