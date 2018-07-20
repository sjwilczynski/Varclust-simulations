# Simulations for *varclust* package

In this repository there are all scripts used to evaluate *varclust* performance
on synthetic datasets. All the figures from ... can be recreated using this code.

## Preparation

In order to run the simulations, you have to install *varclust* and all its dependencies as well some additional packages. You can do this by running *packages.R* from *packages* directory.

## Repository structure

The main simulations scripts have names starting with numerical prefix. The results (including generated plots) are available in outputs_results folder. There, for example, *simulations4* directory corresponds to both partial and summarized results for *4_sim_max_dim.sh* script. *data* and *summaries* directories are temporary folders for generated datasets and results respectively. The R and matlab code invoking compared methods directly can be found in *source* directory.

## Running simulations

You can run all simulations simply by:

```bash
./all_simulations.sh all
```

However, due to the complexity of the methods, we recommend to run all main simulation scripts separately. For example, if you want to run *4_sim_max_dim.sh* you can just:

```bash
./all_simulations.sh 4
```
