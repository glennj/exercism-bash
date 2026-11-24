#!/usr/bin/env bash

file=$1
pattern=$2
note=$3

# Task 1
echo "Looking at \"${file}\""

# Task 2
cat "$file"

# Task 3
# shellcheck disable=SC2016
echo 'Careful: rm * deletes everything and $HOME is your home directory'

# Task 4
echo "Pattern: ${pattern}"
# Deliberately unquoted, to show the shell expanding the pattern.
# shellcheck disable=SC2086
printf '%s\n' $pattern

# Task 5
echo "Note: ${note}"
