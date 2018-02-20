require(varclust, quietly = TRUE)

args <- commandArgs(trailingOnly = TRUE)
n         <- as.numeric(args[1])
p         <- as.numeric(args[2])
SNR       <- as.numeric(args[3])
K         <- as.numeric(args[4])
max.dim   <- as.numeric(args[5])
runs      <- as.numeric(args[6])
file.name <- paste('data/X_', max.dim, '_', SNR, '.csv', sep='')
N         <- p/K

X <- read.table(file.name, header=F, sep=',')
X <- as.matrix(X)
#filename <- paste('segmentationMATLAB', max.dim, '.csv', sep='')
#segmentationSSC <- read.table(file=filename, sep=",")[1,1:p]


MLCC2.result <- mlcc.reps(X=X, numb.clusters=K, numb.runs=runs, max.dim=max.dim, max.iter = 50,
                         numb.cores = 2, estimate.dimensions = TRUE, mode = "kmeans++")
MLCC3.result <- mlcc.reps(X=X, numb.clusters=K, numb.runs=runs, max.dim=max.dim, max.iter = 50,
                         numb.cores = 2, estimate.dimensions = TRUE, mode = "random")


filename <- paste('segmentationR', max.dim, '.csv', sep='')
write.table(x=matrix(MLCC3.result$segmentation, nrow=1), file=filename,
            sep="," , append=T, col.names=F, row.names=F)
write.table(x=matrix(MLCC2.result$segmentation, nrow=1), file=filename,
            sep="," , append=T, col.names=F, row.names=F)
