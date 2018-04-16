#!/bin/bash

for i in {1..10}
do
    mkdir -p outputs_results/simulations$i
    cp -r simulations$i/summaries/*   outputs_results/simulations$i/
done

