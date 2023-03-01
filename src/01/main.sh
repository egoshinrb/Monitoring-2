#!/bin/bash

if [[ $# != 6 ]]; then
    echo "Not all parameters are entered or superfluous"
else
    sudo chmod +x ./check_parameter.sh ./create_dirs.sh ./create_files.sh ./names_generator.sh
    error=$(./check_parameter.sh $1 $2 $3 $4 $5 $6)
    if [[ $error == "Success" ]]; then
        ./create_dirs.sh $1 $2 $3 $4 $5 $6
    else
        echo $error
    fi
fi