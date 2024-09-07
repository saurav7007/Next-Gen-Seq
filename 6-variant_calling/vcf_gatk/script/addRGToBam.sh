#! /bin/bash

mkdir -p ../huChrom21/RG

cd ../huChrom21/dedup

for i in $(ls *.bam | rev | cut -c 5- | rev); do
	picard AddOrReplaceReadGroups \
	INPUT="${i}.bam" \
	OUTPUT="../RG/${i}.RG.bam" \
	RGID="${i}" \
	RGLB="lib" \
	RGPL="ILLUMINA" \
	SORT_ORDER="coordinate" \
	RGPU="bar1" \
	RGSM="${i}"
done

cd ../RG

for i in *.bam; do
	samtools index "${i}"
done
