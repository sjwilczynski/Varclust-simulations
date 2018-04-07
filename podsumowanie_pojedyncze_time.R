args   <- commandArgs(trailingOnly = TRUE)                                                                                                                                                                                                                        
n      <- as.numeric(args[1])
p      <- as.numeric(args[2])
SNR    <- as.numeric(args[3])
K      <- as.numeric(args[4])
max.dim    <- as.numeric(args[5])
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
colnames(data) <- c("SSC","LRSC","COV","sPCAtot","sPCAinit","sPCAt_iter","sPCAn_iter",
	"KM++tot","KM++init","KM++t_iter","KM++n_iter","KMtot","KMinit","KMt_iter","KMn_iter")

means <- apply(data, 2, mean)
sds <- apply(data, 2, sd )
data <- rbind(sds, data)
data <- rbind(means, data)

filename <- paste('Time',name, n, p, SNR, K, max.dim, smode, sep='_')
filename <- paste(filename, '.csv', sep='')
write.csv(format(x=data,digits=6), file=filename)