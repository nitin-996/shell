#!/bin/bash


var="nitin"

# const variable
readonly dev="aws"
echo "$dev"

<<comment
multiline comment
The $(ls -lh) syntax is used for command substitution, which captures the output of the ls -lh command and assigns it to the variable la.
 However, when you echo the value of la, it will not preserve the line breaks in the output.
If you want to maintain the formatting, consider using double quotes around $la (echo "$la").
comment

la=$(ls -lh)

echo "$la"