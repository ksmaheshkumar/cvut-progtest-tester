#!/bin/bash

# Progtest tester
# @author Jan Žák <zj@zakjan.cz>
# @license MIT

app_file="main" # application executable file
data_dir="data" # path to test data

echo "  Progtest tester"
echo "  $app_file"
echo "-----------------------------------"
for input in `ls $data_dir/*_in.txt`; do
	output="out.txt"
	output_ref="${input/in/out}"

	echo -n "> Test $input: "
	./$app_file < $input > $output
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
