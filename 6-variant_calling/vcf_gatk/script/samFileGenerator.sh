#! /bin/bash

mkdir ../huChrom21/sam
cd ../huChrom21/fastq

ref=$(ls ../../refgenome/*.fasta)

for i in $(ls *.fastq | rev | cut -c 13- | rev); do
    	bwa mem -M -t 8 \
    	-R "@RG\tID:${i}\tSM:${i}" \
    	${ref} \
    	${i}_chr21.fastq > \
    	../sam/${i}_chr21.sam 2> ../sam/${i}_chr21.log;
done
