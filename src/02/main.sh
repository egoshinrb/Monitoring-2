#!/bin/bash

if [[ $# != 3 ]]; then
    echo "Not all parameters are entered or superfluous"
else
    sudo chmod +x ../01/check_parameter.sh ../01/create_dirs.sh ../01/create_files.sh ../01/names_generator.sh
    error=$(../01/check_parameter.sh / 1 $1 1 $2 $3)

    if [[ $error == "Success" ]]; then
        echo "Time start - $(date +%T)" | tee -a file.log

        time_sec_start=$(date +%s)
        d_name=$1
        f_name=$2
        f_size=$3

        message=""
        while [[ $message != "Available 1.0G" ]]; do
            d_count_all=$(sudo find / -type d -perm /a=w 2> /dev/null | grep -v bin | grep -v snap | grep -v 'dev' | grep -v 'run' | grep -vc '/sys/')
            number=$(($RANDOM%$d_count_all + 1))

            d_path=$(sudo find / -type d -perm /a=w 2> /dev/null | grep -v bin | grep -v snap | grep -v 'dev' | grep -v 'run' | grep -v '/sys/' | awk -v var=$number  'BEGIN{FS="\n"; RS=""} {print $var}')
            d_count=$(($RANDOM%10 + 1))
            f_count=$(($RANDOM%100 + 1))

            message=$(../01/create_dirs.sh $d_path $d_count $d_name $f_count $f_name $f_size)
        done
        echo $message

        echo "Time end - $(date +%T)" | tee -a file.log
        echo "Runtime - $(( $(($(date +%s) - $time_sec_start))/60 )) min $(( $(($(date +%s) - $time_sec_start))%60 )) sec" | tee -a file.log
    else
        echo $error
    fi
fi