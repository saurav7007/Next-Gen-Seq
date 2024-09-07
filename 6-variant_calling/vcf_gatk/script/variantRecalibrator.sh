#! /bin/bash

cd ../huChrom21/refvcf

#wget https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf
#wget https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf.idx

cd ..

mkdir -p VQSR

cd vcf

gatk VariantRecalibrator --java-options \
-Xmx10g \
-R ../refgenome/Homo_sapiens_assembly38.fasta \
-V allsamplesSNP_chr21.vcf \
--trust-all-polymorphic \
-tranche 100.0 \
-tranche 99.95 \
-tranche 99.90 \
-tranche 99.85 \
-tranche 99.80 \
-tranche 99.00 \
-tranche 98.00 \
-tranche 97.00 \
-tranche 90.00 \
--max-gaussians 6 \
-resource:1000G_phase1_snps,known=false,training=true,truth=true,prior=10.0 ../refvcf/1000G_phase1.snps.high_confidence.hg38.vcf.gz \
--resource:dbsnp,known=true,training=false,truth=false,prior=2.0 ../refvcf/Homo_sapiens_assembly38.dbsnp138.vcf \
-an QD -an MQ -an MQRankSum \
-an ReadPosRankSum -an FS -an SOR \
-mode SNP \
-O ../VQSR/tranches.out \
--tranches-file ../VQSR/vqsrplots.R
