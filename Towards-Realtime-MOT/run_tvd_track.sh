test_case=$1
gpu_id=$2

#for uncompressed  case
#CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --scale 0 --qp 0 --save-videos

#for compressed case
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --scale 100 --qp 01
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --scale 100 --qp 02
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --scale 100 --qp 03
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --scale 100 --qp 04
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --scale 100 --qp 05
CUDA_VISIBLE_DEVICES=$gpu_id python ./tvd_track.py --scale 100 --qp 06