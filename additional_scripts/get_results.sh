#!/bin/bash

for i in {1..11}
do
    mkdir -p outputsResults/simulations$i
    cp -r simulations$i/summaries/*   outputsResults/simulations$i/
done

