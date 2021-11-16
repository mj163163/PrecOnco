#' Title Drug response prediction using model trained on TCGA patient profiles 
#'
#' @param enrichment.scores pathway enrichment scores obtained using GSVA
#' @param metadata metadata file containing drug molecular descriptors
#' @param CancerType Cancer type to be used for input test dataset
#'
#' @return list of multiple data frames consisting of probability of response & probability of non-response along with predicted class label.
#' @export
#'
#' @examples drugPred(enrichment.scores,metadata,"SKCM")
drugPred = function(enrichment.scores,metadata,CancerType){

pred = list()
for (i in 1:ncol(enrichment.scores)){
  expAve = as.matrix(enrichment.scores[,i])
  features = model1@parameters$x
  common_features = intersect(c(rownames(expAve),colnames(metadata)),(features))
  Final_Index= which(metadata$Cancer %in% CancerType)
  metainfo = metadata[Final_Index, ]  
  col=dim(metainfo)[1]
  output=sapply(features, function(x){
    if(x %in% common_features)
    {
      if(x %in% colnames(metainfo))
      {temp=metainfo[,x]}
      else if(x %in% rownames(expAve))
      {temp=rep(expAve[x,],col)}
    }else
    {
      temp=rep(NA,col)
      
    }
    return(temp)
    
  })
  
  impdata = impute.knn(t(output[,1:1327]))
  xtest = cbind(t(impdata$data),output[,1328:ncol(output)])
  test = as.h2o(xtest)
  prediction <- as.data.frame(h2o.predict(model1, test))
  pred[[i]]= unique(cbind.data.frame(metainfo$drug.name,prediction$p1))
}
return(pred)
}