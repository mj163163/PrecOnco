##loading libraries
library(ggplot2)

##loading predictions
Predictions = read.csv("ATTX_predictions.csv",sep=",",header = T,stringsAsFactors = F,row.names = 1)

##loading metadata
metadata = read.csv("metadata.csv",sep=",",header = T,stringsAsFactors = F,row.names = 1)

pred = t(Predictions)

df = merge(pred,metadata,by=0)
mat = reshape2::melt(df)

##plotting
p <- ggplot(mat, aes(x=Clusters, y=value,col=Clusters)) + 
  geom_boxplot(outlier.shape = NA)
p +theme_classic(base_size = 20) +scale_color_manual(values=c(Cluster1="mediumorchid1",Cluster2="deeppink",Cluster3="royalblue1"))+theme(axis.text.x = element_text(angle = 45, hjust=1))+
ylab("Predicted Z-score (IC50)")
                                                                                                                                                                                                  
