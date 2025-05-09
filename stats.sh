#!/bin/bash

read -p "please enter the name of the file (numbers only) " file

#if statement to ensure the file exist
if [ ! -f "$file" ]; then
   echo "file not found"
fi

grep -E '^([0-9]*\.[0-9]+|[0-9]+)$' "$file" | sed 's/^[ \t]*//;s/[ \t]*$//' > cleaned_data.txt

echo
echo "Choose a statistic to calculate:"
echo "1) Mean"
echo "2) Mode"
echo "3) Minimum and Maximum"
echo "4) Standard Deviation"
echo "5) Sum"
echo "6) All Statistics"
read -p "Enter choice [1-6]: " choice

read -p "Which column numbers? (e.g., 1 2 3): " columns



