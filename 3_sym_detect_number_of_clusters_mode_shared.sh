#!/bin/bash
# klastry 

N=(100)
P=(600)
SNR=(1)
K=(5 10 15 20)
MAXDIM=(3)
runs=30
MODE=(0)
repets=100
i=0
name="detect#ClustsModeS"

echo "Start script klastry"

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
						nohup ./symulacje_liczba_klastrow_wejscie.sh $n $p $snr $k $maxdim $runs $repets $mode $name
						echo "Run $i done. Parameters: n=$n, p=$p, snr=$snr, k=$k, maxdim=$maxdim, mode=$mode"
					done
				done
			done
		done
	done
done
./clean_folder.sh $name
echo "DONE"