#!/bin/bash
set -e
set -u
set -o pipefail

while read accession; do
    if [ ! -f data/raw/${accession}_1.fastq ]; then
        echo "Downloading ${accession}"
        prefetch "$accession" -O data/sra
        fasterq-dump "$accession" -O data/raw
    fi
done < data/metadata/accessions.txt