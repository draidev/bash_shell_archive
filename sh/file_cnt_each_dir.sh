#!/bin/bash

for d in ./*/
do
    echo "$d"
    find "$d" -type f | wc -l
done
