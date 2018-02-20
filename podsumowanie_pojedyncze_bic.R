require(Hmisc, quietly = TRUE)
require(varclust, quietly = TRUE)
require(iterators, quietly = TRUE)

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


jpeg(filename=paste0("BIC_dim", max.dim, "_K", K, "_SNR", SNR, "_p", p, "_n", n, "_rep", reps, "_mode_", smode, ".jpg"))
main.info = paste0("Estimated number of clusters.\n # repetitions=", reps, ", # clusters=", K, ", # observations=",n,
                   ",\n # variables=", p, ", dimension=", max.dim,  ", SNR=", SNR, ", mode:", smode) 
#boxplot(ARI, ylab = "", xaxt = "n", boxwex = 0.1, col = "red")
#boxplot(BIC, ylab = "", xaxt = "n", boxwex = 0.1, col = "green", outline = FALSE)
plot(min:max, results$x[min:max], ylab = "times choosen", xlab = "Number of clusters", 
	col = "red", type = "p", pch = 16)
#axis(1, at=atmin, labels=rownames(results), col.axis="red", las=1)
title(main.info)
dev.off()
