# Simulations for *varclust* package

In this repository there are all scripts used to evaluate *varclust* performance
on synthetic datasets. All the figures from my bachelor thesis/varclust paper can be recreated using this code.

## Preparation

In order to run the simulations, you have to install *varclust* and all its dependencies as well some additional packages. You can do this by running *packages.R* from *packages* directory.

## Repository structure

The main simulations scripts have names starting with numerical prefix. The results (including generated plots) are available in summaries folder. There, for example, *4_sim_max_dim* directory corresponds to both partial and summarized results for *4_sim_max_dim.sh* script. *data* is a temporary folder for generated datasets. The R and matlab code invoking compared methods directly can be found in *source* directory.

## Running simulations

You can run all simulations simply by:

```bash
./all_simulations.sh all
```

However, due to the complexity of the methods, we recommend to run all main simulation scripts separately. For example, if you want to run *4_sim_max_dim.sh* you can just:

```bash
./all_simulations.sh 4
```

Additionally, due to the time needed to run each of the scripts, to prevent them from being interupted due to e.g disconnects, using [screen](https://linuxize.com/post/how-to-use-linux-screen/) command is recommended.

## Step by step instruction for running simulations 

1. Checkout this repository
1. Install required packages by running `Rscript packages/packages.R`
1. Type `screen -S simulation_1` to start the new virtual terminal session
1. Run `./all_simulations.sh 1` to start first simulation script
1. Detach from the screen session using `Ctrl+a+d` shortcut
1. Similarly run other simulation scripts on different machines
1. After few days log back to the machine and reattach screen session using `screen -r` command
1. Check if it's completed. If there was an issue:
    1. Rerun the simulation
    1. If you think it's a bug (you can confirm this by looking at the relevant `nohup.out` file) and report an issue

**TIP** for running simulations in the Math department of Univesity of Wroclaw:
Login to chaos and then run each of the simulations on machines from win01 to win12

## Troubleshooting

1. I can't execute the script becuase of "No access" or similar error - make sure to run `chmod u+x script_name.sh`
