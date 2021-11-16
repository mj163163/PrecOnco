# PrecOnco
Title: Gene expression based inference of drug resistance in cancer.

![Workflow](Workflow.png)

This resource provides code to reproduce key results in the manuscript: Gene expression based inference of drug resistance in cancer.

Getting started

1. Download Github repository

   git clone https://github.com/SmritiChawla/PrecOnco.git

2. Packages required

   Packages: keras, caret, ggpubr, GSEABase, GSVA, impute, tidyverse, pheatmap, ggplot2, ggridges, reshape2, umap, RColorBrewer, data.table, h2o, survival, survminer, readxl,  Polychrome, circlize, corrplot, tibble, scales

3. Use R script EnvSet.R provided in the directory EnvironmentSetup to setup environment in R for loading python trained deep neural network models 

4. Run individual codes from the figure wise directories for reproducing manuscript results.

Description

1. Fig1: This folder contains codes used for evaluating our CCLE bulk RNA-seq model and contains following subdirectories:
Fig1c: This folder contains CCLE-GDSC2 dataset trained models and test dataset used for evaluating deep neural network model.
Fig1d: This folder contains CCLE-GDSC2 dataset trained models, processed Kinker, G. S. et al. scRNA-seq dataset and ground truth labels for evaluation of deep neural network model.
Fig1e: This folder contains code for assessing the efficiency of our model on Lee et al scRNA-seq profiles of MDA-MB-231 breast cancer cells. DrugsPred.R function is used for making predictions. This function takes 3 files as input: enrichment scores computed used GSVA method, metadata file containing information about cell lines and drugs along with molecular descriptors and CancerType for the input test dataset. For Lee et al we have specified BRCA as a cancer type.

2. Fig2: This directory contains codes for evaluation of deep neural network model on prostate cancer cell line dataset. The GSVA scores for untreated prostate cancer cell line and treated LNCaP cell lines are provided for drug response prediction. We have used PRAD as a cancer type for predictions. 

3. Fig3: This directory contains codes for reproducing results for LNCaP derived xenografts datasets. We have included predictions for 155 drugs for 54 samples and GSVA scores.

4. Fig4. This directory contains codes for evaluation of model trained on TCGA patient RNA-seq bulk profiles.
Fig4a folder contains script and data used for training AutoML models.
Fig4b folder contains predictions obtianed on TCGA test dataset using best AutoML model and code for computing survival on these predictions.
Fig4d-f folder contains codes for evaluating our model using external Wagle, Nikhil, et al. dataset. For drug response prediction we have used SKCM as a cancer type.

5. Supplementary directory contains codes for reproducing supplementary figures. 

Some notes

1. For training CCLE-GDSC based models, we have used python Kerastraining.py script provided in the directory Modeltraining. Unzip Training_data_CCLE_GDSC.zip file for usage.

2. All the necessary files and data to run figure wise codes are provided in individual directories. Once the enviroment for loading python models is set, user does not have to configure again. Rscript in the directories can be directly used.
