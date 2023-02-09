#!/bin/bash

docker ps --format '\t{{.Names}}' > docker_container_name_list.txt
ps aux | grep jupyter/runtime/kernel > host_ps_jupyter.txt
pgrep -f jupyter/runtime/kernel > jupyter_pid.txt
nvidia-smi -q | grep "Process ID" | cut -d ":" -f2 > gpu_pid.txt


echo -e "\033[31m<< display which jupyter process using gpu >>\033[0m"
nvidia-smi
while read container_name || [ -n "$container_name" ]; do
    container_hash=($(docker exec $container_name ps aux | grep jupyter/runtime/kernel | rev | cut -d '/' -f1 | rev))
    if [[ -n $container_hash ]]; then 
        echo  -e "\033[32m$container_name\033[0m"
    fi
    for hash in "${container_hash[@]}"
    do
        while read gpu_pid || [ -n "$gpu_pid" ]; do
            host_hash=$(ps aux | grep jupyter/runtime/kernel | grep $gpu_pid | rev | cut -d '/' -f1 | rev)
                if [[ -n $hash && $host_hash == $hash ]]; then
                    echo -e "$gpu_pid" 
                fi
        done < gpu_pid.txt
    done
    if [[ -n $container_hash ]]; then
        echo -e ""
    fi
done < docker_container_name_list.txt
echo -e "\n"


echo -e "\033[31m<< display host jupyter process >>\033[0m"
while read host_ps_jupyter || [ -n "$host_ps_jupyter" ]; do
    if [[ $host_ps_jupyter == *.json* ]]; then
        echo "$host_ps_jupyter"
    fi
done < host_ps_jupyter.txt
echo -e "\n"


echo -e "\033[31m<< display docker container jupyter process >>\033[0m"
while read container_name || [ -n "$container_name" ]; do
    container_hash=$(docker exec $container_name ps aux | grep jupyter/runtime/kernel | rev | cut -d '/' -f1 | rev)
    if [[ $container_hash == *.json* ]]; then
        echo -e "\033[32m$container_name\033[0m"
        echo -e "$container_hash\n"
    fi
done < docker_container_name_list.txt
echo -e "\n"


# rm
rm -f host_ps_jupyter.txt
rm -f docker_container_name_list.txt
rm -f jupyter_pid.txt
rm -f gpu_pid.txt
