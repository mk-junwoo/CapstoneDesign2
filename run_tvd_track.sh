test_case=$1
gpu_id=$2

#for uncompressed  case
#CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --test_case $test_case --scale 0 --qp 0 --save-videos

#for compressed case
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --test_case $test_case --scale 100 --qp 22
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --test_case $test_case --scale 100 --qp 27
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --test_case $test_case --scale 100 --qp 32
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --test_case $test_case --scale 100 --qp 37
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --test_case $test_case --scale 100 --qp 42
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --test_case $test_case --scale 100 --qp 47

