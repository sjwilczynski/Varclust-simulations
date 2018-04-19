#!/bin/bash

for i in {1..11}
do
    mkdir -p outputs_results/simulations$i
    cp -r simulations$i/summaries/*   outputs_results/simulations$i/
done

