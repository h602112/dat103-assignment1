#!/usr/bin/bash
$1

#creates a temporary directory
tmp_dir=$(mktemp -d -t Lookups-XXXXXXXXX)

if ([[ $1 == "--bypass" ]]); then


	cat - | source depunctuate.sh $tmp_dir | source repunctuation.sh $tmp_dir 
else 
	cat - | source depunctuate.sh $tmp_dir | words-reverse-11 | source repunctuation.sh $tmp_dir
	exit
fi


rm -rf $tmp_dir

