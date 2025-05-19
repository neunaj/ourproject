#!/bin/bash

read -p "please enter the name of the file (numbers only) " file

#if statement to ensure the file exist
if [ ! -f "$file" ]; then
   echo "file not found"
fi
# Filter lines with only integers 
# and remove leading/trailing spaces
grep -E '^[0-9]+([[:space:]]+[0-9]+)*$' "$file" | sed 's/^[ \t]*//;s/[ \t]*$//' > cleaned_data.txt


echo
echo "Choose a statistic to calculate:"
echo "1) Mean"
echo "2) Mode"
echo "3) Minimum and Maximum"
echo "4) Standard Deviation"
echo "5) Sum"
read -p "Enter choice [1-5]: " choice

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
  mean=$(awk "BEGIN {print $sum / $count}")
 mean         # calculate mean
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

    # use awk to calculate min and max using NR to initialize on first line
    awk -v c="$col" '
    {
        value = $c

        if (NR == 1) {
            # On the first line, initialize min and max
            min = value
            max = value
        } else {
            # Compare with current min and max
            if (value < min) {
                min = value
            }
            if (value > max) {
                max = value
            }
        }
    }

    END {
        # print the result after processing all lines
        print "Column", c, "=> Min =", min, ", Max =", max
    } ' cleaned_data.txt
    
done  # end of loop 

;;  # end of case option 3
    
 4)
     for col in $columns; do
    # Using awk to calculate the mean and standard deviation for the specified column
    awk -v c="$col" '
    { 
      sum += $c; 
      sumsq += ($c)^2; 
      count++ 
    }
    END {
      mean = sum / count;  
      stddev = sqrt(sumsq / count - mean^2);  # Calculate standard deviation
      printf "Standard Deviation of column %d = %.2f\n", c, stddev;  # Print result
    }' cleaned_data.txt  # Process the cleaned data file
  done
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
    
 
*)
    echo "Invalid choice"
    ;;
    
esac


