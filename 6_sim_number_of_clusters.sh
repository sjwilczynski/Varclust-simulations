#!/bin/bash
#liczba klastrow

N=(100)
P=(600)
SNR=(1)
K=(5 10 15 20)
MAXDIM=(3)
runs=30
MODE=(0)
repets=100
i=0
name="6_sim_number_of_clusters"

mkdir -p $name
mkdir -p data/$name

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
						echo "Run $i start. Parameters: n=$n, p=$p, snr=$snr, k=$k, maxdim=$maxdim, mode=$mode, name=$name"
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
