#!/bin/bash

echo 'SSH Session Verifying...'

#for USER in $(last | awk -F" " '{print $1}' | sort | uniq)

for USER in $(last | grep -v "begins" | grep -v "boot" | awk -F" " '{print $1}' | sort | uniq)
do
	last | grep $USER | grep -v "System" | head -1 | awk -F " " '{print $1,$4,$5,$6,$7}' >> ./shellResult.txt

	done
