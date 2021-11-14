##loading libraries
library(RColorBrewer)
library(pheatmap)


##Loading predictions
df = read.table("unseen_drugs_ATTX_samples.csv",sep=",",header = T,stringsAsFactors = F,row.names = 1,check.names = F)

##Loading metadata files
meta = read.csv("metadata.csv",sep=",",row.names=1,stringsAsFactors = F,header=T)


##processing of data for plotting heatmap
ann_colors = list(
  Clusters = c(Cluster1="mediumorchid1",Cluster2="deeppink",Cluster3="royalblue1"),
  Samples = c("PRE-CX"="#984EA3","POST-CX"="#FF7F00",CRPC="#E41A1C",ENZS="#4DAF4A",ENZR="#377EB8"))

cols = colorRampPalette(c("blue", "white","grey20"))(100)



pheatmap(df,fontsize_col = 7,col= cols,angle_col = 45,fontsize_row = 10,cluster_cols = F,annotation_colors = ann_colors,cluster_rows=F,annotation_col  = meta,annotation_names_row = F,clustering_distance_rows = "euclidean",
         clustering_distance_cols = "euclidean",cellheight = 15,cellwidth = 9)
