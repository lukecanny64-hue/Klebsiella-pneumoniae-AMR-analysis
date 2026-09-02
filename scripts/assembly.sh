#!/bin/bash

set -e
set -u
set -o pipefail


while read accession; do
    if [ ! -f results/assemblies/${accession}/contigs.fasta ]; then 
        echo "Assembling ${accession}"
        spades.py --isolate \
            -1 results/trimmed/${accession}_1_paired.fastq \
            -2 results/trimmed/${accession}_2_paired.fastq \
            -o results/assemblies/${accession}
    fi
done < data/metadata/accessions.txt
