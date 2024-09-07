#! /bin/bash

mkdir ../huChrom21/bam
cd ../huChrom21/sam

for i in $(ls *.sam | rev | cut -c 5- | rev); do
	samtools view -uS -o ../bam/${i}.bam ${i}.sam
done
