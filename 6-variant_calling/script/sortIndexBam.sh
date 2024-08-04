#! /bin/bash

mkdir ../sarscov2/sortedbam
cd ../sarscov2/bam

for i in $(ls *.bam); do
	samtools sort -T ../sortedbam/tmp.sort -o ../sortedbam/${i} ${i}
done

cd ../sortedbam

for i in $(ls *.bam); do
	samtools index ${i}
done
