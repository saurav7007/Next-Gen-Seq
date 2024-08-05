#! /bin/bash

cd ../ref

f=$(ls *.*)
samtools faidx ${f}
bwa index ${f}
