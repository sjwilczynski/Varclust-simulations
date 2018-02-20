#na czas
n=100
p=2500
snr=1
k=5
maxdim=3
runs=30
repets=1000
mode=0

echo "Run start. Parameters: n=$n, p=$p, snr=$snr, k=$k, maxdim=$maxdim, mode=$mode"
nohup ./symulacje_czas_wejscie.sh $n $p $snr $k $maxdim $runs $repets $mode
echo "Run done. Parameters: n=$n, p=$p, snr=$snr, k=$k, maxdim=$maxdim, mode=$mode"