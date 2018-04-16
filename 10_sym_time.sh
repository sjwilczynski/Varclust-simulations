#!/bin/bash
#time

N=(100)
P=(300 600 900 3000)
SNR=(1)
K=(5 10)
MAXDIM=(3)
runs=1
MODE=(0)
repets=100
i=0
name="time"

echo "Start script time"

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
						echo "Run $i done. Parameters: n=$n, p=$p, snr=$snr, k=$k, maxdim=$maxdim, mode=$mode"
					done
				done
			done
		done
	done
done
./clean_folder.sh $name
echo "DONE"
