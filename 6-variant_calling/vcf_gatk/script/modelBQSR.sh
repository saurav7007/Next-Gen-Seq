#! /bin/bash

mkdir -p ../huChrom21/refvcf

cd ../huChrom21/refvcf

wget https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/1000G_phase1.snps.high_confidence.hg38.vcf.gz
wget https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/1000G_phase1.snps.high_confidence.hg38.vcf.gz.tbi
wget https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.known_indels.vcf.gz
wget https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.known_indels.vcf.gz.tbi

cd ..
##B- Build the BQSR model
#------------------------
# Create directory for BQSR output
mkdir -p BQSR

cd RG
ref=$(ls ../../refgenome/*.fasta)

# Step 1: Base Quality Score Recalibration (BQSR)
for i in $(ls *.bam | rev | cut -c 5- | rev); do
    	gatk BaseRecalibrator --java-options \
    	-Xmx8g \
    	-I ${i}.bam \
    	-R ${ref} \
    	--known-sites ../refvcf/1000G_phase1.snps.high_confidence.hg38.vcf.gz \
    	--known-sites ../refvcf/Homo_sapiens_assembly38.known_indels.vcf.gz \
    	-O ../BQSR/${i}.table
done

# Create directory for applying BQSR output
mkdir -p ../applyBQSR

ref=$(ls ../../refgenome/*.fasta)

# Step 2: Apply BQSR
for i in $(ls *.bam | rev | cut -c 5- | rev); do
    	gatk ApplyBQSR --java-options \
    	-Xmx8g \
    	-I ${i}.bam \
    	-R ${ref} \
    	--bqsr-recal-file ../BQSR/${i}.table \
    	-O ../applyBQSR/${i}.bqsr.bam
done
