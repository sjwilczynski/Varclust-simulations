#!/bin/bash
#http://www.sthda.com/english/wiki/determining-the-optimal-number-of-clusters-3-must-known-methods-unsupervised-machine-learning

n=100 #number of individuals
p=300 #number of variables
SNR=1 #Signal to Noise ratio
K=15 #number of subspaces
dim=4 #maximum subspaces dimension
runs=30 #number of runs for MLCC
repets=100 #number of repetitons
mode=0 #0 - shared, 1 - not shared factors of subspaces

nazwa=`whoami`

z=$((p/K))
y=$((z*K))
if [ $y != $p ]
then
    echo "K does not divide p. ERROR"
else
    echo "Choosing number of cluster"
    Rscript source/R/wybor_liczby_klastrow_BIC.R $n $p $SNR $K $dim $runs $repets $mode
echo "Summary"
Rscript podsumowanie_pojedyncze_bic.R $n $p $SNR $K $dim $repets $mode
fi
