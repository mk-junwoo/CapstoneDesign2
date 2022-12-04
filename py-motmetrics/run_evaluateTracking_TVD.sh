read test_case

#uncompressed
python evaluateTracking_TVD.py --tests /CapstoneDesign2/TVD_DATA/Original_Data/results/SQ3_"$test_case"  > /CapstoneDesign2/TVD_DATA/Original_Data/results/SQ3_"$test_case"/tvd_results.log

#compressed
#python evaluateTracking_TVD.py --tests /CapstoneDesign2/TVD_DATA/GQ_Data/results/"$test_case"  > /CapstoneDesign2/TVD_DATA/GQ_Data/results/"$test_case"/tvd_results.log
python evaluateTracking_TVD.py --tests /CapstoneDesign2/TVD_DATA/Original_Data/results/SQ3_"$test_case"  > /CapstoneDesign2/TVD_DATA/Original_Data/results/SQ3_"$test_case"/tvd_results.log


