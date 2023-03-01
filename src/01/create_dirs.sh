#!/bin/bash

MAX_SYMBOLS=$(( 55 - 7 ))

date=$(date +%d%m%y)
path=$1
d_count=$2
d_name=$3

f_count=$4
f_name=$(echo -n "${5}" | awk -F. '{print $1}')
f_ext=$(echo -n "${5}" | awk -F. '{print $2}')
f_size=${6:0:$(( ${#6} - 1 ))}

for ((i = 0; i < $d_count; ++i)); do # цикл по количеству папок
    name=$(../01/names_generator.sh $MAX_SYMBOLS $d_name)
    if [[ ${#name} -lt 4 ]]; then
        i=$(( $i - 1 ))
        continue
    fi

    d_path=$path"/"$name"_"$date
    if [[ -d $d_path ]]; then
        i=$(( $i - 1 ))
    else
        sudo mkdir $d_path 2> /dev/null

        if [[ !(-d $d_path) ]]; then
            break
        fi

        echo "Directory create $d_path $date" >> file.log
        message=$(../01/create_files.sh $d_path $date $f_count $f_name $f_ext $f_size)
        if [[ $message == "Available 1.0G" ]]; then
            echo "Available 1.0G"
            break
        fi
    fi
done