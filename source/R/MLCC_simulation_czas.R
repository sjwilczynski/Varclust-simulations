require(ClustOfVar, quietly = TRUE)
require(varclust, quietly = TRUE)

args <- commandArgs(trailingOnly = TRUE)
n         <- as.numeric(args[1])
p         <- as.numeric(args[2])
SNR       <- as.numeric(args[3])
K         <- as.numeric(args[4])
max.dim   <- as.numeric(args[5])
run       <- as.numeric(args[6])
file.name <- paste('data/X_', max.dim, '_', SNR, '.csv', sep='')
N         <- p/K

X <- read.table(file.name, header=F, sep=',')
X <- as.matrix(X)
true.segmentation <- unlist(lapply(1:K, function(i) rep(i,N)))


result1 <- matrix(unlist(mlcc.kmeans.time(X=X, number.clusters=K, max.subspace.dim=max.dim, max.iter = 50,
	estimate.dimensions = TRUE, mode = "random")[[3]], use.names = FALSE), nrow = 1)

result2 <- matrix(unlist(mlcc.kmeans.time(X=X, number.clusters=K, max.subspace.dim=max.dim, max.iter = 50,
   estimate.dimensions = TRUE, mode = "kmeans++")[[3]], use.names = FALSE), nrow = 1)

result3 <- matrix(unlist(mlcc.kmeans.time(X=X, number.clusters=K, max.subspace.dim=max.dim, max.iter = 50,
   estimate.dimensions = TRUE, mode = "sPCA")[[3]], use.names = FALSE), nrow = 1)

result4 <- system.time(kmeansvar(X.quanti=scale(X),init=K, nstart = 1, iter.max = 50))[[3]]

result <- list(result4, result3, result2, result1)

data <- do.call(cbind, result)
filename <- paste('timeR', max.dim, '.csv', sep='')
write.table(x=data, file=filename, sep="," , append=T, col.names=F, row.names=F)




