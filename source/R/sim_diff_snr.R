require(varclust, quietly = TRUE)
source("source/R/sim_data_function.R")

args    <- commandArgs(trailingOnly = TRUE)
n       <- as.numeric(args[1])
p       <- as.numeric(args[2])
SNR     <- as.numeric(args[3]) #Signal to Noise ratio
K       <- as.numeric(args[4]) #number of subspaces
max.dim <- as.numeric(args[5]) #maximal subspace dimension
mode    <- as.numeric(args[6]) #shared/ not shared facors
iter    <- as.numeric(args[7]) #number of iterations
ratio   <- as.numeric(args[8]) #ration between subsequent SNRs

set.seed(42)

if (length(SNR) == 1) {
  SNR <- 1:K * SNR
}

for (i in 1:iter) {
  print(paste("Starting iteration", i))
  X <- sim.data(n, p, SNR, K, max.dim, mode)
  command <- paste0("\"cd('source/matlab'), simulations(", paste(n,max.dim,SNR[1],K,p,sep=","),"),quit()\"")
  system2("matlab", args = c("-nosplash", "-nodisplay", "-nojvm", "-r", command), stdout = "tmpM")
  #usuwanie tmpM i segmentation jak w bashowych, zapisywanie analizy pojedynczych ietracji normalnie do pliku, ale ogolnie przerobienie 
  #na funkcje tak jak sim.data
  
  
}