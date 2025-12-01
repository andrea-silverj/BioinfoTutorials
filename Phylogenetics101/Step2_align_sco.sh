#!/bin/bash

# Create folder for aligned sequences
mkdir Analyses/Alignments

# Set working directory
input_folder="Analyses/Orthofinder/Results_standard_run/Single_Copy_Orthologue_Sequences"
cd ${input_folder}

# Run MAFFT
for i in *.renamed.fa; do

	mafft --auto "$i" > "${i/.fa/.aln}"; 

done

# Move results to the right folder
mv *.aln ../../../Alignments
