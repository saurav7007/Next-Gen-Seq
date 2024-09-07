#! /bin/bash

cd ../huChrom21
mkdir -p tmp
echo "chr21" > chr21.interval_list

#create a database
ref=$(ls ../refgenome/*.fasta)

gatk GenomicsDBImport --java-options \
-Xmx16g \
-R ${ref} \
--genomicsdb-workspace-path gvcf21db \
--batch-size 50 \
--sample-name-map cohort.sample_map \
-L chr21.interval_list \
--tmp-dir tmp \
--reader-threads 8

rm -r tmp

mkdir -p vcf

gatk GenotypeGVCFs --java-options \
-Xmx16g \
-R ${ref} \
-V gendb://gvcf21db \
-O vcf/allsamples_chr21.vcf
