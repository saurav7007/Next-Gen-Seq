#!/bin/bash

#Sars-Cov2 variant calling
#-------------------------
#1- download fastq files from the NCBI SRA database
mkdir -p ../sarscov2/fastq
while read f; do
	fasterq-dump --progress --outdir fastq "$f"
done < ids.txt

#2- download and extract the reference genome
mkdir ../ref
cd ../ref

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/009/858/895/GCF_009858895.2_ASM985889v3/GCF_009858895.2_ASM985889v3_genomic.fna.gz

#Extract the compressed the reference FASTA file
f=$(ls *.*)
gzip -d ${f}

#3- Index the reference FASTA file using samtools and bwa
f=$(ls *.*)
samtools faidx ${f}
bwa index ${f}

cd ..

#4- Align the fastq reads (multiple samples) to the reference genome
mkdir sarscov2/sam
cd sarscov2/fastq

for i in $(ls *.fastq | rev | cut -c 9- | rev | uniq); do
	bwa mem -M -t 4 \
	-R "@RG\tID:${i}\tSM:${i}" \
	../../ref/GCF_009858895.2_ASM985889v3_genomic.fna \
	${i}_1.fastq ${i}_2.fastq > \
	../sam/${i}.sam 2> ../sam/${i}.log;
done

cd ..

#5- convert SAM files into BAM files
mkdir bam
cd sam

for i in $(ls *.sam | rev | cut -c 5- | rev); do
	samtools view -uS -o ../bam/${i}.bam ${i}.sam
done

cd ..

#6- Sorting and indexing BAM files
#Sorting BAM files
mkdir sortedbam
cd bam

for i in $(ls *.bam); do
	samtools sort -T ../sortedbam/tmp.sort -o ../sortedbam/${i} ${i}
done

cd ..

#Indexing the sorted BAM files
cd sortedbam

for i in $(ls *.bam); do
	samtools index ${i}
done

cd ..

#7- Marking/removing duplicate alignments
mkdir dupRemBam
cd sortedbam

for i in $(ls *.bam); do
	samtools rmdup ${i} ../dupRemBam/${i} 2> ../dupRemBam/${i}.log
done

cd ..

#8- Alignment pileup and variant calling using bcftools
mkdir variants
cd dupRemBam

for i in $(ls *.bam); do
	samtools index ${i}
done

ls *.bam | rev | rev > bam_list.txt

bcftools mpileup -Ou \
-f ../ref/GCF_009858895.2_ASM985889v3_genomic.fna \
-b bam_list.txt \
| bcftools call -vmO z \
-o ../variants/sarscov2.vcf.gz

cd ..

#9- Index the VCF file
tabix variants/sarscov2.vcf.gz

#10- Filtering variants with QUAL less than 60 
bcftools filter -O z \
-o variants/filtered_sarscov2.vcf.gz \
-i '%QUAL>60' variants/sarscov2.vcf.gz

#11- To view contents
bcftools view variants/sarscov2.vcf.gz | less -S
