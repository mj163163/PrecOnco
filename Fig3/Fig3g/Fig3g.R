##loading libraries
library(ggplot2)

##loading predictions
Predictions = read.csv("ATTX_predictions.csv",sep=",",header = T,stringsAsFactors = F,row.names = 1,check.names=F)
pos = which(rownames(Predictions) %in% c("Afatinib","AZD3759","Erlotinib","Gefitinib","Lapatinib","Osimertinib","Sapitinib"))
Predictions = Predictions[pos,]

pred = reshape2::melt(Predictions)


##loading metadata
metadata = read.csv("metadata.csv",sep=",",header = T,stringsAsFactors = F)
colnames(metadata)[1] = "variable"

##Preparing data
df = merge(pred,metadata,by="variable")
df$Samples <- factor(df$Samples, levels = c("PRE-CX", "POST-CX","CRPC","ENZS" ,"ENZR"))

##plotting
ggplot(df, aes(x=Samples, y=value,col=Samples)) + 
  geom_boxplot(outlier.shape = NA)+scale_color_manual(values=c("PRE-CX"="#984EA3","POST-CX"="#FF7F00",CRPC="#E41A1C",ENZS="#4DAF4A",ENZR="#377EB8"))+theme_classic(base_size = 20)+theme(axis.text.x = element_text(angle = 45, hjust=1))+ylab("Predicted Z-score (IC50)")

