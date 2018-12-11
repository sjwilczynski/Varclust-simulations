#!/bin/bash

n=$1 #number of individuals
p=$2 #number of variables
SNR=$3 #Signal to Noise ratio
K=$4 #number of subspaces
dim=$5 #maximum subspaces dimension
runs=$6 #number of runs for MLCC
repets=$7 #number of repetitons
mode=$8 #0 - shared, 1 - not shared factors of subspaces
name="$9" #name of the simultaion

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
    echo "Rep $i"
    #echo "Generating dataset"
    Rscript source/R/sim_data.R $n $p $SNR $K $dim $mode $i $name
    #echo $dim

    #echo "dataset simulated"
    #echo "SSC and LRSC"
    if [ "$nazwa" == "stachu" ]
    then
    /usr/local/MATLAB/R2016a/bin/matlab -nosplash -nodisplay -nojvm -r "cd('source/matlab'), simulations($K, $name),quit()" > tmpM
    else
    matlab -nosplash -nodisplay -nojvm -r "cd('source/matlab'), simulations($K, $name),quit()" > tmpM 
    fi
    #echo "MLCC and ClustOfVar"
    Rscript source/R/sim_reps.R $K $dim $runs $name
    #echo "Analysis of the results"
    Rscript source/R/results_analysis.R $n $p $SNR $K $dim $mode $i $name
done
#echo "Summary"
Rscript summary.R $n $p $SNR $K $dim $repets $mode $name
fi
