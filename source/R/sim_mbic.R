require(MASS, quietly = TRUE)
require(mclust, quietly = TRUE)
require(xtable, quietly = TRUE)
require(varclust, quietly = TRUE)

args <- commandArgs(trailingOnly = TRUE)

n         <- as.numeric(args[1])
p         <- as.numeric(args[2])
SNR       <- as.numeric(args[3])
K         <- as.numeric(args[4])
max.dim   <- as.numeric(args[5])
runs      <- as.numeric(args[6])
N         <- p/K
reps      <- as.numeric(args[7])
mode      <- as.numeric(args[8])
name      <- args[9]

#setting seed
set.seed(n+K)

sd = min(20, round(K/2))
min = K - sd
max = K + sd
results <- vector(mode = "integer", max)
true_segmentation <- unlist(lapply(1:K, function(i) rep(i,N)))

for (i in 1:reps){
	if(mode == 0){
		sim.data <- data.simulation.factors(n = n, SNR = SNR, K = K, numb.vars = p/K,
		                                    	numb.factors = K*max.dim/2,
		                                    	min.dim = 2, max.dim = max.dim,
		                                    	equal.dims = FALSE, separation.parameter = 0.2)
	} else {
		sim.data <- data.simulation(n = n, SNR = SNR, K = K, numb.vars = p/K,
	                            	min.dim = 2, max.dim = max.dim,
	                            	equal.dims = FALSE)
	}
	X <- sim.data$X
	tryCatch({
		mlcc.bic.res <- mlcc.bic(X=X, numb.clusters = min:max, numb.runs = runs, max.iter = 30, 
				max.dim = max.dim, numb.cores = 6, estimate.dimensions = TRUE, , deterministic=TRUE)
		}, error = function(err) {
			print(err)
			traceback()
	})
	estimated <- mlcc.bic.res[[4]]
	results[estimated] <- results[estimated] + 1
	cat("Rep", i ,"done\n")
}

filename <- paste('bic_output', name, n, p, SNR, K, max.dim, mode, reps, sep='_')
filename <- paste(filename, '.csv', sep='')
write.table(format(x=results,digits=6), file=filename)
