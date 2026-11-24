#!/usr/bin/env bash

# `expr` is an external command that does simple arithmetic.
# Bash has a builtin way to do this, which a later concept will cover.
# shellcheck disable=SC2003

kind=$1
option1=$2
option2=$3
original_price=$4
age=$5

# Task 1
if [[ $kind == "car" || $kind == "truck" ]]; then
    echo "License needed for ${kind}: yes"
else
    echo "License needed for ${kind}: no"
fi

# Task 2
if [[ $option1 < $option2 ]]; then
    choice=$option1
else
    choice=$option2
fi
echo "${choice} is clearly the better choice."

# Task 3
if [[ $age -lt 3 ]]; then
    percentage=80
elif [[ $age -gt 10 ]]; then
    percentage=50
else
    percentage=70
fi
price=$(expr "$original_price" '*' "$percentage" / 100)
echo "Estimated price: ${price}"
