require(ClustOfVar, quietly = TRUE)
require(varclust, quietly = TRUE)

args <- commandArgs(trailingOnly = TRUE)
n         <- as.numeric(args[1])
p         <- as.numeric(args[2])
SNR       <- as.numeric(args[3])
K         <- as.numeric(args[4])
max.dim   <- as.numeric(args[5])
numb.runs <- as.numeric(args[6])
max.iter  <- as.numeric(args[7])
smode     <- "shared"
name      <- args[8]

#setting seed
set.seed(n + K)
x  <- data.simulation.factors(n = n, SNR = SNR, K = K, numb.vars = p/K,
                              numb.factors = K*max.dim/2,
                              min.dim = 2, max.dim = max.dim,
                              equal.dims = FALSE, separation.parameter = 0.2)$X

results <- matrix(0, nrow = numb.runs, ncol = max.iter)
for (i in 1:numb.runs) {
  segmentation <- sample(1:K, p, replace = TRUE)
  for (j in 1:max.iter) {
      res <- mlcc.reps(X = x, numb.clusters = K, max.iter = 1, max.dim = max.dim,
          estimate.dimensions = TRUE, initial.segmentations = list(segmentation),
          numb.cores = 1)
      results[i, j] <- res$BIC
      segmentation <- res$segmentation
  }
}

filename <- paste0(name, paste("/iterations", n, p, K, sep = "_"), ".csv")
write.table(x = results, file = filename,
            sep = ",", col.names = F, row.names = F)
                      


jpeg(filename = paste0(name, "/Iterations_dim", max.dim, "_K", K, "_SNR", SNR, "_p", p, "_n", n, "_mode_", smode, ".jpg"))
main.info <- paste0("Value of mBIC after given number of iterations") 
cols <- c("#FF4136", "#0074D9", "#2ECC40", "#B10DC9")
matplot(1:max.iter, t(results), type = "b", xlab = "iteration", ylab = "mBIC", col = cols, pch = 19, lty = "solid")
legend("topleft", legend = c("init1", "init2", "init3", "init4"), col = cols, pch = 19)
title(main.info)
dev.off()
