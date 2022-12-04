test_case=$1

#uncompressed
#python evaluateTracking_TVD.py --tests /data/wgao/dataset/TVD/results/"$test_case"  > results/"$test_case"_tvd_results.log

#compressed
python evaluateTracking_TVD.py --tests /data/wgao/SoftwareDev/vvc_inter_tool/png/TVD/anchor/scale100/results/"$test_case"  > results/"$test_case"_tvd_results.log


