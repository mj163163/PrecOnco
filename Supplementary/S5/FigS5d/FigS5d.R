##Loading libraries
library(keras)
library(impute)
library(tidyverse)
library(reshape2)
library(ggridges)
library(ggplot2)
library(data.table)

##source function
source("DrugsPred.R")

##loading data
load("enrichment.scores.Rdata")

##Aveeraging GSVA scores of biological replicates
enrichment.scores =t(apply(enrichment.scores, 1, function(x) tapply(x, colnames(enrichment.scores), mean)))

##loading metadata file
load("GDSC2_metadata.RData")

##Drug response prediction
df1 = drugPred(enrichment.scores,metadata,"PRAD")

Pred=df1 %>% reduce(left_join, by = "DRUGS")


###Subsetting PI3K/MTOR signaling drugs
pathways = read.csv("GDSC2_targeted_pathways.csv",sep=",",header = T,stringsAsFactors = F)
pos = which((pathways[,1]) %in% Pred[,1])
pathways=pathways[pos,]

pos = which(pathways$Pathways =="EGFR signaling")
pathways = pathways[pos,]

dr = as.vector(pathways[,1])
pos = which(Pred[,1] %in% dr)
mat = Pred[pos,]

##data preparation
final = melt(mat)
final$variable<-gsub('ATT.','',final$variable)
final$col <- ifelse(final$DRUGS %in% c("Afatinib","Gefitinib"), "darkred", "ivory4")
final$shape <- ifelse(final$DRUGS == "Afatinib",17,19) 
final <- within(final, shape[DRUGS == 'Gefitinib' & shape == 19] <- 15)
shape = as.numeric(final$shape)
names(shape) = final$DRUGS
final$variable <- factor(final$variable,
                         levels = c('VEH','APA.VEH','BIC.VEH','ENZ.VEH','DHT','APA.DHT','BIC.DHT','ENZ.DHT'),ordered = TRUE)

##Ploting
ggplot(final, aes(x=variable, y=value))+ 
  geom_boxplot(lwd=0.3,fatten=4,alpha=0.2,outlier.shape=NA)+ 
  geom_point(aes(color=col,shape= DRUGS), position=position_jitter(width=0.15, height=0.0,seed=1),size=1,alpha=0.8,stroke=1)+ scale_shape_manual(values =shape)+
  scale_colour_identity()+ 
  theme_classic(base_size = 20) + theme(axis.text.x = element_text(angle = 45, hjust=1,size=10),axis.text.y = element_text(size=10))+ylab("Prdicted Z-score (IC50) EGFR signaling")
