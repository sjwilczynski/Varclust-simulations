#!/bin/bash
#diffSNR

N=(100)
P=(600)
SNR=("c(0.25, 0.5, 1, 2, 4)" "c(0.5, 0.75, 1, 1.25, 1.5)" "c(0.5, 1, 1.5, 2, 2.5)")
K=(5)
MAXDIM=(3)
runs=30
MODE=(1)
repets=100
i=0
name="diffSNRmodeNS"

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
						nohup ./sim_reps.sh $n $p $snr $k $maxdim $runs $repets $mode $name
						echo "Run $i done."
					done
				done
			done
		done
	done
done
./clean_folder.sh $name
echo "DONE"
