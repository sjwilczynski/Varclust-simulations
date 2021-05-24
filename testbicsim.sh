#!/bin/bash
# klastry 

N=(10)
P=(50)
SNR=(1)
K=(5)
MAXDIM=(3)
runs=30
MODE=(1)
repets=3
i=0
name="test_bic"

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
						nohup ./sim_mbic.sh $n $p $snr $k $maxdim $runs $repets $mode $name
						echo "Run $i done."
					done
				done
			done
		done
	done
done
./clean_folder.sh $name
echo "DONE"