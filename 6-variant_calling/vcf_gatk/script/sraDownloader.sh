#! /bin/bash

mkdir -p ../huChrom21/fastq
cd ../huChrom21/fastq

while read id; do
	sam-dump \
	--verbose \
	--fastq \
	--aligned-region chr21 \
	--output-file ${id}_chr21.fastq \
	${id}; \
done < ../script/sraList.txt
