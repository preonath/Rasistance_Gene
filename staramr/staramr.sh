#!/bin/bash

# Input fasta file
fasta_file=$1

# Run STARAMR
staramr predict -i $fasta_file -o output_folder

# Extract antibiotic resistance genes
grep -o "^.*resistance" output_folder/staramr_results.tsv | awk '{print $1}' > resistance_genes.txt

# Clean up
rm -rf output_folder

