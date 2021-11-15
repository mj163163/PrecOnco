library(keras)
library(GSEABase)
library(GSVA)
library(impute)

##Source function for drug response prediction
source("DrugsPred.R")

##Load tpm gene expression matrix
load("SRP040309_log_tpm.Rdata")

##Extracting samples to make preictions
untreat = df1[,1:5]
Stress = df1[,6:10]
Drug = df1[,11:15]

##average gene expression of cells of same type
expAve1 = as.matrix(apply(untreat,1,mean))
cluster1_ave = expAve1

expAve2 = as.matrix(apply(Stress,1,mean))
cluster2_ave = expAve2

expAve3 = as.matrix(apply(Drug,1,mean))
cluster3_ave = expAve3
df = cbind(cluster1_ave,cluster2_ave,cluster3_ave)

##Running GSVA
geneSets = getGmt("c2.cp.v6.1.symbols.gmt")
enrichment.scores <- gsva(df, geneSets, method="gsva")
colnames(enrichment.scores) = c("Untreated","Stressed","Drugtolerant")


##loading metadata file
load("GDSC2_metadata.RData")

##Making predictions
df1 = drugPred(enrichment.scores,metadata,"BRCA")
