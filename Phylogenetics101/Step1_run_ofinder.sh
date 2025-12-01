#!/bin/bash

# Run Orthofinder
orthofinder -f Data/ -o Analyses/Orthofinder -n standard_run

output_folder="Analyses/Orthofinder/Results_standard_run/Single_Copy_Orthologue_Sequences"

# Format output files
cd ${output_folder}

for i in OG*; do

	sed 's/>.*|/>/' "$i" > "${i/.fa/.renamed.fa}";

done

