require(varclust, quietly = TRUE)

sim.data <- function(n, p, SNR, K, max.dim, mode, name, to.file=TRUE) {
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
  
  if(to.file){
    file.name = paste('data/', name, '/X_', max.dim, "_", SNR[1], ".csv", sep='')
    write.table(X, file=file.name, row.names=F, col.names=F, sep=',')
  }
  X
}
