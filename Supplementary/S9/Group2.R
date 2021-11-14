##loading libraries
library(tibble)
library(ggplot2)


##loading predictions for group 1
group2 = read.csv("Group2.csv",sep=",",header=T,stringsAsFactors = F,row.names = 1)

#data processing
load("metadata_TCGA.RData")
colnames(metadata)[3]="submitter_id"

df = merge(group2,metadata,by="submitter_id")
df1 = df[,c(1,2,3,4,13,14)]
df1$label <- ifelse(df1$label=="responder", 1, 0)
cm = df1[,c(2,6)]
colnames(cm) = c("Predicted","Actual")

basic_table <- table(cm)

cfm <- as_tibble(basic_table)
cfm = as.data.frame(cfm)
ggplot(data =  cfm, mapping = aes(x = Actual, y = Predicted)) +
  geom_tile(aes(fill = n)) +geom_text(aes(label = sprintf("%1.0f", n)), vjust = 1)+
  scale_fill_gradient2(low = ("lightblue"),mid="white", high = muted("navyblue")) +theme_bw(base_size = 20) +theme(axis.text=element_text(size=20))

