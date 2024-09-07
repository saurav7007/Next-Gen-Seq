#! /bin/bash

cd ../huChrom21/gvcf

ls *_chr21.dedup.RG.bqsr.g.vcf.gz | awk -F '_' '{print $1 "\t" $1 "_chr21.dedup.RG.bqsr.g.vcf.gz"}' > ../cohort.sample_map
