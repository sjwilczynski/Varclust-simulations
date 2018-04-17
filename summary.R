args   <- commandArgs(trailingOnly = TRUE)                                                                                                                                                                                                                        
n      <- as.numeric(args[1])
p      <- as.numeric(args[2])
SNR    <- as.numeric(args[3])
K      <- as.numeric(args[4])
max.dim<- as.numeric(args[5])
repets <- as.numeric(args[6])
mode   <- as.numeric(args[7])
name   <- args[8]

prev=""

howmany_methods = 5
score <- rep(0,howmany_methods)
conc = 0
ARI <- NULL
INT <- NULL
ACONT <- NULL
for(i in 1:repets){
  filename <- paste('output', name, n, p, SNR, K, max.dim, mode, i, sep='_')
  filename <- paste(filename, '.csv', sep='')
  results <- read.csv(filename, sep=" ")
  score[which.max(results$ARI)] = score[which.max(results$ARI)] + 1
  conc = conc + ( which.max(results$BIC)==which.max(results$ARI) )
  ARI <- rbind(ARI, results$ARI)
  INT <- rbind(INT, results$Integration)
  ACONT <- rbind(ACONT, results$Acontamination)
}
print(score/repets)
print(conc/repets)

minimum <- 0.0
maximum <- 1.0

if(mode == 0){
	smode <- "shared"
} else{
	smode <- "not_shared"
}

jpeg(filename=paste0("ARI_dim", max.dim, "_K", K, "_SNR", SNR, "_p", p, "_n", n, "_rep", repets, "_mode_", smode, ".jpg"))
main.info = paste0("Values of ARI, Integration and Acontamination \n # repetitions=", repets, ", # clusters=", K, ", # observations=",n,
                   ",\n # variables=", p, ", dimension=", max.dim,  ", SNR=", SNR, ", mode=", smode) 
boxplot(ARI, ylab = "", xaxt = "n", boxwex = 0.1, ylim = c(minimum,maximum), col = "#FF4136")
boxplot(INT, ylab = "", xaxt = "n", boxwex = 0.1, at = -0.2+1:howmany_methods, add = TRUE, col = "#0074D9")
boxplot(ACONT, ylab = "", xaxt = "n", boxwex = 0.1, at = 0.2+1:howmany_methods, add = TRUE, col = "#2ECC40")
axis(1, at=1:howmany_methods,labels=rownames(results), las=2)
legend("topright", legend = c("ARI", "INT", "ACONT"), col = c("#FF4136", "#0074D9", "#2ECC40"), pch = 19)
title(main.info)
dev.off()
