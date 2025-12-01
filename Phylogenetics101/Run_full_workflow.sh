#!/bin/sh

# 1) Identify orthologues genes with Orthofinder
./Step1_run_ofinder.sh
echo "Step 1 COMPLETED"

# 2) Align genes with MAFFT
./Step2_align_sco.sh
echo "Step 2 COMPLETED"

# 3) Trim alignments with TrimAl
./Step3_trim_sco.sh
echo "Step 3 COMPLETED"

# 4) Concatenate single-genes alignments with AMAS
./Step4_concat_sco.sh
echo "Step 4 COMPLETED"

# 5a & 6a) Model selection + Tree Inference (combined approach) with IQTREE2
./Step5a-6a_msel_pphy.sh
echo "Steps 5a and 6a COMPLETED"

# 5b) Model selection with IQTREE2
./Step5b_msel.sh
echo "Step 5b COMPLETED"

# 6b) Tree inference with RAxML
./Step6b_phy.sh
echo "Step 6b COMPLETED"
