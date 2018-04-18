#!/bin/bash

n=$1 #number of individuals
p=$2 #number of variables
SNR=$3 #Signal to Noise ratio
K=$4 #number of subspaces
dim=$5 #maximum subspaces dimension
runs=$6 #number of runs for MLCC
repets=$7 #number of repetitions
mode=$8 #0 - shared, 1 - not shared factors of subspaces
name="$9" #name of the simultaion

nazwa=`whoami`

z=$((p/K))
y=$((z*K))
if [ $y != $p ]
then
    echo "K does not divide p. ERROR"
else
Rscript source/R/sim_data.R $n $p $SNR $K $dim $mode $K
if [ "$nazwa" == "stachu" ]
then
/usr/local/MATLAB/R2016a/bin/matlab -nosplash -nodisplay -nojvm -r "cd('source/matlab'), simulations_time($n, $dim, $SNR, $K, $p, $repets),quit()" > tmpM
else
matlab -nosplash -nodisplay -nojvm -r "cd('source/matlab'), simulations_time($n, $dim, $SNR, $K, $p, $repets),quit()" > tmpM
fi
Rscript source/R/sim_kmeans_time.R $n $p $SNR $K $dim $repets  
fi
