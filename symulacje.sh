#!/bin/bash

n=10 #number of individuals
p=30 #number of variables
SNR=0.5 #Signal to Noise ratio
K=5 #number of subspaces
dim=3 #maximum subspaces dimension
runs=30 #number of runs for MLCC
repets=2 #number of repetitons
mode=0 #0 - shared, 1 - not shared factors of subspaces

nazwa=`whoami`

z=$((p/K))
y=$((z*K))
if [ $y != $p ]
then
    echo "K does not divide p. ERROR"
else

for i in $(seq 1 $repets)
do
    rm -f segmentation*
    echo "Run $i"
    echo "Generating dataset"
    Rscript source/R/dataSIMULATION.R $n $p $SNR $K $dim $mode
    echo "dataset simulated"
    #echo "SSC and LRSC"
    #if [ "$nazwa" == "stachu" ]
    #then
    #/usr/local/MATLAB/R2016a/bin/matlab -nosplash -nodisplay -nojvm -r "cd('source/Matlab'), moje_symulacje($n, $dim, $SNR, $K, $p),quit()" > tmpM
    #else
    #matlab -nosplash -nodisplay -nojvm -r "cd('source/Matlab'), moje_symulacje($n, $dim, $SNR, $K, $p),quit()" > tmpM
    #fi
    echo "MLCC and ClustOfVar"
    Rscript source/R/KppvsK.R $n $p $SNR $K $dim $runs
    echo "Analysis of the results"
    Rscript source/R/analizaKppvsK.R $n $p $SNR $K $dim $i
done
echo "Summary"
Rscript podsumowanie_pojedyncze.R $n $p $SNR $K $dim $repets $mode
fi
