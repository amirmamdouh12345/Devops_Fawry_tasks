#!/bin/bash

show_number=false
invert_match=false

#handle options  
while getopts "nv" opt; do
  case "$opt" in
    n)
      show_number=true
      ;;
    v)

      invert_match=true;
      ;;
    *)
      echo "Wrong option"
      exit 1
      ;;
  esac
done


# shift options 
shift $((OPTIND - 1))



filename=$1
word=$2


#input validation
if [[ -z $filename ]];then
	echo "You've missed to write a filename";
	exit 1;
fi

if [[ -z $word ]];then
	echo "You've missed to write a word for search";
	exit 1;
fi

if [[ ! -f $filename  ]];then
	echo "File $filename is not found";
	exit 1;
fi





#seach for words inside lines
line_number=0
while IFS= read -r line; do

   ((line_number=$line_number+1))

   if [[ "$line" == *"$word"* && $invert_match == false ]]; then             # not invert
	   if [[ $show_number == true  ]]; then
		   echo $line_number: $line
           else
      		   echo $line
	   fi 
   elif [[ "$line" != *"$word"* && $invert_match == true  ]]; then                                   # invert
           if [[ $show_number == true  ]]; then
                   echo $line_number: $line
           else
                   echo $line
           fi

	
   fi
done < "$filename"


