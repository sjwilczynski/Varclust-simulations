args   <- commandArgs(trailingOnly = TRUE)                                                                                                                                                                                                                        
n      <- as.numeric(args[1])
p      <- eval(parse(text=args[2]))
SNR    <- as.numeric(args[3])
K      <- eval(parse(text=args[4]))
max.dim<- as.numeric(args[5])
repets <- as.numeric(args[6])
mode   <- as.numeric(args[7])
name   <- args[8]
prev=""

if(mode == 0){
	smode <- "shared"
} else{
	smode <- "not_shared"
}

filenameR <- paste0(prev, "timeR", max.dim, ".csv")
filenameMatlab <-  paste0(prev, "timeMATLAB", max.dim, ".csv")
dataR <- read.table(filenameR, header=F, sep=',')
dataMatlab <- read.table(filenameMatlab, header=F, sep=',')


data <- cbind( dataMatlab, dataR )
colnames(data) <- c("SSC","LRSC","COV","MLCC")

filename <- paste('output',name, n, paste(p, collapse="_"), SNR, paste(K, collapse="_"), max.dim, smode, sep='_')
filename <- paste(filename, '.csv', sep='')
write.csv(format(x=data,digits=6), file=filename)


if(name == "#variables"){
	xs <- p
	name <- "number of variables"
} else {
	xs <- K
	name <- "number of clusters"
}
jpeg(filename=paste0("Time_dim", max.dim, "_K", paste(K, collapse="_"), "_SNR", SNR, "_p", paste(p, collapse="_"), "_n", n, "_rep", repets, "_mode_", smode, ".jpg"))
main.info = paste0("Execution time for different ", name) 
cols <- c("#FF4136", "#0074D9", "#2ECC40", "#B10DC9")
matplot(xs, data, type="b", xlab=name, ylab="execution time (seconds)", col = cols, pch=19, lty = "solid")
legend("topleft", legend=colnames(data), col=cols, pch=19, horiz=TRUE)
title(main.info)
dev.off()
