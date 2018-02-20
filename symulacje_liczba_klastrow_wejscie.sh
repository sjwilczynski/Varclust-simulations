#!/bin/bash

n=$1 #number of individuals
p=$2 #number of variables
SNR=$3 #Signal to Noise ratio
K=$4 #number of subspaces
dim=$5 #maximum subspaces dimension
runs=$6 #number of runs for MLCC
repets=$7 #number of repetitions
mode=$8 #0 - shared, 1 - not shared factors of subspaces
name="$9"


z=$((p/K))
y=$((z*K))
if [ $y != $p ]
then
    echo "K does not divide p. ERROR"
else
    #echo "Choosing number of cluster"
    Rscript source/R/wybor_liczby_klastrow_BIC.R $n $p $SNR $K $dim $runs $repets $mode $name
#echo "Summary"
Rscript podsumowanie_pojedyncze_bic.R $n $p $SNR $K $dim $repets $mode $name
fi
