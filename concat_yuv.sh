base_path=$1
seq_name=$2
start_idx=$3
end_idx=$4
output_file=$5

for n in $(seq -f "%06g" $start_idx $end_idx)
do
	cat "$base_path"/"$seq_name"/scale100_yuv/"$seq_name"_"$n".yuv >> $output_file
done

