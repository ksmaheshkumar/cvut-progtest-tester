#!/bin/bash

# Progtest tester
# - executes your application multiple times against sample input data and
# compares its output with correct output
# - used sample data files should be named *_(in|out).txt
#
# Usage example:
# ./progtest.sh [application_filename [directory_with_test_data]]
#
# @author Jan Žák <zj@zakjan.cz>
# @license MIT

app_file=${1:-"main"}
data_dir=${2:-"data"}



# for each sample input file
for input in `ls $data_dir/*_in.txt`; do
	output="out.txt"
	output_ref=${input/_in/_out}

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
