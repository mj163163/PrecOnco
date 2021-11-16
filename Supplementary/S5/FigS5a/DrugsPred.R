#' Title Provides drug response predictions in terms of Z-score (IC50)
#'
#' @param enrichment.scores Pathway enrichment scores computed using GSVA
#' @param metadata Metadata file contaiing information about cell lines and drugs along with molecular descriptors
#' @param CancerType Cancer type to be used for input test dataset
#'
#' @return list of multiple data frames containing predicted Z-scores (LN IC50) values for each sample in the input test dataset
#' @export
#'
#' @examples drugPred(enrichment.scores,metadata,"PRAD")
drugPred = function(enrichment.scores,metadata,CancerType){
  
pred = list()
for (i in 1:ncol(enrichment.scores)){
  expAve = as.matrix(enrichment.scores[,i])
  features = read.table("Features.csv",sep=",")[,1]
  common_features = intersect(c(rownames(expAve),colnames(metadata)),(features))
  Final_Index= which(metadata$TCGA_DESC %in% CancerType)
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
  
  impdata = impute.knn(t(output[,1:1329]))
  xtest = cbind(t(impdata$data),output[,1330:ncol(output)])
  
  model1 = load_model_hdf5("Model1.hdf5")
  model2 = load_model_hdf5("Model2.hdf5")
  model3 = load_model_hdf5("Model3.hdf5")
  model4 = load_model_hdf5("Model4.hdf5")
  model5 = load_model_hdf5("Model5.hdf5")
  model6 = load_model_hdf5("Model6.hdf5")
  model7 = load_model_hdf5("Model7.hdf5")
  model8 = load_model_hdf5("Model8.hdf5")
  model9 = load_model_hdf5("Model9.hdf5")
  model10 = load_model_hdf5("Model10.hdf5")
  
  prediction1=model1 %>% predict(xtest)
  prediction2=model2 %>% predict(xtest)
  prediction3=model3 %>% predict(xtest)
  prediction4=model4 %>% predict(xtest)
  prediction5=model5 %>% predict(xtest)
  prediction6=model6 %>% predict(xtest)
  prediction7=model7 %>% predict(xtest)
  prediction8=model8 %>% predict(xtest)
  prediction9=model9 %>% predict(xtest)
  prediction10=model10 %>% predict(xtest)
  predictions = apply(cbind.data.frame(prediction1,prediction2,prediction3,prediction4,prediction5,prediction6,prediction7,prediction8,prediction9,prediction10),1,mean)
  
  predictions=formatC(predictions)
  predictions = as.numeric(predictions)
  
  data = cbind.data.frame(metainfo$DRUG_NAME,predictions)
  colnames(data) = c("DRUGS","Predictedvalue")
  mat=setDT(data)[, .SD[which.min(Predictedvalue)], by=DRUGS]
  mat = as.data.frame(mat)
  colnames(mat)[2] = colnames(enrichment.scores)[i]
  pred[[i]] = mat[order(mat[,2]), ]
}
return(pred)
}