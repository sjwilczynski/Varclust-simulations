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
rm -f timeR* timeM*
#echo "Generating dataset"
Rscript source/R/dataSIMULATION.R $n $p $SNR $K $dim $mode
#echo "dataset simulated"
for i in $(seq 1 $repets)
do
    echo "Rep $i"
    #echo "SSC and LRSC"
    if [ "$nazwa" == "stachu" ]
    then
    /usr/local/MATLAB/R2016a/bin/matlab -nosplash -nodisplay -nojvm -r "cd('source/Matlab'), moje_symulacje_czas($n, $dim, $SNR, $K, $p),quit()" > tmpM
    else
    matlab -nosplash -nodisplay -nojvm -r "cd('source/Matlab'), moje_symulacje_czas($n, $dim, $SNR, $K, $p),quit()" > tmpM
    fi
    #echo "MLCC and ClustOfVar"
    Rscript source/R/MLCC_simulation_czas.R $n $p $SNR $K $dim $i  
done
#echo "Summary"
Rscript podsumowanie_pojedyncze_time.R $n $p $SNR $K $dim $repets $mode $name
fi
