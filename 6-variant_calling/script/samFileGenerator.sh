#! /bin/bash

mkdir ../sarscov2/sam
cd ../sarscov2/fastq

for i in $(ls *.fastq | rev | cut -c 9- | rev | uniq); do
	bwa mem -M -t 4 \
	-R "@RG\tID:${i}\tSM:${i}" \
	../../ref/GCF_009858895.2_ASM985889v3_genomic.fna \
	${i}_1.fastq ${i}_2.fastq > \
	../sam/${i}.sam 2> ../sam/${i}.log;
done
