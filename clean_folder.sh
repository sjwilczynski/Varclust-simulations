#!/bin/bash
name="$1"

rm -f tmpM
rm -f segmentation*
rm -f timeR*
rm -f timeM*
rm -f data/X_*.csv
mkdir -p summaries/$name/results 
mkdir -p summaries/$name/ouputs
mv  output_* summaries/$name/ouputs
mv  bic_* summaries/$name/ouputs

mv  ARI* summaries/$name/results
mv  BIC* summaries/$name/results
mv  Time* summaries/$name/results

