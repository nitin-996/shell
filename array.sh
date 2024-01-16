#!/bin/bash


# in other language you can store same data type but in shell you can store multi data type in array. 
array=(1 2 4 "demo" 5 "dollar")


echo ${array[@]}

# how to find the length of array

echo ${#array[@]}


<<comment

{array[@]:starting index:how many value u want from array }
comment
echo " values from index 2-4 ${array[*]:2:5}"

# Associative array
declare -A fruit_colors
fruit_colors=([apple]="red" [banana]="yellow" [orange]="orange")


# Accessing elements
echo "${fruit_colors[banana]}"  # Outputs: yellow