#!/bin/bash

if [[ $# != 1 ]]; then
    echo "Parameter not are entered"
else
    if [[ $1 == 1 ]]; then
        sort -k 9,9n file_*.log
    elif [[ $1 == 2 ]]; then
        sort -u -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n file_*.log
    elif [[ $1 == 3 ]]; then
        awk '$9~/[45]0[01234]/{print $0}' file_*.log | sort -k 9,9n
    elif [[ $1 == 4 ]]; then
        awk '$9~/[45]0[01234]/{print $0}' file_*.log | sort -u -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n
    fi
fi