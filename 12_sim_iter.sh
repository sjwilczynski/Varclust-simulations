#!/bin/bash
#iterations

name="#iterations"
n=100
P=(750 1500 3000)
k=5
snr=0.5
maxdim=4
numbruns=4
maxiter=30

for i in 0 1 2
do
    echo "Run $i start. Parameters: n=$n, p=${P[$i]}, snr=$snr, k=$k, maxdim=$maxdim, numbruns=$numbruns, maxiter=$maxiter"
    nohup Rscript source/R/sim_iter.R $n ${P[$i]} $snr $k $maxdim $numbruns $maxiter $name
    echo "Run $i done."
done
./clean_folder.sh $name
echo "DONE"