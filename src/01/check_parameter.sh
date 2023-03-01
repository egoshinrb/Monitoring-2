#!/bin/bash

if [[ !("$1" =~ ^[.]?[.]?/.*[^/]?$) ]]; then
    echo "Path set incorrectly - set path in format \"/folder\""
elif [[ !(-d $1) ]]; then
    echo "No such directory"
elif [[ "$1" =~ .*(s)?bin(.)* ]]; then
    echo "In this directory you cannot create new directories"
elif [[ $(df -h / | awk '/[0-9]*.[0-9]G/{print $4}') =~ ^(1.0G)|(0.[0-9]G)|([0-9]+M)$ ]]; then
    echo "Sorry, only 1.0G remains available"
elif [[ !("$2" =~ ^[1-9][0-9]*$) ]]; then
    echo "Count directories parameter must be an integer and greater than zero"
elif [[ !("$3" =~ ^[a-zA-Z]{2,7}$) ]]; then
    echo "Name directories parameter should contain only letters (from 2 to 7)"
elif [[ !("$4" =~ ^[1-9][0-9]*$) ]]; then
    echo "Count files parameter must be an integer and greater than zero"
elif [[ !("$5" =~ ^[a-zA-Z]{2,7}\.[a-zA-Z]{2,3}$) ]]; then
    echo "Name files parameter should contain only letters and one point (from 2 to 7 for the name and from 2 to 3 for the extension)"
elif [[ !("$6" =~ ^((100)|([1-9][0-9]([.][1-9])?)|([1-9]([.][1-9])?)|([0][.][1-9]))(kb|KB|mb|MB)$) ]]; then
    echo "Size files parameter should contain only a number with one decimal place, kb or KB"
else
    count_3=${#3}
    for ((i = 0 ; i < $(($count_3 - 1)) ; ++i)); do
        for ((j = $(($i + 1)) ; j < $(($count_3)) ;  ++j)); do
            if [[ ${3:$i:1} == ${3:$j:1} ]]; then
                echo "Identical letters in the name directories parameter"
                exit
            fi
        done
    done

    str_5_1=$(echo -n "${5}" | awk -F. '{print $1}')
    count_5_1=${#str_5_1}
    for ((i = 0 ; i < $(($count_5_1 - 1)) ; ++i)); do
        for ((j = $(($i + 1)) ; j < $(($count_5_1)) ;  ++j)); do
            if [[ ${str_5_1:$i:1} == ${str_5_1:$j:1} ]]; then
                echo "Identical letters in the name files parameter"
                exit
            fi
        done
    done

    str_5_2=$(echo -n "${5}" | awk -F. '{print $2}')
    count_5_2=${#str_5_2}
    for ((i = 0 ; i < $(($count_5_2 - 1)) ; ++i)); do
        for ((j = $(($i + 1)) ; j < $(($count_5_2)) ;  ++j)); do
            if [[ ${str_5_2:$i:1} == ${str_5_2:$j:1} ]]; then
                echo "Identical letters in the extension files parameter"
                exit
            fi
        done 
    done

    echo "Success"
fi