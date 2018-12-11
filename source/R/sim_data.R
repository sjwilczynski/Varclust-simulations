require(varclust, quietly = TRUE)

args    <- commandArgs(trailingOnly = TRUE)
n       <- as.numeric(args[1])
p       <- as.numeric(args[2])
SNR     <- eval(parse(text=args[3])) #Signal to Noise ratio
K       <- as.numeric(args[4]) #number of subspaces
max.dim <- as.numeric(args[5]) #maximal subspace dimension
mode    <- as.numeric(args[6]) #shared/ not shared facors
i       <- as.numeric(args[7]) #iteration identifier
name    <- agrs[8]

#setting seed
set.seed(i)

if(mode == 0){
	X <- data.simulation.factors(n = n, SNR = SNR, K = K, numb.vars = p/K,
                                    	numb.factors = K*max.dim/2,
                                    	min.dim = 2, max.dim = max.dim,
                                    	equal.dims = FALSE, separation.parameter = 0.2)$X
} else {
	X <- data.simulation(n = n, SNR = SNR, K = K, numb.vars = p/K,
                            	min.dim = 2, max.dim = max.dim,
                            	equal.dims = FALSE)$X
}

file.name = paste("data/X_", name, ".csv", sep='')
write.table(X, file=file.name, row.names=F, col.names=F, sep=',')
