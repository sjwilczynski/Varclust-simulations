#!/bin/bash
#mode

N=(100)
P=(800)
SNR=(1)
K=(5)
MAXDIM=(3)
runs=30
MODE=(0 1)
repets=100
i=0
name="mode"

echo "Start script mode"

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
						nohup ./symulacje_wejscie.sh $n $p $snr $k $maxdim $runs $repets $mode $name
						echo "Run $i done. Parameters: n=$n, p=$p, snr=$snr, k=$k, maxdim=$maxdim, mode=$mode"
					done
				done
			done
		done
	done
done
./clean_folder.sh $name
echo "DONE"