#! /bin/bash

mkdir ../sarscov2/dupRemBam
cd ../sarscov2/sortedbam

for i in $(ls *.bam); do
	samtools rmdup ${i} ../dupRemBam/${i} 2> ../dupRemBam/${i}.log
done
