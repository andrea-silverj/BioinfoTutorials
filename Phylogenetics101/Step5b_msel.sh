#!/bin/bash
working_directory="Analyses"


mkdir ${working_directory}/Trees/two-steps_inference
mkdir ${working_directory}/Trees/two-steps_inference/model_selection

iqtree2 -s ${working_directory}/Alignments/concatenated.fa -m TESTONLY -T AUTO --prefix ${working_directory}/Trees/two-steps_inference/model_selection/results
