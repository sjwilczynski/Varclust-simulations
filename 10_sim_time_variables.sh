#!/bin/bash
#time

N=(100)
P=(300 600 900 1200 1500)
SNR=(1)
K=(5)
MAXDIM=(3)
runs=1
MODE=(0)
repets=100
i=0
name="#variables"

for n in ${N[*]}
do
	for p in ${P[*]}
	do
		for snr in ${SNR[*]}
		do
			for k in ${K[*]}
			do
				for maxdim in ${MAXDIM[*]}
				do
					for mode in ${MODE[*]}
					do
						((i++))
						echo "Run $i start. Parameters: n=$n, p=$p, snr=$snr, k=$k, maxdim=$maxdim, mode=$mode"
						nohup ./sim_time.sh $n $p $snr $k $maxdim $runs $repets $mode $name
						echo "Run $i done."
					done
				done
			done
		done
	done
done
Rscript summary_time.R $N "c(300, 600, 900, 1200, 1500)" $SNR "c(5)" $MAXDIM $repets $MODE $name
./clean_folder.sh $name
echo "DONE"
