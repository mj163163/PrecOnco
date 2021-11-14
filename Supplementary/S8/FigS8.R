##loading libraries
library(corrplot)
library(pheatmap)

##Group 1
group1 = read.csv("Group1.csv",sep=",",header=T,stringsAsFactors = F)
g1=xtabs(Freq ~ Stage + Cancer, group1)
cols = colorRampPalette(c("white", "grey","pink","coral"))(100)
pheatmap(g1,cluster_rows = F,cluster_cols = F,cellwidth = 20,cellheight = 20,display_numbers = T,col=cols,number_format="%.0f",border_color = "black",fontsize = 15)




##Group 2
group2 = read.csv("Group2.csv",sep=",",header=T,stringsAsFactors = F)
g2=xtabs(Freq ~ Stage + Cancer, group2)
cols = colorRampPalette(c("white", "grey","pink","coral"))(100)
pheatmap(g2,cluster_rows = F,cluster_cols = F,cellwidth = 20,cellheight = 20,display_numbers = T,col=cols,number_format="%.0f",border_color = "black",fontsize = 15)

