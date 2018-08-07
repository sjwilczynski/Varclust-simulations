#!/bin/bash
#PBS -q main
#PBS -l walltime=200:00:00
#PBS -l select=1:ncpus=8:mem=8196MB
#PBS -l software=R
#PBS -m be
 
# wejscie do katalogu, z ktorego zostalo wstawione zadania
cd $PBS_O_WORKDIR

module load r
 
# uruchom program 
# z PRZEKIEROWANIEM ZAPISYWANIA WYNIKOW -- BARDZO WAZNE
./all_simulations.sh 2 >& task_output.txt
