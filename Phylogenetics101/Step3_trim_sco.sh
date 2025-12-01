#!/bin/bash

# Set working directory
input_folder="Analyses/Alignments"
cd ${input_folder}

# Run TrimAl
for i in *aln; do

    trimal -gappyout -in "$i" -out "${i/.aln/.trimmed.aln}";

done
