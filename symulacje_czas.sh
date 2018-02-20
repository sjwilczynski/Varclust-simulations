#!/bin/bash

n=100 #number of individuals
p=3000 #number of variables
SNR=1 #Signal to Noise ratio
K=10 #number of subspaces
dim=4 #maximum subspaces dimension
runs=1 #number of runs for MLCC
repets=50 #number of repetitions
mode=0 #0 - shared, 1 - not shared factors of subspaces

nazwa=`whoami`

z=$((p/K))
y=$((z*K))
if [ $y != $p ]
then
    echo "K does not divide p. ERROR"
else
rm -f timeR* timeM*
echo "Generating dataset"
Rscript source/R/dataSIMULATION.R $n $p $SNR $K $dim $mode
echo "dataset simulated"
for i in $(seq 1 $repets)
do
    echo "Run $i"
    echo "SSC and LRSC"
    if [ "$nazwa" == "stachu" ]
    then
    /usr/local/MATLAB/R2016a/bin/matlab -nosplash -nodisplay -nojvm -r "cd('source/Matlab'), moje_symulacje_czas($n, $dim, $SNR, $K, $p),quit()" > tmpM
    else
    matlab -nosplash -nodisplay -nojvm -r "cd('source/Matlab'), moje_symulacje_czas($n, $dim, $SNR, $K, $p),quit()" > tmpM
    fi
    echo "MLCC and ClustOfVar"
    Rscript source/R/MLCC_simulation_czas.R $n $p $SNR $K $dim $i  
done
echo "Summary"
Rscript podsumowanie_pojedyncze_time.R $n $p $SNR $K $dim $repets $mode
fi
