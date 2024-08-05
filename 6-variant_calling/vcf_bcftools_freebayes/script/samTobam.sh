#! /bin/bash

mkdir -p ../sarscov2/bam
cd ../sarscov2/sam

for i in $(ls *.sam | rev | cut -c 5- | rev); do
	samtools view -uS -o ../bam/${i}.bam ${i}.sam
done
