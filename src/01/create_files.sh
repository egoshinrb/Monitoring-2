#!/bin/bash

MAX_SYMBOLS=$(( 55 - 7 - 4 ))

f_path=$1
date=$2
f_count=$3
f_name=$4
f_ext=$5
f_size=$6

for ((i = 0; i < $f_count; ++i)); do # цикл по количеству файлов
    name=$(../01/names_generator.sh $MAX_SYMBOLS $f_name)
    if [[ ${#name} -lt 4 ]]; then
        i=$(( $i - 1 ))
        continue
    fi

    all_f_path=$f_path"/"$name"_"$date"."$f_ext
    if [[ -f $all_f_path ]]; then
        i=$(( $i - 1 ))
    else
        sudo fallocate -l $f_size $all_f_path 2> /dev/null

        echo "File create  $all_f_path $date ${f_size}b" >> file.log

        if [[ $(df -h / | awk '/[0-9]*.[0-9]G/{print $4}') =~ ^(1.0G)|(0.[0-9]G)|([0-9]+M)$ ]]; then
            echo "Available 1.0G"
            break
        fi
    fi
done