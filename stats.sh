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
  for col in $columns;
  do         # loop through each column
  sum=0                         
  count=0                       
  while read line;
  do                            # read each line from file
    number=$(echo "$line" | awk -v c=$col '{print $c}')  # get value from column
    sum=$((sum + number))       # add value to sum
    count=$((count + 1))        # increase count
  done < cleaned_data.txt       # read from cleaned file
  mean=$((sum / count))         # calculate mean
  echo "Mean of column $col = $mean"  
done                           
;;                              # end of case

2)
      # loop through each column 
for col in $columns; do
# use awk to calculate the mode for the specified column
  awk -v c="$col" '
  {
    # increment the frequency count for the value in column c
        freq[$c]++     
  }
  END {
        # variable to store the mode
          mode = ""     
        # variable to store the highest frequency
           max = 0        

    # loop through all values to find the one with the highest frequency
        for (v in freq) {
          if (freq[v] > max) {
           # update the highest frequency
              max = freq[v]   
           # update the mode
              mode = v        
      }
    }
    # print the result: column number, mode value, and number of times it repeated
    print "Mode of column " c " = " mode " (occurred " max " times)"
  }' cleaned_data.txt  # read from the cleaned data file

done # end of loop 
    ;; # end of case option 2
    
    
 3)   
    # loop through each column 
for col in $columns; do
    min=   # initialize variable to store the minimum value
    max=   # initialize variable to store the maximum value

    # read each line from the file cleaned_data.txt
    while read line; do
        # extract the value from the current column using awk
        number=$(echo "$line" | awk -v c="$col" '{print $c}')
        # check if min is empty or the current number is less than min
        if [[ -z "$min" || "$number" < "$min" ]]; then
            min=$number  # update min with the current number
        fi
        # check if max is empty or the current number is greater than max
        if [[ -z "$max" || "$number" > "$max" ]]; then
            max=$number  # update max with the current number
        fi
    done < cleaned_data.txt  # read from cleaned file
    # print the result
    echo "Column $col => Min = $min , Max = $max"
done  # end of loop 

;;  # end of case option 3
    
 4)
    ;;
    
 5)
    for col in $columns; do       # loop through columns
      sum=0                       # start sum at 0
      while read line; do         # read each line
        number=$(echo "$line" | awk -v c=$col '{print $c}')  # get column value
        sum=$((sum + number))     # add to sum
      done < cleaned_data.txt     # read from cleaned file
      echo "Sum of column $col = $sum"  # show result
    done
    ;;
    
 6)
    ;;
*)
    echo "Invalid choice"
    ;;
    
esac


