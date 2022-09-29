#!/usr/bin/bash
path=$1

#check if directory actually exists, exit if not.
if [[ -d $1 ]]; then
	:
else
	echo "Directory does not exist"
	exit
fi

for line in $(cat - | tr '\n' '|' | sed 's/[^[:alnum:]][^[:alnum:]]*/\n&\n/g')
do

	#if line is not a punctuation then print the line
	if [[ "$line" =~ [[:alnum:]] ]]; then
		echo $line
	#else create a hash value of the punctuation string and output it.
	else 
		sha=$(echo -n $line | sha256sum | cut -d ' ' -f 1)
		echo $sha
		# check if hash value exists as file in directory, otherwise 
		# create a new file
		

		if $(cmp -s "$sha" "$1/$sha"); then
		continue 1	
		else 
			printf "$line" > "$1/$sha"
		fi
	fi
done
