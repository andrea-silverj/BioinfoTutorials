#!/bin/bash

start_directory=$(pwd)
working_directory="Analyses"

mkdir  ${working_directory}/Trees/two-steps_inference/raxml_trees

# Run RAxML
raxmlHPC-PTHREADS-SSE3 -s ${start_directory}/${working_directory}/Alignments/concatenated.fa -n mosquitoes_trimmed.tre -m PROTGAMMALG -T 10 -p 12345 -x 67890 -# 100 -f a -w ${start_directory}/${working_directory}/Trees/two-steps_inference/raxml_trees
