##Loading libraries
library(keras)
library(caret)
library(ggpubr)

##Loading DNN bootstrapped models
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


##Loading test dataset
load("Test_dataset.Rdata")

##Extract explanatory variables from test dataset
xtest = as.matrix(test[,1:1429])

##Extract actual response variable from test dataset
labels = test[,1430]


##Making predictions
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


##Averaging out predictions
predictions = apply(cbind.data.frame(prediction1,prediction2,prediction3,prediction4,prediction5,prediction6,prediction7,prediction8,prediction9,prediction10),1,mean)



##computing metrics
perf = data.frame(
  Rsquare = R2(predictions,labels),
  correlation = cor(predictions, labels)
  
)


##Plotting sensity scatter plot for actual vs predicted labels
df = cbind.data.frame(labels,predictions)
colnames(df) = c("Actual","Predicted")

get_density <- function(x, y, ...) {
  dens <- MASS::kde2d(x, y, ...)
  ix <- findInterval(x, dens$x)
  iy <- findInterval(y, dens$y)
  ii <- cbind(ix, iy)
  return(dens$z[ii])
}
df$density <- get_density(df$Actual, df$Predicted,n=50)
g=ggscatter(df, x = "Actual", y = "Predicted", 
            add = "reg.line", conf.int = TRUE, 
            cor.coef = TRUE, cor.method = "pearson",color = "density",
            xlab = "GDSC Z-score", ylab = " Predicted Z-score",add.params = list(color="black"),cor.coef.size = 10)
g+  scale_colour_gradientn(colours = terrain.colors(10))+theme_classic() +theme(axis.text=element_text(size=25))






