#!/bin/bash

sum_hour_count() {
    if [ "$t" == "exec" ]; then
        ((exec_hour_cnt+=file_count))
        #echo -e "exec_hour_cnt : ${exec_hour_cnt}"
    fi
    if [ "$t" == "image" ]; then
        ((image_hour_cnt+=file_count))
        #echo -e "image_hour_cnt : ${image_hour_cnt}"
    fi
    if [ "$t" == "unknown" ]; then
        ((unknown_hour_cnt+=file_count))
        #echo -e "unknown_hour_cnt : ${unknown_hour_cnt}"
    fi
    if [ "$t" == "post" ]; then
        ((post_hour_cnt+=data_count))
        #echo -e "post_hour_cnt : ${post_hour_cnt}"
    fi
    if [ "$t" == "chatgpt" ]; then
        ((chatgpt_hour_cnt+=data_count))
        #echo -e "chatgpt_hour_cnt : ${chatgpt_hour_cnt}"
    fi
}

sum_hour_size() { 
    if [ "$t" == "exec" ]; then
        ((exec_hour_size+=file_size))
        #echo -e "exec_hour_size : ${exec_hour_size}"
    fi
    if [ "$t" == "image" ]; then
        ((image_hour_size+=file_size))
        #echo -e "image_hour_size : ${image_hour_size}"
    fi
    if [ "$t" == "unknown" ]; then
        ((unknown_hour_size+=file_size))
        #echo -e "unknown_hour_size : ${unknown_hour_size}"
    fi
    if [ "$t" == "post" ]; then
        ((post_hour_size+=data_size))
        #echo -e "post_hour_size : ${post_hour_size}"
    fi
    if [ "$t" == "chatgpt" ]; then
        ((chatgpt_hour_size+=data_size))
        #echo -e "chatgpt_hour_size : ${chatgpt_hour_size}"
    fi

    ((hour_total_size=exec_hour_size+image_hour_size+unknown_hour_size+post_hour_size+chatgpt_hour_size))
}

print_stat() {
    echo "#$1 : $2"
    echo "#$3 : $4B ($(($4/1024))K)($(($4/1024/1024))M)($(($4/1024/1024/1024))G)"
    ((aver=$4/$2))
    echo "#average_$3 : ${aver}B ($(($aver/1024))K)($(($aver/1024/1024))M)($(($aver/1024/1024/1024))G)"
}

process_after_one_hour() {
    if [ $exec_hour_cnt -gt 0 ]; then
        print_stat exec_hour_cnt $exec_hour_cnt exec_hour_size $exec_hour_size
    fi
    if [ $image_hour_cnt -gt 0 ]; then
        print_stat image_hour_cnt $image_hour_cnt image_hour_size $image_hour_size
    fi 
    if [ $unknown_hour_cnt -gt 0 ]; then
        print_stat unknown_hour_cnt $unknown_hour_cnt unknown_hour_size $unknown_hour_size
    fi
    if [ $post_hour_cnt -gt 0 ]; then
        print_stat post_hour_cnt $post_hour_cnt post_hour_size $post_hour_size
    fi
    if [ $chatgpt_hour_cnt -gt 0 ]; then
        print_stat chatgpt_hour_cnt $chatgpt_hour_cnt chatgpt_hour_size $chatgpt_hour_size
    fi    

    echo "[ hour_total_size : ${hour_total_size}B ($((hour_total_size/1024))K)($((hour_total_size/1024/1024))M)($((hour_total_size/1024/1024/1024))G) ]"

    ((exec_day_cnt+=exec_hour_cnt))
    ((image_day_cnt+=image_hour_cnt))
    ((unknown_day_cnt+=unknown_hour_cnt))
    ((post_day_cnt+=post_hour_cnt))
    ((chatgpt_day_cnt+=chatgpt_hour_cnt))
    ((exec_day_size+=exec_hour_size))
    ((image_day_size+=image_hour_size))
    ((unknown_day_size+=unknown_hour_size))
    ((post_day_size+=post_hour_size))
    ((chatgpt_day_size+=chatgpt_hour_size))

    exec_hour_cnt=0
    image_hour_cnt=0
    unknown_hour_cnt=0
    post_hour_cnt=0
    chatgpt_hour_cnt=0
    exec_hour_size=0
    image_hour_size=0
    unknown_hour_size=0
    post_hour_size=0
    chatgpt_hour_size=0
	hour_total_size=0
}

default_path=/lockard_ai/data/files/
file_items=("exec" "image" "unknown")
post_items=("post" "chatgpt")

exec_hour_cnt=0
image_hour_cnt=0
unknown_hour_cnt=0
post_hour_cnt=0
chatgpt_hour_cnt=0

exec_day_cnt=0
image_day_cnt=0
unknown_day_cnt=0
post_day_cnt=0
chatgpt_day_cnt=0

exec_hour_size=0
image_hour_size=0
unknown_hour_size=0
post_hour_size=0
chatgpt_hour_size=0

exec_day_size=0
image_day_size=0
unknown_day_size=0
post_day_size=0
chatgpt_day_size=0

hour_total_size=0
day_total_size=0

for i in {00..23}; do  # loop per hour
    echo "<<process Hour : $i>>"
    for j in {00..15} 98; do # loop per thread number
        for t in "${file_items[@]}"; do
            #ls -al $default_path$1_$i/00/$j/$t.files 2> /dev/null
            file_size=$(ls -al $default_path$1_$i/00/$j/$t.files 2> /dev/null | cut -d ' ' -f5)
            if [ -e $default_path$1_$i/00/$j/$t.meta ] && [ $(wc -l < $default_path$1_$i/00/$j/$t.meta 2>/dev/null) -gt 0 ]; then
                file_count=$(cat $default_path$1_$i/00/$j/$t.meta | wc -l)
                sum_hour_count
                sum_hour_size
            fi
        done
        for t in "${post_items[@]}"; do
            #ls -al $default_path$1_$i/00/$j/$t.data 2> /dev/null
            data_size=$(ls -al $default_path$1_$i/00/$j/$t.data 2> /dev/null | cut -d ' ' -f5)
            if [ -e $default_path$1_$i/00/$j/$t.meta ] && [ $(wc -l < $default_path$1_$i/00/$j/$t.meta 2>/dev/null) -gt 0 ]; then
                data_count=$(cat $default_path$1_$i/00/$j/$t.meta | wc -l) 
                sum_hour_count
                sum_hour_size
            fi
        done
    done
    process_after_one_hour
    echo -e "\n"
done

# print all
echo "###############################"
if [ $exec_day_cnt -gt 0 ]; then
    print_stat exec_day_cnt $exec_day_cnt exec_day_size $exec_day_size
fi
if [ $image_day_cnt -gt 0 ]; then
    print_stat image_day_cnt $image_day_cnt image_day_size $image_day_size
fi
if [ $unknown_day_cnt -gt 0 ]; then
    print_stat unknown_day_cnt $unknown_day_cnt unknown_day_size $unknown_day_size
fi
if [ $post_day_cnt -gt 0 ]; then
    print_stat post_day_cnt $post_day_cnt post_day_size $post_day_size
fi
if [ $chatgpt_day_cnt -gt 0 ]; then
    print_stat chatgpt_day_cnt $chatgpt_day_cnt chatgpt_day_size $chatgpt_day_size
fi

((day_total_size=exec_day_size+image_day_size+unknown_day_size+post_day_size+chatgpt_day+size))
echo "[ day_total_size : $((day_total_size/1024))K, $((day_total_size/1024/1024))M, $((day_total_size/1024/1024/1024))G ]"
echo "###############################"
