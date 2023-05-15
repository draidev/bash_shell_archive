#!/bin/bash

i=1
while true
do
    cur_time=$(date '+%Y%m%d_%H%M')
    if [ ! -d $cur_time ]; then
        mkdir "${cur_time}"
    fi  
    echo "$i" > "${cur_time}/${i}.txt"
    ((i++))
done
