#! /bin/bash

mkdir -p ../sarscov2/fastq
cd ../sarscov2

while read id; do
	fasterq-dump --progress --outdir fastq "$id"
done < ../../script/sraList.txt
