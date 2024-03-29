#!/bin/bash

to_run="$1" #name of the simultaion

case $to_run in
    "1" )
        echo "mlcc.reps with twice overestimated maximal dimension of subspace"
        nohup ./1_sim_2max_dim.sh | tee 1-nohup.out 
        ;;
    "2" )
        echo "mlcc.bic for not shared mode"
        nohup ./2_sim_detect_number_of_clusters_mode_not_shared.sh | tee 2-nohup.out 
        ;;
    "3" )
        echo "mlcc.bic for shared mode"
        nohup ./3_sim_detect_number_of_clusters_mode_shared.sh | tee 3-nohup.out 
        ;;
    "4" )
        echo "mlcc.reps with increasing subspace dimension"
        nohup ./4_sim_max_dim.sh | tee 4-nohup.out 
        ;;
    "5" )
        echo "mlcc.reps with respect to mode"
        nohup ./5_sim_mode.sh | tee 5-nohup.out 
        ;;
    "6" )
        echo "mlcc.reps with increasing number of clusters"
        nohup ./6_sim_number_of_clusters.sh | tee 6-nohup.out 
        ;;
    "7" )
        echo "mlcc.reps with increasing number of variables"
        nohup ./7_sim_number_of_vars.sh | tee 7-nohup.out 
        ;;
    "8" )
        echo "mlcc.reps with increasing snr, mode not shared"
        nohup ./8_sim_snr_mode_not_shared.sh | tee 8-nohup.out 
        ;;
    "9" )
        echo "mlcc.reps with increasing snr, mode shared"
        nohup ./9_sim_snr_mode_shared.sh | tee 9-nohup.out 
        ;;
    "10" )
        echo "execution time with repsect to the number of variables"
        nohup ./10_sim_time_variables.sh | tee 10-nohup.out 
        ;;
    "11" )
        echo "execution time with repsect to the number of clusters"
        nohup ./11_sim_time_clusters.sh | tee 11-nohup.out 
        ;;
    "12" )
        echo "mBIC with repsect to the number of iterations"
        nohup ./12_sim_iter.sh | tee 12-nohup.out 
        ;;
    "test" )
        echo "test simulations"
        nohup ./testbicsim.sh | tee test-nohup.out
        nohup ./testsim.sh | tee test-nohup.out
        nohup ./testtimesim.sh | tee test-nohup.out 
        nohup ./testiter.sh | tee test-nohup.out 
        ;;
    "all" )
        echo "Run all simulations"
        nohup ./1_sim_2max_dim.sh | tee nohup.out
        nohup ./2_sim_detect_number_of_clusters_mode_not_shared.sh | tee nohup.out 
        nohup ./3_sim_detect_number_of_clusters_mode_shared.sh | tee nohup.out 
        nohup ./4_sim_max_dim.sh | tee nohup.out 
        nohup ./5_sim_mode.sh | tee nohup.out 
        nohup ./6_sim_number_of_clusters.sh | tee nohup.out 
        nohup ./7_sim_number_of_vars.sh | tee nohup.out 
        nohup ./8_sim_snr_mode_not_shared.sh | tee nohup.out 
        nohup ./9_sim_snr_mode_shared.sh | tee nohup.out 
        nohup ./10_sim_time_variables.sh | tee nohup.out 
        nohup ./11_sim_time_clusters.sh | tee nohup.out
        nohup ./12_sim_iter.sh | tee nohup.out  
        ;;
esac