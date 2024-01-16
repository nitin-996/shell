#!/bin/bash

x=7
y=5

# use (()) double parenthesis for calculation

echo "this is addition $(($x+$y))"
echo "this is addition $(("$x"*"$y"))"
echo "this is addition $(("$x"-"$y"))"