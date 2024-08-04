#! /bin/bash

mkdir ../sarscov2/variants
cd ../sarscov2/dupRemBam

ls *.bam | rev | rev > bam_list.txt

bcftools mpileup -Ou \
-f ../../ref/GCF_009858895.2_ASM985889v3_genomic.fna \
-b bam_list.txt \
| bcftools call -vmO z \
-o ../variants/sarscov2.vcf.gz

bcftools filter -O z \
-o ../variants/filtered_sarscov2.vcf.gz \
-i '%QUAL>60' ../variants/sarscov2.vcf.gz
