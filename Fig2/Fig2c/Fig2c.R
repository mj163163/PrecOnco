##Loading libraries
library(keras)
library(impute)
library(tidyverse)
library(pheatmap)
library(ggpubr)


##Source function
source("DrugsPred.R")

##loading data
load("enrichment.scores.Rdata")

##loading metadata
load("GDSC2_metadata.RData")

df1 = drugPred(enrichment.scores,metadata,"PRAD")

##Reduce list to dataframe
Pred=df1 %>% reduce(left_join, by = "DRUGS")

###Scatter plots
LNCAP_gdsc = read.table("Cellline_downloadThu May 27 06_22_01 2021_LNCAP.csv",sep=",",header=T,row.names = 1,stringsAsFactors = F)
LNCAP_gdsc = aggregate(Z.Score~Drug.Name,LNCAP_gdsc,function(x) x[which.min((x))])
colnames(LNCAP_gdsc)[1] = "DRUGS"

##LNCAP1
LNCAP1 = Pred[,c(1,4)]
mat1 = merge(LNCAP_gdsc,LNCAP1,by="DRUGS")
colnames(mat1) = c("DRUGS","Real","Predicted")

##LNCAP2
mat2 = Pred[,c(1,5)]
mat2 = merge(LNCAP_gdsc,mat2,by="DRUGS")
colnames(mat2) = c("DRUGS","Real","Predicted")

###Scatter plot
group = c(rep("LNCAP.1",154),rep("LNCAP.2",154))

df = rbind.data.frame(mat1,mat2)
df1 = cbind(df,group)

ggscatter(df1, x = "Real", y = "Predicted",
            add = "reg.line",                         # Add regression line
            conf.int = TRUE,cor.coef.size = 5 ,                         # Add confidence interval
            color = "group", palette = c("red","blue"),           # Color by groups "cyl"
            shape = "group"                        # Change point shape by groups "cyl"
)+stat_cor(aes(color = group))  
