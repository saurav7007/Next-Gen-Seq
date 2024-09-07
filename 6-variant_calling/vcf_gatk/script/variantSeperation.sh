#! /bin/bash

cd ../huChrom21

#SNPS
gatk SelectVariants --java-options \
-Xmx10g \
-V vcf/allsamples_chr21.vcf \
-select-type SNP \
-O vcf/allsamplesSNP_chr21.vcf

#INDEL
gatk SelectVariants --java-options \
-Xmx4g \
-V vcf/allsamples_chr21.vcf \
-select-type INDEL \
-O vcf/allsamplesIndels_chr21.vcf
