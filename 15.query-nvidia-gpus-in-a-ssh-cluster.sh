# This code assumes ssh keys have been saved

RED='\e[1;31m'
NC='\e[0m' # No Color or other format

hosts_arr=(GPU1 GPU3 GPU4 GPU5 GPU6 GPU7 GPU8 GPU9 GPU10 GPU11)

P=()


for ((i=0; i<${#hosts_arr[@]}; i++));
do
	echo -e querying ${RED}${hosts_arr[$i]}${NC}
	ssh ${hosts_arr[$i]} nvidia-smi -q > /tmp/GPU_usage_${hosts_arr[$i]}  &
	P[$i]=$!
done

echo

printf "%30s\t%10s\t%10s\t%10s\n" Name Number Usage Memory

for ((i=0; i<${#hosts_arr[@]}; i++));
do
	wait ${P[$i]}
	echo -e Node: ${RED}${hosts_arr[$i]}${NC} 
	gpu_names=($(grep 'Product Name' /tmp/GPU_usage_${hosts_arr[$i]} | sed -n 's/.*: \(.*\)$/\1/p' | sed -e 's/\s/_/g'))
	gpu_numbers=($(grep 'Minor Number' /tmp/GPU_usage_${hosts_arr[$i]} | grep -oP '[0-9]+'))
	gpu_usages=($(grep -Pzo "(?s)Utilization.*?Encoder" /tmp/GPU_usage_${hosts_arr[$i]} | grep 'Gpu' | grep -oP '[0-9]+'))
	gpu_mem_totals=($(grep -Pzo "(?s)FB Memory Usage.*?BAR1 Memory Usage" /tmp/GPU_usage_${hosts_arr[$i]} | grep 'Total' | grep -oP '[0-9]+\s+MiB' | sed -e 's/\s/_/g'))
	gpu_mem_usages=($(grep -Pzo "(?s)FB Memory Usage.*?BAR1 Memory Usage" /tmp/GPU_usage_${hosts_arr[$i]} | grep 'Used' | grep -oP '[0-9]+\s+MiB' | sed -e 's/\s/_/g'))
	
	len=${#gpu_numbers[@]}
	
	for ((j=0;j<$len;j++));
	do
		printf "%30s\t%10s\t%10s\t%10s\n" ${gpu_names[$j]} ${gpu_numbers[$j]} ${gpu_usages[$j]}% ${gpu_mem_usages[$j]}/${gpu_mem_totals[$j]} | sed -e 's/_/ /g'
	done
done