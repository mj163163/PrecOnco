##loading libraries
library(pheatmap)

##loading predictions
predictions = read.csv("ATTX_predictions.csv",sep=",",header = T,stringsAsFactors = F,row.names = 1,check.names = F)

##loading metadata
metadata = read.csv("metadata.csv",sep=",",header = T,stringsAsFactors = F,row.names = 1)
meta = metadata[colnames(predictions),]


####Plotting heatmap
pathways = read.csv("GDSC2_targeted_pathways.csv",sep=",",header = T,stringsAsFactors = F)
pos = which(pathways$X %in% rownames(predictions))
pathways = unique(pathways[pos,c(1,3)])
rownames(pathways) = pathways[,1]


ann_row1 = merge(pathways,predictions,by=0)
ann_row1= ann_row1[order(ann_row1$Pathways), , drop = FALSE]


mat = ann_row1[,4:ncol(ann_row1)]
rownames(mat) = ann_row1[,1]
ann_row = as.data.frame(ann_row1[,c(3)])
rownames(ann_row) = ann_row1[,1]
colnames(ann_row) = "Pathways"
ann_row$Pathways = as.factor(ann_row$Pathways)
ann_row$Pathways <- ifelse(ann_row$Pathways=="EGFR signaling", "EGFR signaling", NA)

ann_colors = list(
  Clusters = c(Cluster1="mediumorchid1",Cluster2="deeppink",Cluster3="royalblue1"),
  Samples = c(CRPC="#E41A1C",ENZR="#377EB8",ENZS="#4DAF4A","PRE-CX"="#984EA3","POST-CX"="#FF7F00"),
  Pathways=c("EGFR signaling" = "#FBCED0")
)

colnames(mat) = sub("ATTX.","",colnames(mat))
rownames(meta) = sub("ATTX.","",rownames(meta))


pheatmap(mat,fontsize_col = 6,col= rev(hcl.colors(20, "Spectral")),angle_col = 45,fontsize_row = 10,cluster_cols = T,annotation_colors = ann_colors,annotation_row = ann_row,cluster_rows=F,annotation_col = meta,annotation_names_row = F,clustering_distance_rows = "euclidean",
         clustering_distance_cols = "euclidean" ,show_rownames = F,fontsize = 8)


