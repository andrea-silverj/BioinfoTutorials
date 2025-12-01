# Phylogenetics 101
This tutorial is based on a phylogenetics workshop I lead with other colleagues in 2023 ([ITAPHY2023](https://github.com/itaphyworkshop/itaphy2023)).

## Environment and Dataset preparation

### System: Protein set coming from 4 Diptera species

*Anopheles stephensi* ([Aste](https://en.wikipedia.org/wiki/Anopheles_stephensi).)  
*Aedes aegypti* ([Aaeg](https://it.wikipedia.org/wiki/Aedes_aegypti).)  
*Culex quinquefasciatus* ([Cqui](https://en.wikipedia.org/wiki/Culex_quinquefasciatus).)  
*Lutzomyia longipalpis* ([Llon](https://en.wikipedia.org/wiki/Lutzomyia_longipalpis).)  

### Prepare working environment with conda

Install required programs using conda, clone the repo and create a meaningfull directory structure.

```
conda create --name phylogen101 python=3.8
conda activate phylogen101
conda install -c bioconda mafft trimal amas iqtree=2 raxml=8

    or

conda create -f phylogen101.yml

wget https://github.com/davidemms/OrthoFinder/releases/download/2.5.1/OrthoFinder.tar.gz
tar -xzvf OrthoFinder.tar.gz
chmod 777 -R OrthoFinder
cd OrthoFinder
./orthofinder --help
export PATH=$PATH:$(pwd)
cd ..

git clone https://github.com/andrea-silverj/BioinfoTutorials.git
cd BioinfoTutorials/Phylogenetics101
mkdir Analyses
chmod -R 777 *
```

## Phylogenetic inference under a maximum likelihood (ML) framework

### Easy pipeline:

1. Identify orthologous genes.
2. Align genes.
3. Trim alignments (optional).
4. Concatenate single-genes alignments.
5. Model selection.
6. Tree inference.

#### 1. Identify orthologous genes ([Orthofinder](https://github.com/davidemms/OrthoFinder))

Run Orthofinder:

```
orthofinder -f Data/ -o ./OrthofinderResults
```

**NB:** This is just a basic usage of Orthofinder. The program has a lot of parameters and gives a lot of different options to customize the analysis: take a look at the help!

Rename fasta headers to keep only species name (necessary for concatenation)

```
for i in Analyses/Orthofinder/Single_Copy_Orthologue_Sequences/OG00000*; do 
    sed 's/>.*|/>/' "$i" > "${i/.fa/.renamed.fa}"; 
done
```

#### 2. Align genes ([MAFFT](https://mafft.cbrc.jp/alignment/server/))

Align single-copy orthologous genes

```
for i in Analyses/Orthofinder/Single_Copy_Orthologue_Sequences/*.renamed.fa; do 
    mafft --auto "$i" > "${i/.fa/.mafft}"; 
done
```

Move mafft results in the correct directory.

```
mv Analyses/Orthofinder/Single_Copy_Orthologue_Sequences/*.aln Analyses/Alignments/
```

#### 3. Trim alignments ([TrimAl](http://trimal.cgenomics.org/trimal))

Trimal in -gappyout mode will remove columns of the alignments based on gaps' distribution.

```
for i in Analyses/Alignments/*aln; do 
    trimal -gappyout -in "$i" -out "${i/.aln/.trimmed.aln}"; 
done
```
#### 4. Concatenate single-genes alignments ([AMAS]([http://trimal.cgenomics.org/trimal](https://github.com/marekborowiec/AMAS)))

```
AMAS.py concat -i Analyses/Alignments/*trimmed.aln -y nexus -f fasta -d aa -p Analyses/Alignments/partitions.nexus -t Analyses/Alignments/concatenated.fa
```

#### 5a & 6a. Model selection + Tree Inference (combined approach) ([IQTREE (Model Selection and Tree Inference)](http://www.iqtree.org/))
```
iqtree2 -s Analyses/Aln/Concat.fa -p Analyses/Aln/Partitions.nexus -m MFP+MERGE -B 1000 --prefix Analyses/Species_Tree/ML_TreeInference

```
Where: 
* ```-s```: Alignment file
* ```-m MFP+MERGE```: Best-fit partitioning scheme search considering FreeRate heterogeneity model

*Don't esitate to use other ML software (e.g. RAxML)*

#### 5b. Model selection ([IQTREE (Model Selection)](http://www.iqtree.org/))
```
iqtree2 -T AUTO -m TESTONLY

```

#### 6b. Tree inference ([RAxML (Tree Inference)](http://www.iqtree.org/))
```
raxmlHPC-PTHREADS-SSE3 -s _trimmed.aln -n narnaviridae_trimmed -m PROTGAMMALG -T 10 -p 12345 -x 67890 -# 100 -f a -w output_folder

```
*If unsure about the model (or your model is not implemented in RAxML), set -m to PROTGAMMAAUTO*
