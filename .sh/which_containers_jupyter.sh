#!/bin/bash

docker ps --format '\t{{.Names}}' > docker_container_name_list.txt
ps aux | grep jupyter/runtime/kernel > host_ps_jupyter.txt



echo -e "\033[31m<< display host jupyter process >>\033[0m"
while read host_ps_jupyter || [ -n "$host_ps_jupyter" ]; do
    if [[ "$host_ps_jupyter" == *.json* ]]; then
        echo "$host_ps_jupyter"
    fi  
done < host_ps_jupyter.txt
echo -e "\n"



echo -e "\033[31m<< display docker container jupyter process >>\033[0m"
while read container_name || [ -n "$container_name" ]; do
    result=$(docker exec $container_name ps aux | grep jupyter/runtime/kernel | rev | cut -d '/' -f1 | rev)
    if [[ "$result" == *.json* ]]; then
        echo -e "\033[32m$container_name\033[0m"
        echo -e "$result\n"
    fi  
done < docker_container_name_list.txt



# rm
rm -f host_ps_jupyter.txt
rm -f docker_container_name_list.txt
