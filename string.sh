#!/bin/bash

myVar="Hey This is the first shell program"

echo "to convert lower case use comma sign , = ${myVar,,}"
echo "to convert upper case use caret sigh ^ = ${myVar^^}"


# to replace a string

#  ${variablename/word/replace word} 
#shell bashshell se replace hoga.
newVar=${myVar/shell/BASHshell}

echo "${newVar}"

#slice in string

echo "${newVar:21:10}"