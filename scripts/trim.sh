#!/bin/bash
set -e
set -u
set -o pipefail

adap=${CONDA_PREFIX}/share/trimmomatic-0.41-0/adapters

while read accession; do
    if [ ! -f results/trimmed/${accession}_1_paired.fastq ]; then
        echo "Processing $accession"
        trimmomatic PE -threads 1 -phred33 -summary data/metadata/trim_stats/${accession}statsSummaryFile \
        data/raw/${accession}_1.fastq data/raw/${accession}_2.fastq \
        results/trimmed/${accession}_1_paired.fastq results/trimmed/${accession}_1_unpaired.fastq \
        results/trimmed/${accession}_2_paired.fastq results/trimmed/${accession}_2_unpaired.fastq \
        ILLUMINACLIP:$adap/TruSeq3-PE-2.fa:2:30:10 SLIDINGWINDOW:4:15 MINLEN:36
    fi
done < data/metadata/accessions.txt