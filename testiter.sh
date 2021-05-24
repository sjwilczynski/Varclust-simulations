#!/bin/bash
#test_iter

name="test_iter"
n=10
P=(50)
k=5
snr=0.5
maxdim=3
numbruns=3
maxiter=30
i=0

do
    echo "Run $i start. Parameters: n=$n, p=${P[$i]}, snr=$snr, k=$k, maxdim=$maxdim, numbruns=$numbruns, maxiter=$maxiter"
    nohup Rscript source/R/sim_iter.R $n ${P[$i]} $snr $k $maxdim $numbruns $maxiter $name
    echo "Run $i done."
done
./clean_folder.sh $name
echo "DONE"