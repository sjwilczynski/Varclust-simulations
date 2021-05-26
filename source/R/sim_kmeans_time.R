require(ClustOfVar, quietly = TRUE)
require(varclust, quietly = TRUE)

args <- commandArgs(trailingOnly = TRUE)
n         <- as.numeric(args[1])
p         <- as.numeric(args[2])
SNR       <- as.numeric(args[3])
K         <- as.numeric(args[4])
max.dim   <- as.numeric(args[5])
repets    <- as.numeric(args[6])
name      <- args[7]
file.name <- paste('data/', name, '/X_', max.dim, '_', SNR, '.csv', sep='')
N         <- p/K

#setting seed
set.seed(n+K)

X <- read.table(file.name, header=F, sep=',')
X <- as.matrix(X)
true.segmentation <- unlist(lapply(1:K, function(i) rep(i,N)))


result1 <- system.time(replicate(repets, mlcc.kmeans(X=X, number.clusters=K, max.subspace.dim=max.dim,
	estimate.dimensions = TRUE)))[[3]]/repets

result2 <- system.time(replicate(repets, kmeansvar(X.quanti=scale(X),init=K, nstart = 1, iter.max = 40)))[[3]]/repets

result <- list(result2, result1)

data <- do.call(cbind, result)
filename <- paste(name, '/timeR', max.dim, '.csv', sep='')
write.table(x=data, file=filename, sep="," , append=T, col.names=F, row.names=F)