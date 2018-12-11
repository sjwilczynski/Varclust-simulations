require(ClustOfVar, quietly = TRUE)
require(varclust, quietly = TRUE)

args <- commandArgs(trailingOnly = TRUE)
K         <- as.numeric(args[1])
max.dim   <- as.numeric(args[2])
runs      <- as.numeric(args[3])
name      <- args[4]
file.name <- paste('data/X_', name, '.csv', sep='')

X <- read.table(file.name, header=F, sep=',')
X <- as.matrix(X)
p <- dim(X)[2]

#setting seed
set.seed(p+K)

filename <- paste('segmentationMATLAB', name, '.csv', sep='')
segmentationSSC <- read.table(file=filename, sep=",")[1,1:p]


if(name == "2maxdim"){
	max.dim = 2*max.dim
}

MLCC1.result <- mlcc.reps(X=X, numb.clusters=K, numb.runs=runs, max.dim=max.dim,
                         numb.cores = 6, estimate.dimensions = TRUE)
MLCC2.result <- mlcc.reps(X=X, numb.clusters=K, max.dim=max.dim,
                         numb.cores = 6, estimate.dimensions = TRUE, 
                         initial.segmentations = list(segmentationSSC))
tryCatch({
    COV.segmentation <- kmeansvar(X.quanti=scale(X),init=K, nstart = 30, iter.max = 50)$cluster
}, error = function(err) {
    # Error in 'svd(Ztilde)': a dimension is zero
    # kmeansvar -> do_one _> clusterscore -> svd
    # use any segmentation instead
    COV.segmentation <- rep(1,p)
})

if(name == "2maxdim"){
	max.dim = max.dim/2
}


filename <- paste('segmentationR', name, '.csv', sep='')
write.table(x=matrix(MLCC1.result$segmentation, nrow=1), file=filename,
            sep="," , append=T, col.names=F, row.names=F)
write.table(x=matrix(MLCC2.result$segmentation, nrow=1), file=filename,
            sep="," , append=T, col.names=F, row.names=F)
write.table(x=matrix(COV.segmentation, nrow=1),file=filename, sep="," ,
            append=T, col.names=F, row.names=F)
