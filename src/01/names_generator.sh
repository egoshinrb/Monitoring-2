#!/bin/bash

MAX_SYMBOLS=$1
d_name=$2

# заполняем массив с количеством символов = в сумме не более MAX_SYMBOLS символов
length=0
free=$(($MAX_SYMBOLS + 1 - ${#d_name})) # количество свободных символов
for ((j = 0; j < ${#d_name}; ++j)); do # записываем количество каждой буквы
    array_count[$j]=$(($RANDOM%$free + 1)) # количество этой буквы
    free=$(( $free - ${array_count[$j]} + 1 )) # остаток для следующих букв
    length=$(( $length + ${array_count[$j]} )) # считаем длину
done

name=""
for ((j = 0; j < ${#d_name}; ++j)); do # формируем первую часть имени
    for ((k = 0; k < ${array_count[j]}; ++k)); do
        name+=${d_name:$j:1}
    done
done

echo $name