#! /bin/bash

cd ../huChrom21
mkdir -p filteredVCF

gatk ApplyVQSR --java-options \ 
-Xmx4G \
-V vcf/allsamplesSNP_chr21.vcf \
-O filteredVCF/humanSNP.vcf \
--truth-sensitivity-filter-level 99.7 \
--tranches-file VQSR/vqsrplots.R \
--recal-file VQSR/tranches.out \
-mode SNP \
--create-output-variant-index true
