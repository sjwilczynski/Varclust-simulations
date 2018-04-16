#!/bin/bash

for i in {1..10}
do
    mkdir -p outputsResults/symulacje$i
    cp -r symulacje$i/podsumowania/*   outputsResults/symulacje$i/
done

