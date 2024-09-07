#!/bin/bash

mkdir -p ../huChrom21/dedup
cd ../huChrom21/chr21

for i in $(ls *.bam | rev | cut -c 5- | rev); do
	picard MarkDuplicates \
	INPUT="${i}.bam" \
	OUTPUT="../dedup/${i}.dedup.bam" \
        METRICS_FILE="../dedup/${i}.dedup_metrics.txt"
done

cd ../dedup

for i in $(ls *.bam); do
    samtools index ${i}
done
