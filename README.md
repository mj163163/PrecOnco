# PrecOnco
Title: Gene expression based inference of drug resistance in cancer

This resource provides code to reproduce key results in the manuscript: Gene expression based inference of drug resistance in cancer.

Getting started

1. Download Github repository

   git clone https://github.com/SmritiChawla/PrecOnco.git

2. Packages required

   Packages: keras, caret, ggpubr, GSEABase, GSVA, impute, tidyverse, pheatmap, ggplot2, ggridges, reshape2, umap, RColorBrewer, data.table, h2o, survival, survminer, readxl,  Polychrome, circlize, corrplot, tibble, scales

2. Setup environment in R to load models trained in python using keras platform by using R script EnvSet.R provided in the directory EnvironmentSetup.

3. Run individual codes from the figure wise directories.

Some notes

1. For training CCLE-GDSC based models, we have used python Kerastraining.py script provided in the directory Modeltraining. Unzip Training_data_CCLE_GDSC.zip file for usage.

2. All the necessary files and data to run figure wise codes are provided in individual directories. Once the enviroment for loading python models is set, user does not have to configure again. Rscript in the directories can be directly used.
