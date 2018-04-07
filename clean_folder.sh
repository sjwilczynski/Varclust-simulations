#!/bin/bash
name="$1"

rm -f tmpM
rm -f segmentation*
rm -f timeR*
rm -f timeM*
rm -f data/X_*.csv
mkdir -p podsumowania/$name/results 
mkdir -p podsumowania/$name/ouputs
mv  output_* podsumowania/$name/ouputs
mv  bic_* podsumowania/$name/ouputs

mv  ARI* podsumowania/$name/results
mv  BIC* podsumowania/$name/results
mv  Time* podsumowania/$name/results

