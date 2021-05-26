#!/bin/bash
name="$1"

rm -f $name/tmpM
rm -f $name/segmentation*
rm -f $name/timeR*
rm -f $name/timeM*
rm -rf data/$name
mkdir -p summaries/$name/results 
mkdir -p summaries/$name/ouputs
mv  $name/output_* summaries/$name/ouputs
mv  $name/bic_* summaries/$name/ouputs
mv  $name/iterations_* summaries/$name/ouputs

mv  $name/ARI* summaries/$name/results
mv  $name/BIC* summaries/$name/results
mv  $name/Time* summaries/$name/results
mv  $name/Iterations* summaries/$name/results
