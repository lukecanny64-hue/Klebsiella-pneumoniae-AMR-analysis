#!/bin/bash
set -e
set -u
set -o pipefail

while read accession || [ -n "$accession" ]; do
    #if [ ! -f results/amr/${accession}.tsv ]; then
        echo "Screening ${accession}"
        amrfinder -n results/assemblies/${accession}/contigs.fasta \
        --organism Klebsiella_pneumoniae --plus --print_node \
        -o results/amr/family/${accession}.tsv
    #fi
done < data/metadata/accessions.txt