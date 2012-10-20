#!/bin/bash

# Progtest tester
# Can be used with downloadable sample data from progtest
# - files with names: *_(in|out).txt
#
# @author Jan Žák <zj@zakjan.cz>
# @license MIT

app_file=${1:-"main"} # application executable file
data_dir=${2:-"data"} # path to test data



echo "  Progtest tester"
echo "  $app_file"
echo "-----------------------------------"



# for each sample input file
for input in `ls $data_dir/*_in.txt`; do
	output="out.txt"
	output_ref=${input/in/out}

	echo -n "> Test $input: "

	# run!
	./$app_file < $input > $output

	# compare current and sample output
	log=`diff $output $output_ref`

	if [ "$log" == "" ]; then
		echo "OK"
	else
		echo "CHYBA"
		echo
		echo "> vstup:"
		cat $input
		echo
		echo "> výstup:"
		cat $output
		echo
		echo "> referenční výstup:"
		cat $output_ref
		echo
	fi

	rm out.txt
done
