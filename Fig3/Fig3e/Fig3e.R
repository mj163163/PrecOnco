##loading libraries
library(ggridges)
library(ggplot2)

##loading predictions
Predictions = read.csv("ATTX_predictions.csv",sep=",",header = T,stringsAsFactors = F,check.names = F)
pred = reshape2::melt(Predictions)


##loading metadata
metadata = read.csv("metadata.csv",sep=",",header = T,stringsAsFactors = F,check.names = F)
colnames(metadata)[1] = "variable"

##Preparing data
df1 = merge(pred,metadata,by="variable")



df1$Samples <- factor(df1$Samples, levels = c("PRE-CX", "POST-CX","CRPC","ENZS" ,"ENZR"))


df1 %>%
  ggplot( aes(y=Samples, x=value,  fill=Samples)) +
  geom_density_ridges_gradient() +
  theme_classic(base_size = 35) + scale_fill_manual( values=c("PRE-CX"="#984EA3","POST-CX"="#FF7F00",CRPC="#E41A1C",ENZS="#4DAF4A",ENZR="#377EB8"))
