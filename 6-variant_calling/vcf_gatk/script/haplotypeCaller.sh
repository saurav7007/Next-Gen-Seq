#! /bin/bash

mkdir -p ../huChrom21/gvcf
cd ../huChrom21/applyBQSR

ref=$(ls ../../refgenome/*.fasta)

for i in $(ls *.bam|rev|cut -c 5-|rev); do
    	gatk HaplotypeCaller --java-options \
    	-Xmx16g \
    	-I ${i}.bam \
    	-R ${ref} \
    	-L chr21 \
    	-ERC GVCF \
    	-O ../gvcf/${i}.g.vcf.gz
done
