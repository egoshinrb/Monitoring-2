#!/bin/bash

if [[ $# != 1 ]]; then
    echo "Parameter not are entered"
else
    before=$(df -h / | awk '/sda/{print $4}')

    if [[ $1 == 1 ]]; then
        echo "Write name of the log-file:"; read file

        if [[ -f $file ]]; then
            for line in $(awk '/Directory create/{print $3}' $(sudo find / -type f -name "$file" 2> /dev/null)); do
                sudo rm -rf $line
            done
        else
            echo "File not exists"; exit
        fi

    elif [[ $1 == 2 ]]; then
        echo "Write the creation date and time - start (in format YYYY-MM-DD HH:MM):"; read start
        echo "Write end:"; read end

        regex_control="^202[1234]-((1[0-2])|(0[1-9]))-((3[0-1])|([12][0-9])|(0[1-9])) ((2[0-3])|([01][0-9])):((60)|([0-5][0-9]))$"
        if [[ $start =~ $regex_control && $end =~ $regex_control ]]; then
            sudo find / -type f -newermt "$start" ! -newermt "$end" -delete 2> /dev/null
            sudo find / -type d -empty -newermt "$start" -delete 2> /dev/null
        else
            echo "Incorrectly or invalid input of date and time"; exit
        fi

    elif [[ $1 == 3 ]]; then
        echo "Write directory mask (in format "2-7 letters_DDMMYY"):"; read d_mask
        d_regex_control="^[a-z]{2,7}_((3[0-1])|([12][0-9])|(0[1-9]))((1[0-2])|(0[1-9]))2[1234]$"

        echo "Write file mask (in format "2-7 letters_DDMMYY.2-3 letters"):"; read f_mask
        f_regex_control="^[a-z]{2,7}_((3[0-1])|([12][0-9])|(0[1-9]))((1[0-2])|(0[1-9]))2[1234].[a-z]{2,3}$"

        if [[ $d_mask =~ $d_regex_control && $f_mask =~ $f_regex_control ]]; then
            d_letters=$(echo $d_mask | awk -F_ '{print $1}')
            d_date=$(echo $d_mask | awk -F_ '{print $2}')

            f_letters=$(echo $f_mask | awk -F_ '{print $1}')
            f_date=$(echo $f_mask | awk -F_ '{print $2}')

            d_regex=".*${d_letters:0:1}[$d_letters]+${d_letters:$(( ${#d_letters} - 1 )):1}_$d_date$"
            f_regex=".*${f_letters:0:1}[$f_letters]+${f_letters:$(( ${#f_letters} - 1 )):1}_$f_date$"

            sudo find / -type f -regex "$f_regex" -delete 2> /dev/null
            sudo find / -type d -empty -regex "$d_regex" -delete 2> /dev/null
        else
            echo "Incorrectly or invalid input of mask"; exit
        fi

    else
        echo "Parameter set incorrectly"; exit
    fi

    echo "Success"
    echo "Free space before clean $before"
    echo "Free space after clean $(df -h / | awk '/sda/{print $4}')"
fi