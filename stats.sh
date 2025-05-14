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


case $choice in 


   1)


   2)
    for col in $columns; do
      awk -v c="$col" '{freq[$c]++} END{for(val in freq){if(freq[val]>max){max=freq[val];mode=val}} print "Mode of column", c, "=", mode, "(", max, "times)"}' cleaned_data.txt
    done
    ;;


  3)
    for col in $columns; do
      awk -v c="$col" 'NR==1 {min=max=$c} {if($c<min)min=$c; if($c>max)max=$c} END{print "Column", c, "-> Min =", min, ", Max =", max}' cleaned_data.txt
    done
    ;;
    
  4)
    
    
  5)
    

  6)
  
  esac


