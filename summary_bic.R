args   <- commandArgs(trailingOnly = TRUE)                                                                                                                                                                                                                        
n         <- as.numeric(args[1])
p         <- as.numeric(args[2])
SNR       <- as.numeric(args[3])
K         <- as.numeric(args[4])
max.dim   <- as.numeric(args[5])
reps    <- as.numeric(args[6])
mode      <- as.numeric(args[7])
name      <- args[8]

prev=""
sd = min(20, round(K/2))
min = K - sd
max = K + sd

filename <- paste('bic_output', name, n, p, SNR, K, max.dim, mode, reps, sep='_')
filename <- paste(filename, '.csv', sep='')
results <- read.csv(filename, sep=" ")
atmin = as.numeric(rownames(results)) - min(as.numeric(rownames(results))) + 1

if(mode == 0){
	smode <- "shared"
} else{
	smode <- "not_shared"
}
cols <- rep("#0074D9", max)
cols[K] = "#FF4136"

jpeg(filename=paste0("BIC_dim", max.dim, "_K", K, "_SNR", SNR, "_p", p, "_n", n, "_rep", reps, "_mode_", smode, ".jpg"))
main.info = paste0("Estimated number of clusters for K=",K) 
barplot(results$x[min:max], names.arg=min:max, col = cols[min:max], ylab = "Times choosen", xlab = "Number of clusters", border=TRUE)
title(main.info)
dev.off()
