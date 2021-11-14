##Loading libraries
library(GSVA)
library(GSEABase)
library(keras)
library(impute)
library(tidyverse)
library(ggplot2)
library(ggridges)

##Source function
source("DrugsPred.R")

##loading data
load("enrichment.scores.Rdata")

##loading metadata
load("GDSC2_metadata.RData")

df1 = drugPred(enrichment.scores,metadata,"PRAD")

##Reduce list to dataframe
Pred=df1 %>% reduce(left_join, by = "DRUGS")
Predictions = Pred[,2:ncol(Pred)]
rownames(Predictions) = Pred[,1]
colnames(Predictions)<-gsub('FBS.','',colnames(Predictions))


##Ridgplot
library(dplyr)
library(tidyr)
library(forcats)
library(viridis)

df = reshape2::melt(Predictions)
df$variable = gsub("\\..*","",df$variable)

df %>%
  ggplot( aes(y=variable, x=value,  fill=variable)) +
  geom_density_ridges_gradient() +
  theme_classic(base_size = 35) + scale_fill_manual( values=c("DU145"="#A6CEE3","LNCAP"="#1F78B4","PC3"="#B2DF8A","DUCAP"="#33A02C","VCAP"="#FB9A99"))
