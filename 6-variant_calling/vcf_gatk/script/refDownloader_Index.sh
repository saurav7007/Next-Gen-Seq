#! bin/bash

mkdir -p ../refgenome
cd ../refgenome

# Download Reference and its dictionary from GATK
wget https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta
wget https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dict

#Create a fasta dict for reference
f=$(ls *.fasta)
samtools faidx ${f}
bwa index ${f}
