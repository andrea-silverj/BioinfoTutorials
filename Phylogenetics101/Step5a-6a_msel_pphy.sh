#!/bin/bash
working_directory="Analyses"


mkdir ${working_directory}/Trees
mkdir ${working_directory}/Trees/full_inference

iqtree2 -s ${working_directory}/Alignments/concatenated.fa -p ${working_directory}/Alignments/partitions.nexus -m MFP+MERGE -B 1000 -T AUTO --prefix ${working_directory}/Trees/full_inference/results
