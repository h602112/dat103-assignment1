#!/usr/bin/bash
path=$1

if [[ -d $1 ]]; then
	:	
else 
	exit
fi

VAR=""

for line in $(cat -)
do
	if [[ -e "$1/$line" ]];
	then 
		#replace line with contents of lookup file
		VAR+=$(<"$1/$line")
	else 
		VAR+="$line "
	fi
done

echo "$VAR" | sed -E 's/[[:space:]]([,.?!])/\1/g' | sed 's/, */, /g' | tr '|' '\n'
