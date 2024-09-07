#! /bin/bash

mkdir ../huChrom21/chr21
cd ../huChrom21/sortedbam

for i in $(ls *.bam|rev|cut -c 5-|rev); do
	samtools view -b ${i}.bam chr21 > ../chr21/${i}.bam
done

cd ../chr21

for i in $(ls *.bam); do
	samtools index ${i}
done
