#!/bin/bash

# Set working directory
input_folder="Analyses/Alignments"
cd ${input_folder}

# Concatenate all alignments using AMAS
AMAS.py concat -i *trimmed.aln -y nexus -f fasta -d aa -p partitions.nexus -t concatenated.fa
